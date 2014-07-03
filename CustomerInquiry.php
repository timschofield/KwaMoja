<?php

include('includes/SQL_CommonFunctions.inc');

include('includes/session.inc');
$Title = _('Customer Inquiry');
/* Manual links before header.inc */
$ViewTopic = 'ARInquiries';
$BookMark = 'CustomerInquiry';
include('includes/header.inc');

// always figure out the SQL required from the inputs available

if (!isset($_GET['CustomerID']) and !isset($_SESSION['CustomerID'])) {
	prnMsg(_('To display the enquiry a customer must first be selected from the customer selection screen'), 'info');
	echo '<br /><div class="centre"><a href="' . $RootPath . '/SelectCustomer.php">' . _('Select a Customer to Inquire On') . '</a><br /></div>';
	include('includes/footer.inc');
	exit;
} else {
	if (isset($_GET['CustomerID'])) {
		$_SESSION['CustomerID'] = stripslashes($_GET['CustomerID']);
	}
	$CustomerID = $_SESSION['CustomerID'];
}

if (!isset($_POST['TransAfterDate'])) {
	$sql = "SELECT confvalue
			FROM `config`
			WHERE confname ='NumberOfMonthMustBeShown'";
	$ErrMsg = _('The config value NumberOfMonthMustBeShown cannot be retrieved');
	$result = DB_query($sql, $ErrMsg);
	$row = DB_fetch_array($result);
	$_POST['TransAfterDate'] = Date($_SESSION['DefaultDateFormat'], Mktime(0, 0, 0, Date('m') - $row['confvalue'], Date('d'), Date('Y')));
}

$SQL = "SELECT debtorsmaster.name,
		currencies.currency,
		currencies.decimalplaces,
		paymentterms.terms,
		debtorsmaster.creditlimit,
		holdreasons.dissallowinvoices,
		holdreasons.reasondescription,
		SUM(debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount
- debtortrans.alloc) AS balance,
		SUM(CASE WHEN (paymentterms.daysbeforedue > 0) THEN
			CASE WHEN (TO_DAYS(Now()) - TO_DAYS(debtortrans.trandate)) >= paymentterms.daysbeforedue
			THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount - debtortrans.alloc ELSE 0 END
		ELSE
			CASE WHEN TO_DAYS(Now()) - TO_DAYS(DATE_ADD(DATE_ADD(debtortrans.trandate, " . INTERVAL('1', 'MONTH') . "), " . INTERVAL('(paymentterms.dayinfollowingmonth - DAYOFMONTH(debtortrans.trandate))', 'DAY') . ")) >= 0 THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount - debtortrans.alloc ELSE 0 END
		END) AS due,
		SUM(CASE WHEN (paymentterms.daysbeforedue > 0) THEN
			CASE WHEN TO_DAYS(Now()) - TO_DAYS(debtortrans.trandate) > paymentterms.daysbeforedue
			AND TO_DAYS(Now()) - TO_DAYS(debtortrans.trandate) >= (paymentterms.daysbeforedue + " . $_SESSION['PastDueDays1'] . ")
			THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount - debtortrans.alloc ELSE 0 END
		ELSE
			CASE WHEN (TO_DAYS(Now()) - TO_DAYS(DATE_ADD(DATE_ADD(debtortrans.trandate, " . INTERVAL('1', 'MONTH') . "), " . INTERVAL('(paymentterms.dayinfollowingmonth - DAYOFMONTH(debtortrans.trandate))', 'DAY') . ")) >= " . $_SESSION['PastDueDays1'] . ")
			THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount
			- debtortrans.alloc ELSE 0 END
		END) AS overdue1,
		SUM(CASE WHEN (paymentterms.daysbeforedue > 0) THEN
			CASE WHEN TO_DAYS(Now()) - TO_DAYS(debtortrans.trandate) > paymentterms.daysbeforedue
			AND TO_DAYS(Now()) - TO_DAYS(debtortrans.trandate) >= (paymentterms.daysbeforedue + " . $_SESSION['PastDueDays2'] . ") THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount - debtortrans.alloc ELSE 0 END
		ELSE
			CASE WHEN (TO_DAYS(Now()) - TO_DAYS(DATE_ADD(DATE_ADD(debtortrans.trandate, " . INTERVAL('1', 'MONTH') . "), " . INTERVAL('(paymentterms.dayinfollowingmonth - DAYOFMONTH(debtortrans.trandate))', 'DAY') . ")) >= " . $_SESSION['PastDueDays2'] . ") THEN debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount - debtortrans.alloc ELSE 0 END
		END) AS overdue2
		FROM debtorsmaster,
	 			paymentterms,
	 			holdreasons,
	 			currencies,
	 			debtortrans
		WHERE  debtorsmaster.paymentterms = paymentterms.termsindicator
	 		AND debtorsmaster.currcode = currencies.currabrev
	 		AND debtorsmaster.holdreason = holdreasons.reasoncode
	 		AND debtorsmaster.debtorno = '" . $CustomerID . "'
     		AND debtorsmaster.debtorno = debtortrans.debtorno";

if ($_SESSION['SalesmanLogin'] != '') {
	$SQL .= " AND debtortrans.salesperson='" . $_SESSION['SalesmanLogin'] . "'";
}

$SQL .= " GROUP BY debtorsmaster.name,
			currencies.currency,
			paymentterms.terms,
			paymentterms.daysbeforedue,
			paymentterms.dayinfollowingmonth,
			debtorsmaster.creditlimit,
			holdreasons.dissallowinvoices,
			holdreasons.reasondescription";

$ErrMsg = _('The customer details could not be retrieved by the SQL because');
$CustomerResult = DB_query($SQL, $ErrMsg);

if (DB_num_rows($CustomerResult) == 0) {

	/*Because there is no balance - so just retrieve the header information about the customer - the choice is do one query to get the balance and transactions for those customers who have a balance and two queries for those who don't have a balance OR always do two queries - I opted for the former */

	$NIL_BALANCE = True;

	$SQL = "SELECT debtorsmaster.name,
					debtorsmaster.currcode,
					currencies.currency,
					currencies.decimalplaces,
					paymentterms.terms,
					debtorsmaster.creditlimit,
					holdreasons.dissallowinvoices,
					holdreasons.reasondescription
			FROM debtorsmaster INNER JOIN paymentterms
			ON debtorsmaster.paymentterms = paymentterms.termsindicator
			INNER JOIN currencies
			ON debtorsmaster.currcode = currencies.currabrev
			INNER JOIN holdreasons
			ON debtorsmaster.holdreason = holdreasons.reasoncode
			WHERE debtorsmaster.debtorno = '" . $CustomerID . "'";

	$ErrMsg = _('The customer details could not be retrieved by the SQL because');
	$CustomerResult = DB_query($SQL, $ErrMsg);

} else {
	$NIL_BALANCE = False;
}

$CustomerRecord = DB_fetch_array($CustomerResult);

if ($NIL_BALANCE == True) {
	$CustomerRecord['balance'] = 0;
	$CustomerRecord['due'] = 0;
	$CustomerRecord['overdue1'] = 0;
	$CustomerRecord['overdue2'] = 0;
}

echo '<div class="toplink"><a href="' . $RootPath . '/SelectCustomer.php">' . _('Back to Customer Screen') . '</a></div>';

echo '<p class="page_title_text"><img src="' . $RootPath . '/css/' . $Theme . '/images/customer.png" title="' . _('Customer') . '" alt="" /> ' .
	_('Customer') . ': ' .
		stripslashes($CustomerID) . ' - ' . $CustomerRecord['name'] . '<br />' .
	_('All amounts stated in') . ': ' .
		$CustomerRecord['currency'] . '<br />' . // To be replaced by:
	_('Terms') . ': ' .
		$CustomerRecord['terms'] . '<br />' .
	_('Credit Limit') . ': ' .
		locale_number_format($CustomerRecord['creditlimit'],0) . '<br />' .
	_('Credit Status') . ': ' .
		$CustomerRecord['reasondescription'] . '</p>';

if ($CustomerRecord['dissallowinvoices'] != 0) {
	echo '<br /><font color="red" size="4"><b>' . _('ACCOUNT ON HOLD') . '</font></b><br />';
}

echo '<table class="selection" width="70%">
	<tr>
		<th style="width:20%">' . _('Total Balance') . '</th>
		<th style="width:20%">' . _('Current') . '</th>
		<th style="width:20%">' . _('Now Due') . '</th>
		<th style="width:20%">' . $_SESSION['PastDueDays1'] . '-' . $_SESSION['PastDueDays2'] . ' ' . _('Days Overdue') . '</th>
		<th style="width:20%">' . _('Over') . ' ' . $_SESSION['PastDueDays2'] . ' ' . _('Days Overdue') . '</th></tr>';

echo '<tr>
		<td class="number">' . locale_number_format($CustomerRecord['balance'], $CustomerRecord['decimalplaces']) . '</td>
		<td class="number">' . locale_number_format(($CustomerRecord['balance'] - $CustomerRecord['due']), $CustomerRecord['decimalplaces']) . '</td>
		<td class="number">' . locale_number_format(($CustomerRecord['due'] - $CustomerRecord['overdue1']), $CustomerRecord['decimalplaces']) . '</td>
		<td class="number">' . locale_number_format(($CustomerRecord['overdue1'] - $CustomerRecord['overdue2']), $CustomerRecord['decimalplaces']) . '</td>
		<td class="number">' . locale_number_format($CustomerRecord['overdue2'], $CustomerRecord['decimalplaces']) . '</td>
	</tr>
	</table>';

echo '<br />
	<div class="centre">
		<form onSubmit="return VerifyForm(this);" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post" class="noPrint">
		<div>
		<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />' . _('Show all transactions after') . ':
		<input tabindex="1" type="text" required="required" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" id="datepicker" name="TransAfterDate" value="' . $_POST['TransAfterDate'] . '" minlength="0" maxlength="10" size="12" />
		<input tabindex="2" type="submit" name="Refresh Inquiry" value="' . _('Refresh Inquiry') . '" />
		</div>
	</form>
	</div>
	<br />';

$DateAfterCriteria = FormatDateForSQL($_POST['TransAfterDate']);

$SQL = "SELECT systypes.typename,
				debtortrans.id,
				debtortrans.type,
				debtortrans.transno,
				debtortrans.branchcode,
				debtortrans.trandate,
				debtortrans.reference,
				debtortrans.invtext,
				debtortrans.order_,
				salesorders.customerref,
				debtortrans.rate,
				(debtortrans.ovamount + debtortrans.ovgst + debtortrans.ovfreight + debtortrans.ovdiscount) AS totalamount,
				debtortrans.alloc AS allocated
			FROM debtortrans
			INNER JOIN systypes
				ON debtortrans.type = systypes.typeid
			LEFT JOIN salesorders
				ON salesorders.orderno=debtortrans.order_
			WHERE debtortrans.debtorno = '" . $CustomerID . "'
				AND debtortrans.trandate >= '" . $DateAfterCriteria . "'";

if ($_SESSION['SalesmanLogin'] != '') {
	$SQL .= " AND debtortrans.salesperson='" . $_SESSION['SalesmanLogin'] . "'";
}

$SQL .= " ORDER BY debtortrans.id";

$ErrMsg = _('No transactions were returned by the SQL because');
$TransResult = DB_query($SQL, $ErrMsg);

if (DB_num_rows($TransResult) == 0) {
	echo '<div class="centre">' . _('There are no transactions to display since') . ' ' . $_POST['TransAfterDate'] . '</div>';
	include('includes/footer.inc');
	exit;
}
/*show a table of the invoices returned by the SQL */

echo '<table class="selection">
		<tr>
			<th>' . _('Type') . '</th>
			<th>' . _('Number') . '</th>
			<th>' . _('Date') . '</th>
			<th>' . _('Branch') . '</th>
			<th>' . _('Reference') . '</th>
			<th>' . _('Cust Order') . '</th>
			<th>' . _('Comments') . '</th>
			<th>' . _('Order') . '</th>
			<th>' . _('Total') . '</th>
			<th>' . _('Allocated') . '</th>
			<th>' . _('Balance') . '</th>
			<th>' . _('More Info') . '</th>
			<th>' . _('More Info') . '</th>
			<th>' . _('More Info') . '</th>
			<th>' . _('More Info') . '</th>
			<th>' . _('More Info') . '</th>
		</tr>';

$k = 0; //row colour counter
while ($MyRow = DB_fetch_array($TransResult)) {

	if ($k == 1) {
		echo '<tr class="EvenTableRows">';
		$k = 0;
	} else {
		echo '<tr class="OddTableRows">';
		$k = 1;
	}

	$FormatedTranDate = ConvertSQLDate($MyRow['trandate']);

	if ($_SESSION['InvoicePortraitFormat'] == 1) { //Invoice/credits in portrait
		$PrintCustomerTransactionScript = 'PrintCustTransPortrait.php';
	} else { //produce pdfs in landscape
		$PrintCustomerTransactionScript = 'PrintCustTrans.php';
	}

	$BaseFormatString = '<td>%s</td>
						<td>%s</td>
						<td>%s</td>
						<td>%s</td>
						<td>%s</td>
						<td>%s</td>
						<td style="width:200px">%s</td>
						<td>%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td>';


	$CreditInvoiceFormatString = '<td><a href="%s/Credit_Invoice.php?InvoiceNumber=%s">' . _('Credit ') . '<img src="%s/credit.png" title="' . _('Click to credit the invoice') . '" alt="" /></a></td>';

	$PreviewInvoiceFormatString = '<td>
										<a href="%s/PrintCustTrans.php?FromTransNo=%s&amp;InvOrCredit=Invoice">' . _('HTML ') . '<img src="%s/preview.gif" title="' . _('Click to preview the invoice') . '" alt="" /></a>
									</td>
									<td>
										<a href="%s/%s?FromTransNo=%s&amp;InvOrCredit=Invoice&amp;PrintPDF=True">' . _('PDF ') . '<img src="%s/css/' . $Theme . '/images/pdf.png" title="' . _('Click for PDF') . '" alt="" /></a>
									</td>
									<td>
										<a href="%s/EmailCustTrans.php?FromTransNo=%s&amp;InvOrCredit=Invoice">' . _('Email ') . '<img src="%s/email.png" title="' . _('Click to email the invoice') . '" alt="" /></a>
									</td>';

	$PreviewCreditFormatString = '<td>
										<a href="%s/PrintCustTrans.php?FromTransNo=%s&amp;InvOrCredit=Credit">' . _('HTML ') . ' <IMG SRC="%s/preview.gif" title="' . _('Click to preview the credit note') . '" /></a>
									</td>
									<td>
										<a href="%s/%s?FromTransNo=%s&amp;InvOrCredit=Credit&amp;PrintPDF=True">' . _('PDF ') . '<img src="%s/css/' . $Theme . '/images/pdf.png" title="' . _('Click for PDF') . '" alt="" /></a>
									/td>
									<td>
										<a href="%s/EmailCustTrans.php?FromTransNo=%s&amp;InvOrCredit=Credit">' . _('Email') . ' <img src="%s/email.png" title="' . _('Click to email the credit note') . '" alt="" /></a>
									</td>';

	/* assumed allowed page security token 3 allows the user to create credits for invoices */
	if (in_array($_SESSION['PageSecurityArray']['Credit_Invoice.php'], $_SESSION['AllowedPageSecurityTokens']) and $MyRow['type'] == 10) {
		/*Show a link to allow an invoice to be credited */

		/* assumed allowed page security token 8 allows the user to see GL transaction information */
		if ($_SESSION['CompanyRecord']['gllink_debtors'] == 1 and in_array(8, $_SESSION['AllowedPageSecurityTokens'])) {

			/* format string with GL inquiry options and for invoice to be credited */

			printf($BaseFormatString .
					$CreditInvoiceFormatString .
					$PreviewInvoiceFormatString . '
					<td>
						<a href="%s/GLTransInquiry.php?TypeID=%s&amp;TransNo=%s">' . _('View GL Entries') . '<img src="' . $RootPath . '/css/' . $Theme . '/images/gl.png" title="' . _('View the GL Entries') . '" alt="" /></a>
					</td>
				</tr>',
			//$BaseFormatString parameters
				$MyRow['typename'],
				$MyRow['transno'],
				ConvertSQLDate($MyRow['trandate']),
				$MyRow['branchcode'],
				$MyRow['reference'],
				$MyRow['customerref'],
				$MyRow['invtext'],
				$MyRow['order_'],
				locale_number_format($MyRow['totalamount'],
				$CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['allocated'],
				$CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
			//$CreditInvoiceFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
			//$PreviewInvoiceFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
				$RootPath,
				$PrintCustomerTransactionScript,
				$MyRow['transno'],
				$RootPath,
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
			//Parameter for string for GL Trans Inquiries
				$RootPath,
				$MyRow['type'],
				$MyRow['transno']);
		} else { //user does not have privileges to see GL inquiry stuff

			printf($BaseFormatString .
					$CreditInvoiceFormatString .
					$PreviewInvoiceFormatString . '
				</tr>',
			//BaseFormatString parameters
				$MyRow['typename'],
				$MyRow['transno'],
				ConvertSQLDate($MyRow['trandate']),
				$MyRow['branchcode'],
				$MyRow['reference'],
				$MyRow['customerref'],
				$MyRow['invtext'],
				$MyRow['order_'],
				locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
			//CreditInvoiceFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
			//$PreviewInvoiceFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
				$RootPath,
				$PrintCustomerTransactionScript,
				$MyRow['transno'],
				$RootPath,
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images');
		}

	} elseif ($MyRow['type'] == 10) {
		/*its an invoice but not high enough priveliges to credit it */

		printf($BaseFormatString .
				$PreviewInvoiceFormatString . '
			</tr>',
		//$BaseFormatString parameters
			$MyRow['typename'],
			$MyRow['transno'],
			ConvertSQLDate($MyRow['trandate']),
			$MyRow['branchcode'],
			$MyRow['reference'],
			$MyRow['customeref'],
			$MyRow['invtext'],
			$MyRow['order_'],
			locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
			locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
			locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
		//$PreviewInvoiceFormatString parameters
			$RootPath,
			$MyRow['transno'],
			$RootPath . '/css/' . $Theme . '/images',
			$RootPath,
			$PrintCustomerTransactionScript,
			$MyRow['transno'],
			$RootPath,
			$RootPath,
			$MyRow['transno'],
			$RootPath . '/css/' . $Theme . '/images');

	} elseif ($MyRow['type'] == 11) {
		/*its a credit note */
		if ($_SESSION['CompanyRecord']['gllink_debtors'] == 1 and in_array(8, $_SESSION['AllowedPageSecurityTokens'])) {
			printf($BaseFormatString .
					$PreviewCreditFormatString . '
					<td>
						<a href="%s/CustomerAllocations.php?AllocTrans=%s">' . _('Allocation') . '<img src="' . $RootPath . '/css/' . $Theme . '/images/allocation.png" title="' . _('Click to allocate funds') . '" alt="" /></a>
					</td>
					<td>
						<a href="%s/GLTransInquiry.php?TypeID=%s&amp;TransNo=%s">' . _('View GL Entries') . ' <a><img src="' . $RootPath . '/css/' . $Theme . '/images/gl.png" title="' . _('View the GL Entries') . '" alt="" /></a>
					</td>
				</tr>',
			//$BaseFormatString parameters
				$MyRow['typename'],
				$MyRow['transno'],
				ConvertSQLDate($MyRow['trandate']),
				$MyRow['branchcode'],
				$MyRow['reference'],
				$MyRow['customerref'],
				$MyRow['invtext'],
				$MyRow['order_'],
				locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
			//$PreviewCreditFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
				$RootPath,
				$PrintCustomerTransactionScript,
				$MyRow['transno'],
				$RootPath,
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
			// hand coded format string for Allocations and GLTrans Inquiry parameters
				$RootPath,
				$MyRow['id'],
				$RootPath,
				$MyRow['type'],
				$MyRow['transno']);
		} else {
			printf($BaseFormatString .
					$PreviewCreditFormatString . '
					<td>
						<a href="%s/CustomerAllocations.php?AllocTrans=%s">' . _('Allocation') . '<img src="%s/allocation.png" title="' . _('Click to allocate funds') . '" alt="" /></a>
					</td>
				</tr>',
				$MyRow['typename'],
				$MyRow['transno'],
				ConvertSQLDate($MyRow['trandate']),
				$MyRow['branchcode'],
				$MyRow['reference'],
				$MyRow['customerref'],
				$MyRow['invtext'],
				$MyRow['order_'],
				locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
				locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
			//$PreviewCreditFormatString parameters
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
				$RootPath,
				$PrintCustomerTransactionScript,
				$MyRow['transno'],
				$RootPath,
				$RootPath,
				$MyRow['transno'],
				$RootPath . '/css/' . $Theme . '/images',
			//Parameters for hand coded string to show allocations
				$RootPath,
				$MyRow['id'],
				$RootPath . '/css/' . $Theme . '/images');
		}
	} elseif ($MyRow['type'] == 12 and $MyRow['totalamount'] < 0) {
		/*its a receipt  which could have an allocation*/

		//If security token 8 in the allowed page security tokens then assumed ok for GL trans inquiries
		if ($_SESSION['CompanyRecord']['gllink_debtors'] == 1 and in_array(8, $_SESSION['AllowedPageSecurityTokens'])) {
			printf($BaseFormatString . '
					<td>
						<a href="%s/CustomerAllocations.php?AllocTrans=%s">' . _('Allocation') . '<img src="' . $RootPath . '/css/' . $Theme . '/images/allocation.png" title="' . _('Click to allocate funds') . '" alt="" /></a>
					</td>
					<td>
						<a href="%s/GLTransInquiry.php?TypeID=%s&amp;TransNo=%s">' . _('View GL Entries') . ' <img src="' . $RootPath . '/css/' . $Theme . '/images/gl.png" title="' . _('View the GL Entries') . '" alt="" /></a>
					</td>
				</tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['customerref'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
					$RootPath,
					$MyRow['id'],
					$RootPath,
					$MyRow['type'],
					$MyRow['transno']);
		} else { //no permission for GLTrans Inquiries
			printf($BaseFormatString . '
					<td>
						<a href="%s/CustomerAllocations.php?AllocTrans=%s">' . _('Allocation') . '<img src="' . $RootPath . '/css/' . $Theme . '/images/allocation.png" title="' . _('Click to allocate funds') . '" alt="" /></a>
					</td>
				</tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
					$RootPath,
					$MyRow['id']);
		}
	} elseif ($MyRow['type'] == 12 and $MyRow['totalamount'] > 0) {
		/*its a negative receipt */

		//If security token 8 in the allowed page security tokens then assumed ok for GL trans inquiries
		if ($_SESSION['CompanyRecord']['gllink_debtors'] == 1 and in_array(8, $_SESSION['AllowedPageSecurityTokens'])) {
			printf($BaseFormatString . '
					<td>
						<a href="%s/GLTransInquiry.php?TypeID=%s&amp;TransNo=%s">' . _('View GL Entries') . ' </a>
					</td>
				</tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['customerref'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
					$RootPath,
					$MyRow['type'],
					$MyRow['transno']);
		} else { //no permission for GLTrans Inquiries
			printf($BaseFormatString . '</td></tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['customerref'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']));
		}
	} else {
		//If security token 8 in the allowed page security tokens then assumed ok for GL trans inquiries
		if ($_SESSION['CompanyRecord']['gllink_debtors'] == 1 and in_array(8, $_SESSION['AllowedPageSecurityTokens'])) {
			printf($BaseFormatString . '
					<td>
						<a href="%s/GLTransInquiry.php?TypeID=%s&amp;TransNo=%s">' . _('View GL Entries') . ' </a>
					</td>
				</tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['customerref'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']),
					$RootPath,
					$MyRow['type'],
					$MyRow['transno']);
		} else {
			printf($BaseFormatString . '</tr>',
					$MyRow['typename'],
					$MyRow['transno'],
					ConvertSQLDate($MyRow['trandate']),
					$MyRow['branchcode'],
					$MyRow['reference'],
					$MyRow['customerref'],
					$MyRow['invtext'],
					$MyRow['order_'],
					locale_number_format($MyRow['totalamount'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['allocated'], $CustomerRecord['decimalplaces']),
					locale_number_format($MyRow['totalamount'] - $MyRow['allocated'], $CustomerRecord['decimalplaces']));
		}
	}

}
//end of while loop

echo '</table>';
include('includes/footer.inc');
?>