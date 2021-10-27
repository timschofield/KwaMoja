<?php
include ('includes/DefineCartClass.php');

/* Session started in session.php for password checking and authorisation level check
 config.php is in turn included in session.php*/

include ('includes/session.php');

if (isset($_GET['NewItem'])) {
	$NewItem = trim($_GET['NewItem']);
	} //isset($_GET['NewItem'])
	if (empty($_GET['identifier'])) {
		/*unique session identifier to ensure that there is no conflict with other order entry sessions on the same machine  */
		$Identifier = date('U');
	} else {
		$Identifier = $_GET['identifier'];
	}

	if (isset($_GET['ModifyOrderNumber'])) {
		$Title = _('Modifying Sales Order') . ' ' . $_GET['ModifyOrderNumber'];
	} else if (isset($_SESSION['Items' . $Identifier]->CustomerName)) {
		$Title = _('Create Sales Order') . ' - ' . $_SESSION['Items' . $Identifier]->CustomerName;
	} else {
		$Title = _('Create Sales Order');
	}
	/* Manual links before header.php */
	$ViewTopic = 'SalesOrders';
	$BookMark = 'SalesOrderEntry';

	include ('includes/header.php');
	include ('includes/GetPrice.php');
	include ('includes/FreightCalculation.php');
	include ('includes/SQL_CommonFunctions.php');
	include ('includes/CountriesArray.php');

	if (isset($_POST['ProcessOrder']) or isset($_POST['MakeRecurringOrder'])) {
		/*need to check for input errors in any case before order processed */
		$_POST['Update'] = 'Yes rerun the validation checks'; //no need for gettext!
		/*store the old freight cost before it is recalculated to ensure that there has been no change - test for change after freight recalculated and get user to re-confirm if changed */

		$OldFreightCost = round($_POST['FreightCost'], 2);

	} //isset($_POST['ProcessOrder']) or isset($_POST['MakeRecurringOrder'])
	if (isset($_POST['Update']) or isset($_POST['BackToLineDetails']) or isset($_POST['MakeRecurringOrder'])) {
		$InputErrors = 0;
		if (mb_strlen($_POST['DeliverTo']) <= 1) {
			$InputErrors = 1;
			prnMsg(_('You must enter the person or company to whom delivery should be made'), 'error');
		} //mb_strlen($_POST['DeliverTo']) <= 1
		if (mb_strlen($_POST['BrAdd1']) <= 1) {
			$InputErrors = 1;
			prnMsg(_('You should enter the street address in the box provided') . '. ' . _('Orders cannot be accepted without a valid street address'), 'error');
		} //mb_strlen($_POST['BrAdd1']) <= 1
		//	if (mb_strpos($_POST['BrAdd1'],_('Box'))>0){
		//		prnMsg(_('You have entered the word') . ' "' . _('Box') . '" ' . _('in the street address') . '. ' . _('Items cannot be delivered to') . ' ' ._('box') . ' ' . _('addresses'),'warn');
		//	}
		if (!is_numeric($_POST['FreightCost'])) {
			$InputErrors = 1;
			prnMsg(_('The freight cost entered is expected to be numeric'), 'error');
		} //!is_numeric($_POST['FreightCost'])
		if (isset($_POST['MakeRecurringOrder']) and $_POST['Quotation'] == 1) {
			$InputErrors = 1;
			prnMsg(_('A recurring order cannot be made from a quotation'), 'error');
		} //isset($_POST['MakeRecurringOrder']) and $_POST['Quotation'] == 1
		if (($_POST['DeliverBlind']) <= 0) {
			$InputErrors = 1;
			prnMsg(_('You must select the type of packlist to print'), 'error');
		} //($_POST['DeliverBlind']) <= 0
		/*	if (mb_strlen($_POST['BrAdd3'])==0 or !isset($_POST['BrAdd3'])){
		$InputErrors =1;
		echo "<br />A region or city must be entered.<br />";
		}
		
		Maybe appropriate in some installations but not here
		if (mb_strlen($_POST['BrAdd2'])<=1){
		$InputErrors =1;
		echo "<br />You should enter the suburb in the box provided. Orders cannot be accepted without a valid suburb being entered.<br />";
		}
		
		*/
		// Check the date is OK
		if (isset($_POST['DeliveryDate']) and !is_date($_POST['DeliveryDate'])) {
			$InputErrors = 1;
			prnMsg(_('An invalid date entry was made') . '. ' . _('The date entry must be in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'warn');
		} //isset($_POST['DeliveryDate']) and !is_date($_POST['DeliveryDate'])
		// Check the date is OK
		if (isset($_POST['QuoteDate']) and !is_date($_POST['QuoteDate'])) {
			$InputErrors = 1;
			prnMsg(_('An invalid date entry was made') . '. ' . _('The date entry must be in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'warn');
		} //isset($_POST['QuoteDate']) and !is_date($_POST['QuoteDate'])
		// Check the date is OK
		if (isset($_POST['ConfirmedDate']) and !is_date($_POST['ConfirmedDate'])) {
			$InputErrors = 1;
			prnMsg(_('An invalid date entry was made') . '. ' . _('The date entry must be in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'warn');
		} //isset($_POST['ConfirmedDate']) and !is_date($_POST['ConfirmedDate'])
		/* This check is not appropriate where orders need to be entered in retrospectively in some cases this check will be appropriate and this should be uncommented
		
		elseif (Date1GreaterThanDate2(Date($_SESSION['DefaultDateFormat'],$EarliestDispatch), $_POST['DeliveryDate'])){
		$InputErrors =1;
		echo '<br /><b>' . _('The delivery details cannot be updated because you are attempting to set the date the order is to be dispatched earlier than is possible. No dispatches are made on Saturday and Sunday. Also, the dispatch cut off time is') .  $_SESSION['DispatchCutOffTime']  . _(':00 hrs. Orders placed after this time will be dispatched the following working day.');
		}
		
		*/

		if ($InputErrors == 0) {
			if ($_SESSION['DoFreightCalc'] == True) {
				list($_POST['FreightCost'], $BestShipper) = CalcFreightCost($_SESSION['Items' . $Identifier]->total, $_POST['BrAdd2'], $_POST['BrAdd3'], $_POST['BrAdd4'], $_POST['BrAdd5'], $_POST['BrAdd6'], $_SESSION['Items' . $Identifier]->totalVolume, $_SESSION['Items' . $Identifier]->totalWeight, $_SESSION['Items' . $Identifier]->Location, $_SESSION['Items' . $Identifier]->DefaultCurrency, $CountriesArray);
				if (!empty($BestShipper)) {
					$_POST['FreightCost'] = round($_POST['FreightCost'], 2);
					$_POST['ShipVia'] = $BestShipper;
				} else {
					prnMsg(_($_POST['FreightCost']), 'warn');
				}
			} //$_SESSION['DoFreightCalc'] == True
			$SQL = "SELECT custbranch.brname,
						custbranch.braddress1,
						custbranch.braddress2,
						custbranch.braddress3,
						custbranch.braddress4,
						custbranch.braddress5,
						custbranch.braddress6,
						custbranch.phoneno,
						custbranch.email,
						custbranch.defaultlocation,
						custbranch.defaultshipvia,
						custbranch.deliverblind,
						custbranch.specialinstructions,
						custbranch.estdeliverydays,
						custbranch.salesman
					FROM custbranch
					WHERE custbranch.branchcode='" . $_SESSION['Items' . $Identifier]->Branch . "'
						AND custbranch.debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "'";

			$ErrMsg = _('The customer branch record of the customer selected') . ': ' . $_SESSION['Items' . $Identifier]->CustomerName . ' ' . _('cannot be retrieved because');
			$DbgMsg = _('SQL used to retrieve the branch details was') . ':';
			$Result = DB_query($SQL, $ErrMsg, $DbgMsg);
			if (DB_num_rows($Result) == 0) {
				prnMsg(_('The branch details for branch code') . ': ' . $_SESSION['Items' . $Identifier]->Branch . ' ' . _('against customer code') . ': ' . $_POST['Select'] . ' ' . _('could not be retrieved') . '. ' . _('Check the set up of the customer and branch'), 'error');

				if ($Debug == 1) {
					echo '<br />' . _('The SQL that failed to get the branch details was') . ':<br />' . $SQL;
				} //$Debug == 1
				include ('includes/footer.php');
				exit;
			} //DB_num_rows($Result) == 0
			if (!isset($_POST['SpecialInstructions'])) {
				$_POST['SpecialInstructions'] = '';
			} //!isset($_POST['SpecialInstructions'])
			if (!isset($_POST['DeliveryDays'])) {
				$_POST['DeliveryDays'] = 0;
			} //!isset($_POST['DeliveryDays'])
			if (!isset($_SESSION['Items' . $Identifier])) {
				$MyRow = DB_fetch_row($Result);
				$_SESSION['Items' . $Identifier]->DeliverTo = $MyRow[0];
				$_SESSION['Items' . $Identifier]->DelAdd1 = $MyRow[1];
				$_SESSION['Items' . $Identifier]->DelAdd2 = $MyRow[2];
				$_SESSION['Items' . $Identifier]->DelAdd3 = $MyRow[3];
				$_SESSION['Items' . $Identifier]->DelAdd4 = $MyRow[4];
				$_SESSION['Items' . $Identifier]->DelAdd5 = $MyRow[5];
				$_SESSION['Items' . $Identifier]->DelAdd6 = $MyRow[6];
				$_SESSION['Items' . $Identifier]->PhoneNo = $MyRow[7];
				$_SESSION['Items' . $Identifier]->Email = $MyRow[8];
				$_SESSION['Items' . $Identifier]->Location = $MyRow[9];
				$_SESSION['Items' . $Identifier]->ShipVia = $MyRow[10];
				$_SESSION['Items' . $Identifier]->DeliverBlind = $MyRow[11];
				$_SESSION['Items' . $Identifier]->SpecialInstructions = $MyRow[12];
				$_SESSION['Items' . $Identifier]->DeliveryDays = $MyRow[13];
				$_SESSION['Items' . $Identifier]->SalesPerson = $MyRow[14];
				$_SESSION['Items' . $Identifier]->DeliveryDate = $_POST['DeliveryDate'];
				$_SESSION['Items' . $Identifier]->QuoteDate = $_POST['QuoteDate'];
				$_SESSION['Items' . $Identifier]->ConfirmedDate = $_POST['ConfirmedDate'];
				$_SESSION['Items' . $Identifier]->CustRef = $_POST['CustRef'];
				$_SESSION['Items' . $Identifier]->Comments = $_POST['Comments'];
				$_SESSION['Items' . $Identifier]->FreightCost = round($_POST['FreightCost'], 2);
				$_SESSION['Items' . $Identifier]->Quotation = $_POST['Quotation'];
			} //!isset($_SESSION['Items' . $Identifier])
			else {
				$_SESSION['Items' . $Identifier]->DeliverTo = $_POST['DeliverTo'];
				$_SESSION['Items' . $Identifier]->DelAdd1 = $_POST['BrAdd1'];
				$_SESSION['Items' . $Identifier]->DelAdd2 = $_POST['BrAdd2'];
				$_SESSION['Items' . $Identifier]->DelAdd3 = $_POST['BrAdd3'];
				$_SESSION['Items' . $Identifier]->DelAdd4 = $_POST['BrAdd4'];
				$_SESSION['Items' . $Identifier]->DelAdd5 = $_POST['BrAdd5'];
				$_SESSION['Items' . $Identifier]->DelAdd6 = $_POST['BrAdd6'];
				$_SESSION['Items' . $Identifier]->PhoneNo = $_POST['PhoneNo'];
				$_SESSION['Items' . $Identifier]->Email = $_POST['Email'];
				$_SESSION['Items' . $Identifier]->Location = $_POST['Location'];
				$_SESSION['Items' . $Identifier]->ShipVia = $_POST['ShipVia'];
				$_SESSION['Items' . $Identifier]->DeliverBlind = $_POST['DeliverBlind'];
				$_SESSION['Items' . $Identifier]->SpecialInstructions = $_POST['SpecialInstructions'];
				$_SESSION['Items' . $Identifier]->DeliveryDays = $_POST['DeliveryDays'];
				$_SESSION['Items' . $Identifier]->DeliveryDate = $_POST['DeliveryDate'];
				$_SESSION['Items' . $Identifier]->QuoteDate = $_POST['QuoteDate'];
				$_SESSION['Items' . $Identifier]->ConfirmedDate = $_POST['ConfirmedDate'];
				$_SESSION['Items' . $Identifier]->CustRef = $_POST['CustRef'];
				$_SESSION['Items' . $Identifier]->Comments = $_POST['Comments'];
				$_SESSION['Items' . $Identifier]->SalesPerson = $_POST['SalesPerson'];
				$_SESSION['Items' . $Identifier]->FreightCost = round($_POST['FreightCost'], 2);
				$_SESSION['Items' . $Identifier]->Quotation = $_POST['Quotation'];
			}
			/*$_SESSION['DoFreightCalc'] is a setting in the config.php file that the user can set to false to turn off freight calculations if necessary */

			/* What to do if the shipper is not calculated using the system
			- first check that the default shipper defined in config.php is in the database
			if so use this
			- then check to see if any shippers are defined at all if not report the error
			and show a link to set them up
			- if shippers defined but the default shipper is bogus then use the first shipper defined
			*/
			if ((isset($BestShipper) and $BestShipper == '') and ($_POST['ShipVia'] == '' or !isset($_POST['ShipVia']))) {
				$SQL = "SELECT shipper_id
						FROM shippers
						WHERE shipper_id='" . $_SESSION['Default_Shipper'] . "'";
				$ErrMsg = _('There was a problem testing for the default shipper');
				$DbgMsg = _('SQL used to test for the default shipper') . ':';
				$TestShipperExists = DB_query($SQL, $ErrMsg, $DbgMsg);

				if (DB_num_rows($TestShipperExists) == 1) {
					$BestShipper = $_SESSION['Default_Shipper'];

				} //DB_num_rows($TestShipperExists) == 1
				else {
					$SQL = "SELECT shipper_id
							FROM shippers";
					$TestShipperExists = DB_query($SQL, $ErrMsg, $DbgMsg);

					if (DB_num_rows($TestShipperExists) >= 1) {
						$ShipperReturned = DB_fetch_row($TestShipperExists);
						$BestShipper = $ShipperReturned[0];
					} //DB_num_rows($TestShipperExists) >= 1
					else {
						prnMsg(_('We have a problem') . ' - ' . _('there are no shippers defined') . '. ' . _('Please use the link below to set up shipping or freight companies') . ', ' . _('the system expects the shipping company to be selected or a default freight company to be used'), 'error');
						echo '<a href="' . $RootPath . 'Shippers.php">' . _('Enter') . '/' . _('Amend Freight Companies') . '</a>';
					}
				}
				if (isset($_SESSION['Items' . $Identifier]->ShipVia) and $_SESSION['Items' . $Identifier]->ShipVia != '') {
					$_POST['ShipVia'] = $_SESSION['Items' . $Identifier]->ShipVia;
				} //isset($_SESSION['Items' . $Identifier]->ShipVia) and $_SESSION['Items' . $Identifier]->ShipVia != ''
				else {
					$_POST['ShipVia'] = $BestShipper;
				}
			} //(isset($BestShipper) and $BestShipper == '') and ($_POST['ShipVia'] == '' or !isset($_POST['ShipVia']))
			

			
		} //$InputErrors == 0
		

		
	} //isset($_POST['Update']) or isset($_POST['BackToLineDetails']) or isset($_POST['MakeRecurringOrder'])
	

	if (isset($_POST['ProcessOrder'])) {
		/*Default OK_to_PROCESS to 1 change to 0 later if hit a snag */
		if ($InputErrors == 0) {
			$OK_to_PROCESS = 1;
		} //$InputErrors == 0
		if ($_POST['FreightCost'] != $OldFreightCost and $_SESSION['DoFreightCalc'] == True) {
			$OK_to_PROCESS = 0;
			prnMsg(_('The freight charge has been updated') . '. ' . _('Please reconfirm that the order and the freight charges are acceptable and then confirm the order again if OK') . ' <br /> ' . _('The new freight cost is') . ' ' . $_POST['FreightCost'] . ' ' . _('and the previously calculated freight cost was') . ' ' . $OldFreightCost, 'warn');
		} //$_POST['FreightCost'] != $OldFreightCost and $_SESSION['DoFreightCalc'] == True
		else {
			/*check the customer's payment terms */
			$SQL = "SELECT daysbeforedue,
				dayinfollowingmonth
			FROM debtorsmaster,
				paymentterms
			WHERE debtorsmaster.paymentterms=paymentterms.termsindicator
			AND debtorsmaster.debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "'";

			$ErrMsg = _('The customer terms cannot be determined') . '. ' . _('This order cannot be processed because');
			$DbgMsg = _('SQL used to find the customer terms') . ':';
			$TermsResult = DB_query($SQL, $ErrMsg, $DbgMsg);

			$MyRow = DB_fetch_array($TermsResult);
			if ($MyRow['daysbeforedue'] == 0 and $MyRow['dayinfollowingmonth'] == 0) {
				/* THIS IS A CASH SALE NEED TO GO OFF TO 3RD PARTY SITE SENDING MERCHANT ACCOUNT DETAILS AND CHECK FOR APPROVAL FROM 3RD PARTY SITE BEFORE CONTINUING TO PROCESS THE ORDER
				
				UNTIL ONLINE CREDIT CARD PROCESSING IS PERFORMED ASSUME OK TO PROCESS
				
				NOT YET CODED     */

				$OK_to_PROCESS = 1;

			} #end if cash sale detected
			

			
		} #end if else freight charge not altered
		

		
	} #end if process order
	if (isset($OK_to_PROCESS) and $OK_to_PROCESS == 1 and $_SESSION['ExistingOrder' . $Identifier] == 0) {
		/* finally write the order header to the database and then the order line details */

		$DelDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->DeliveryDate);
		$QuotDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->QuoteDate);
		$ConfDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->ConfirmedDate);

		$Result = DB_Txn_Begin();

		$OrderNo = GetNextTransNo(30);

		if (isset($_FILES['Attachment']) and $_FILES['Attachment']['name'] != '') {

			$UploadTheFile = 'Yes'; //Assume all is well to start off with
			//But check for the worst
			if (mb_strtoupper(mb_substr(trim($_FILES['Attachment']['name']), mb_strlen($_FILES['Attachment']['name']) - 3)) != 'PDF') {
				prnMsg(_('Only pdf files are supported - a file extension of .pdf is expected'), 'warn');
				$UploadTheFile = 'No';
			} elseif ($_FILES['Attachment']['size'] > ($_SESSION['MaxImageSize'] * 1024)) { //File Size Check
				prnMsg(_('The file size is over the maximum allowed. The maximum size allowed in KB is') . ' ' . $_SESSION['MaxImageSize'], 'warn');
				$UploadTheFile = 'No';
			} elseif ($_FILES['Attachment']['type'] != 'application/pdf') { //File Type Check
				prnMsg(_('Only pdf files can be uploaded'), 'warn');
				$UploadTheFile = 'No';
			} elseif ($_FILES['Attachment']['error'] == 6) { //upload temp directory check
				prnMsg(_('No tmp directory set. You must have a tmp directory set in your PHP for upload of files.'), 'warn');
				$UploadTheFile = 'No';
			} elseif (file_exists($FileName)) {
				prnMsg(_('Attempting to overwrite an existing item attachment'), 'warn');
				$Result = unlink($FileName);
				if (!$Result) {
					prnMsg(_('The existing attachment could not be removed'), 'error');
					$UploadTheFile = 'No';
				}
			}

			if ($UploadTheFile == 'Yes') {
				$OrderNumber = $OrderNo;
				$Name = $_FILES['Attachment']['name'];
				$Type = $_FILES['Attachment']['type'];
				$Size = $_FILES['Attachment']['size'];
				$fp = fopen($_FILES['Attachment']['tmp_name'], 'r');
				$Content = fread($fp, $Size);
				$Content = addslashes($Content);
				fclose($fp);
				$SQL = "INSERT INTO salesorderattachments VALUES('" . $OrderNumber . "',
															'" . $Name . "',
															'" . $Type . "',
															" . $Size . ",
															'" . $Content . "'
															)";
				$Result = DB_query($SQL);

			}
		}

		$HeaderSQL = "INSERT INTO salesorders (
								orderno,
								debtorno,
								branchcode,
								customerref,
								comments,
								orddate,
								ordertype,
								shipvia,
								deliverto,
								deladd1,
								deladd2,
								deladd3,
								deladd4,
								deladd5,
								deladd6,
								contactphone,
								contactemail,
								salesperson,
								freightcost,
								fromstkloc,
								deliverydate,
								quotedate,
								confirmeddate,
								quotation,
								deliverblind)
							VALUES (
								'" . $OrderNo . "',
								'" . $_SESSION['Items' . $Identifier]->DebtorNo . "',
								'" . $_SESSION['Items' . $Identifier]->Branch . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->CustRef) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->Comments) . "',
								CURRENT_DATE,
								'" . $_SESSION['Items' . $Identifier]->DefaultSalesType . "',
								'" . $_POST['ShipVia'] . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DeliverTo) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd1) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd2) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd3) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd4) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd5) . "',
								'" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd6) . "',
								'" . $_SESSION['Items' . $Identifier]->PhoneNo . "',
								'" . $_SESSION['Items' . $Identifier]->Email . "',
								'" . $_SESSION['Items' . $Identifier]->SalesPerson . "',
								'" . $_SESSION['Items' . $Identifier]->FreightCost . "',
								'" . $_SESSION['Items' . $Identifier]->Location . "',
								'" . $DelDate . "',
								'" . $QuotDate . "',
								'" . $ConfDate . "',
								'" . $_SESSION['Items' . $Identifier]->Quotation . "',
								'" . $_SESSION['Items' . $Identifier]->DeliverBlind . "'
								)";

		$ErrMsg = _('The order cannot be added because');
		$InsertQryResult = DB_query($HeaderSQL, $ErrMsg);

		$StartOf_LineItemsSQL = "INSERT INTO salesorderdetails (
											orderlineno,
											orderno,
											stkcode,
											unitprice,
											quantity,
											discountpercent,
											narrative,
											poline,
											itemdue)
										VALUES (";
		$DbgMsg = _('The SQL that failed was');
		foreach ($_SESSION['Items' . $Identifier]->LineItems as $StockItem) {
			$LineItemsSQL = $StartOf_LineItemsSQL . "
					'" . $StockItem->LineNumber . "',
					'" . $OrderNo . "',
					'" . $StockItem->StockID . "',
					'" . $StockItem->Price . "',
					'" . $StockItem->Quantity . "',
					'" . floatval($StockItem->DiscountPercent) . "',
					'" . DB_escape_string($StockItem->Narrative) . "',
					'" . $StockItem->POLine . "',
					'" . FormatDateForSQL($StockItem->ItemDue) . "'
				)";
			$ErrMsg = _('Unable to add the sales order line');
			$Ins_LineItemResult = DB_query($LineItemsSQL, $ErrMsg, $DbgMsg, true);

			/*Now check to see if the item is manufactured
			 * 			and AutoCreateWOs is on
			 * 			and it is a real order (not just a quotation)*/

			if ($StockItem->MBflag == 'M' and $_SESSION['AutoCreateWOs'] == 1 and $_SESSION['Items' . $Identifier]->Quotation != 1) { //oh yeah its all on!
				echo '<br />';

				//now get the data required to test to see if we need to make a new WO
				$QOHResult = DB_query("SELECT SUM(quantity) FROM locstock WHERE stockid='" . $StockItem->StockID . "'");
				$QOHRow = DB_fetch_row($QOHResult);
				$QOH = $QOHRow[0];

				$SQL = "SELECT SUM(salesorderdetails.quantity - salesorderdetails.qtyinvoiced) AS qtydemand
					FROM salesorderdetails INNER JOIN salesorders
					ON salesorderdetails.orderno=salesorders.orderno
					WHERE salesorderdetails.stkcode = '" . $StockItem->StockID . "'
					AND salesorderdetails.completed = 0
					AND salesorders.quotation=0";
				$DemandResult = DB_query($SQL);
				$DemandRow = DB_fetch_row($DemandResult);
				$QuantityDemand = $DemandRow[0];

				$SQL = "SELECT SUM((salesorderdetails.quantity-salesorderdetails.qtyinvoiced)*bom.quantity) AS dem
					FROM salesorderdetails INNER JOIN salesorders
					ON salesorderdetails.orderno=salesorders.orderno
					INNER JOIN bom ON salesorderdetails.stkcode=bom.parent
					INNER JOIN stockmaster ON stockmaster.stockid=bom.parent
					WHERE salesorderdetails.quantity-salesorderdetails.qtyinvoiced > 0
					AND bom.component='" . $StockItem->StockID . "'
					AND salesorders.quotation=0
					AND stockmaster.mbflag='A'
					AND salesorderdetails.completed=0";
				$AssemblyDemandResult = DB_query($SQL);
				$AssemblyDemandRow = DB_fetch_row($AssemblyDemandResult);
				$QuantityAssemblyDemand = $AssemblyDemandRow[0];

				$SQL = "SELECT SUM(purchorderdetails.quantityord - purchorderdetails.quantityrecd) as qtyonorder
					FROM purchorderdetails,
						purchorders
					WHERE purchorderdetails.orderno = purchorders.orderno
					AND purchorderdetails.itemcode = '" . $StockItem->StockID . "'
					AND purchorderdetails.completed = 0";
				$PurchOrdersResult = DB_query($SQL);
				$PurchOrdersRow = DB_fetch_row($PurchOrdersResult);
				$QuantityPurchOrders = $PurchOrdersRow[0];

				$SQL = "SELECT SUM(woitems.qtyreqd - woitems.qtyrecd) as qtyonorder
					FROM woitems INNER JOIN workorders
					ON woitems.wo=workorders.wo
					WHERE woitems.stockid = '" . $StockItem->StockID . "'
					AND woitems.qtyreqd > woitems.qtyrecd
					AND workorders.closed = 0";
				$WorkOrdersResult = DB_query($SQL);
				$WorkOrdersRow = DB_fetch_row($WorkOrdersResult);
				$QuantityWorkOrders = $WorkOrdersRow[0];

				//Now we have the data - do we need to make any more?
				$ShortfallQuantity = $QOH - $QuantityDemand - $QuantityAssemblyDemand + $QuantityPurchOrders + $QuantityWorkOrders;

				if ($ShortfallQuantity < 0) { //then we need to make a work order
					//How many should the work order be for??
					if ($ShortfallQuantity + $StockItem->EOQ < 0) {
						$WOQuantity = - $ShortfallQuantity;
					} //$ShortfallQuantity + $StockItem->EOQ < 0
					else {
						$WOQuantity = $StockItem->EOQ;
					}

					$WONo = GetNextTransNo(40);
					$ErrMsg = _('Unable to insert a new work order for the sales order item');
					$InsWOResult = DB_query("INSERT INTO workorders (wo,
												 loccode,
												 requiredby,
												 startdate)
								 VALUES ('" . $WONo . "',
										'" . $_SESSION['DefaultFactoryLocation'] . "',
										CURRENT_DATE,
										CURRENT_DATE)", $ErrMsg, $DbgMsg, true);
					//Need to get the latest BOM to roll up cost
					$CostResult = DB_query("SELECT SUM((stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost)*bom.quantity) AS cost
													FROM stockcosts
													INNER JOIN bom
														ON stockcosts.stockid=bom.component
														AND stockcosts.succeeded=0
													WHERE bom.parent='" . $StockItem->StockID . "'
														AND bom.loccode='" . $_SESSION['DefaultFactoryLocation'] . "'");
					$CostRow = DB_fetch_row($CostResult);
					if (is_null($CostRow[0]) or $CostRow[0] == 0) {
						$Cost = 0;
						prnMsg(_('In automatically creating a work order for') . ' ' . $StockItem->StockID . ' ' . _('an item on this sales order, the cost of this item as accumulated from the sum of the component costs is nil. This could be because there is no bill of material set up ... you may wish to double check this'), 'warn');
					} //is_null($CostRow[0]) or $CostRow[0] == 0
					else {
						$Cost = $CostRow[0];
					}

					// insert parent item info
					$SQL = "INSERT INTO woitems (wo,
											 stockid,
											 qtyreqd,
											 stdcost)
								 VALUES ( '" . $WONo . "',
										 '" . $StockItem->StockID . "',
										 '" . $WOQuantity . "',
										 '" . $Cost . "')";
					$ErrMsg = _('The work order item could not be added');
					$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);

					//Recursively insert real component requirements - see includes/SQL_CommonFunctions.in for function WoRealRequirements
					WoRealRequirements($WONo, $_SESSION['DefaultFactoryLocation'], $StockItem->StockID);

					$FactoryManagerEmail = _('A new work order has been created for') . ":\n" . $StockItem->StockID . ' - ' . $StockItem->ItemDescription . ' x ' . $WOQuantity . ' ' . $StockItem->Units . "\n" . _('These are for') . ' ' . $_SESSION['Items' . $Identifier]->CustomerName . ' ' . _('there order ref') . ': ' . $_SESSION['Items' . $Identifier]->CustRef . ' ' . _('our order number') . ': ' . $OrderNo;

					if ($StockItem->Serialised and $StockItem->NextSerialNo > 0) {
						//then we must create the serial numbers for the new WO also
						$FactoryManagerEmail.= "\n" . _('The following serial numbers have been reserved for this work order') . ':';

						for ($i = 0;$i < $WOQuantity;$i++) {
							$Result = DB_query("SELECT serialno FROM stockserialitems
												WHERE serialno='" . ($StockItem->NextSerialNo + $i) . "'
												AND stockid='" . $StockItem->StockID . "'");
							if (DB_num_rows($Result) != 0) {
								$WOQuantity++;
								prnMsg(($StockItem->NextSerialNo + $i) . ': ' . _('This automatically generated serial number already exists - it cannot be added to the work order'), 'error');
							} //DB_num_rows($Result) != 0
							else {
								$SQL = "INSERT INTO woserialnos (wo,
																stockid,
																serialno)
													VALUES ('" . $WONo . "',
															'" . $StockItem->StockID . "',
															'" . ($StockItem->NextSerialNo + $i) . "')";
								$ErrMsg = _('The serial number for the work order item could not be added');
								$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
								$FactoryManagerEmail.= "\n" . ($StockItem->NextSerialNo + $i);
							}
						} //end loop around creation of woserialnos
						$NewNextSerialNo = ($StockItem->NextSerialNo + $WOQuantity + 1);
						$ErrMsg = _('Could not update the new next serial number for the item');
						$UpdateNextSerialNoResult = DB_query("UPDATE stockmaster SET nextserialno='" . $NewNextSerialNo . "' WHERE stockid='" . $StockItem->StockID . "'", $ErrMsg, $DbgMsg, true);
					} // end if the item is serialised and nextserialno is set
					$EmailSubject = _('New Work Order Number') . ' ' . $WONo . ' ' . _('for') . ' ' . $StockItem->StockID . ' x ' . $WOQuantity;
					//Send email to the Factory Manager
					if ($_SESSION['SmtpSetting'] == 0) {
						mail($_SESSION['FactoryManagerEmail'], $EmailSubject, $FactoryManagerEmail);

					} else {
						include ('includes/htmlMimeMail.php');
						$Mail = new htmlMimeMail();
						$Mail->setSubject($EmailSubject);
						$Result = SendmailBySmtp($Mail, array($_SESSION['FactoryManagerEmail']));
					}

				} //end if with this sales order there is a shortfall of stock - need to create the WO
				

				
			} //end if auto create WOs in on
			

			
		} //$_SESSION['Items' . $Identifier]->LineItems as $StockItem
		/* end inserted line items into sales order details */

		$Result = DB_Txn_Commit();
		echo '<br />';
		if ($_SESSION['Items' . $Identifier]->Quotation == 1) {
			prnMsg(_('Quotation Number') . ' ' . $OrderNo . ' ' . _('has been entered'), 'success');
		} //$_SESSION['Items' . $Identifier]->Quotation == 1
		else {
			prnMsg(_('Order Number') . ' ' . $OrderNo . ' ' . _('has been entered'), 'success');
		}

		if (count($_SESSION['AllowedPageSecurityTokens']) > 1) {
			/* Only allow print of packing slip for internal staff - customer logon's cannot go here */

			if ($_POST['Quotation'] == 0) {
				/*then its not a quotation its a real order */

				echo '<div class="centre">
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/printer.png" title="', _('Print'), '" alt="" />
					', ' ', '<a target="_blank" href="', $RootPath, '/PrintCustOrder.php?identifier=', urlencode($Identifier), '&amp;TransNo=', urlencode($OrderNo), '">', _('Print packing slip'), ' (', _('Preprinted stationery'), ')', '</a><br />
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/printer.png" title="', _('Print'), '" alt="" />
					', ' ', '<a  target="_blank" href="', $RootPath, '/PrintCustOrder_generic.php?identifier=', urlencode($Identifier), '&amp;TransNo=', urlencode($OrderNo), '">', _('Print packing slip'), ' (', _('Laser'), ')', '</a><br />
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Invoice'), '" alt="" />
					', ' ', '<a href="', $RootPath, '/ConfirmDispatch_Invoice.php?identifier=', urlencode($Identifier), '&amp;OrderNumber=', urlencode($OrderNo), '">', _('Confirm Dispatch and Produce Invoice'), '</a>
				</div>';

			} else {
				/*link to print the quotation */
				echo '<div class="centre">
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Order'), '" alt="">
					', ' ', '<a href="', $RootPath, '/PDFQuotation.php?identifier=', urlencode($Identifier), '&amp;QuotationNo=', urlencode($OrderNo), '" target="_blank">', _('Print Quotation (Landscape)'), '</a>
				</div>';

				echo '<div class="centre">
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Order'), '" alt="" />
					', ' ', '<a href="', $RootPath, '/PDFQuotationPortrait.php?identifier=', urlencode($Identifier), '&amp;QuotationNo=', urlencode($OrderNo), '" target="_blank">', _('Print Quotation (Portrait)'), '</a>
				</div>';
			}

			echo '<div class="centre">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/sales.png" title="', _('Order'), '" alt="" /></td>
				', ' ', '<a href="', $RootPath, '/SelectOrderItems.php?identifier=', urlencode($Identifier), '&amp;NewOrder=Yes">', _('Add Another Sales Order'), '</a>
			</div>';
		} //count($_SESSION['AllowedPageSecurityTokens']) > 1
		else {
			/*its a customer logon so thank them */
			prnMsg(_('Thank you for your business'), 'success');
		}

		unset($_SESSION['Items' . $Identifier]->LineItems);
		unset($_SESSION['Items' . $Identifier]);
		include ('includes/footer.php');
		exit;

	} //isset($OK_to_PROCESS) and $OK_to_PROCESS == 1 and $_SESSION['ExistingOrder' . $Identifier] == 0
	elseif (isset($OK_to_PROCESS) and ($OK_to_PROCESS == 1 and $_SESSION['ExistingOrder' . $Identifier] != 0)) {
		/* update the order header then update the old order line details and insert the new lines */

		$DelDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->DeliveryDate);
		$QuotDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->QuoteDate);
		$ConfDate = FormatDateforSQL($_SESSION['Items' . $Identifier]->ConfirmedDate);

		$Result = DB_Txn_Begin();

		/*see if this is a contract quotation being changed to an order? */
		if ($_SESSION['Items' . $Identifier]->Quotation == 0) { //now its being changed? to an order
			$ContractResult = DB_query("SELECT contractref,
											requireddate
									FROM contracts WHERE orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'
									AND status=1");
			if (DB_num_rows($ContractResult) == 1) { //then it is a contract quotation being changed to an order
				$ContractRow = DB_fetch_array($ContractResult);
				$WONo = GetNextTransNo(40);
				$ErrMsg = _('Could not update the contract status');
				$DbgMsg = _('The SQL that failed to update the contract status was');
				$UpdContractResult = DB_query("UPDATE contracts SET status=2,
															wo='" . $WONo . "'
										WHERE orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'", $ErrMsg, $DbgMsg, true);
				$ErrMsg = _('Could not insert the contract bill of materials');
				$InsContractBOM = DB_query("INSERT INTO bom (parent,
														 component,
														 workcentreadded,
														 loccode,
														 effectiveafter,
														 effectiveto,
														 quantity)
											SELECT contractref,
													stockid,
													workcentreadded,
													'" . $_SESSION['Items' . $Identifier]->Location . "',
													CURRENT_DATE,
													'2099-12-31',
													quantity
											FROM contractbom
											WHERE contractref='" . $ContractRow['contractref'] . "'", $ErrMsg, $DbgMsg);

				$ErrMsg = _('Unable to insert a new work order for the sales order item');
				$InsWOResult = DB_query("INSERT INTO workorders (wo,
															 loccode,
															 requiredby,
															 startdate)
											 VALUES ('" . $WONo . "',
													'" . $_SESSION['Items' . $Identifier]->Location . "',
													'" . $ContractRow['requireddate'] . "',
													CURRENT_DATE)", $ErrMsg, $DbgMsg);
				//Need to get the latest BOM to roll up cost but also add the contract other requirements
				$CostResult = DB_query("SELECT SUM((stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost)*contractbom.quantity) AS cost
									FROM stockcosts
									INNER JOIN contractbom
										ON stockcosts.stockid=contractbom.stockid
										AND stockcosts.succeeded=0
									WHERE contractbom.contractref='" . $ContractRow['contractref'] . "'");
				$CostRow = DB_fetch_row($CostResult);
				if (is_null($CostRow[0]) or $CostRow[0] == 0) {
					$Cost = 0;
					prnMsg(_('In automatically creating a work order for') . ' ' . $ContractRow['contractref'] . ' ' . _('an item on this sales order, the cost of this item as accumulated from the sum of the component costs is nil. This could be because there is no bill of material set up ... you may wish to double check this'), 'warn');
				} //is_null($CostRow[0]) or $CostRow[0] == 0
				else {
					$Cost = $CostRow[0]; //cost of contract BOM
					

					
				}
				$CostResult = DB_query("SELECT SUM(costperunit*quantity) AS cost
									FROM contractreqts
									WHERE contractreqts.contractref='" . $ContractRow['contractref'] . "'");
				$CostRow = DB_fetch_row($CostResult);
				//add other requirements cost to cost of contract BOM
				$Cost+= $CostRow[0];

				// insert parent item info
				$SQL = "INSERT INTO woitems (wo,
										 stockid,
										 qtyreqd,
										 stdcost)
							 VALUES ( '" . $WONo . "',
									 '" . $ContractRow['contractref'] . "',
									 '1',
									 '" . $Cost . "')";
				$ErrMsg = _('The work order item could not be added');
				$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);

				//Recursively insert real component requirements - see includes/SQL_CommonFunctions.in for function WoRealRequirements
				WoRealRequirements($WONo, $_SESSION['Items' . $Identifier]->Location, $ContractRow['contractref']);

			} //end processing if the order was a contract quotation being changed to an order
			

			
		} //end test to see if the order was a contract quotation being changed to an order
		

		$HeaderSQL = "UPDATE salesorders SET debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "',
										branchcode = '" . $_SESSION['Items' . $Identifier]->Branch . "',
										customerref = '" . DB_escape_string($_SESSION['Items' . $Identifier]->CustRef) . "',
										comments = '" . DB_escape_string($_SESSION['Items' . $Identifier]->Comments) . "',
										ordertype = '" . $_SESSION['Items' . $Identifier]->DefaultSalesType . "',
										shipvia = '" . $_POST['ShipVia'] . "',
										deliverydate = '" . FormatDateForSQL(DB_escape_string($_SESSION['Items' . $Identifier]->DeliveryDate)) . "',
										quotedate = '" . FormatDateForSQL(DB_escape_string($_SESSION['Items' . $Identifier]->QuoteDate)) . "',
										confirmeddate = '" . FormatDateForSQL(DB_escape_string($_SESSION['Items' . $Identifier]->ConfirmedDate)) . "',
										deliverto = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DeliverTo) . "',
										deladd1 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd1) . "',
										deladd2 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd2) . "',
										deladd3 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd3) . "',
										deladd4 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd4) . "',
										deladd5 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd5) . "',
										deladd6 = '" . DB_escape_string($_SESSION['Items' . $Identifier]->DelAdd6) . "',
										contactphone = '" . $_SESSION['Items' . $Identifier]->PhoneNo . "',
										contactemail = '" . $_SESSION['Items' . $Identifier]->Email . "',
										salesperson = '" . $_SESSION['Items' . $Identifier]->SalesPerson . "',
										freightcost = '" . $_SESSION['Items' . $Identifier]->FreightCost . "',
										fromstkloc = '" . $_SESSION['Items' . $Identifier]->Location . "',
										printedpackingslip = '" . $_POST['ReprintPackingSlip'] . "',
										quotation = '" . $_SESSION['Items' . $Identifier]->Quotation . "',
										deliverblind = '" . $_SESSION['Items' . $Identifier]->DeliverBlind . "'
						WHERE salesorders.orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'";

		$DbgMsg = _('The SQL that was used to update the order and failed was');
		$ErrMsg = _('The order cannot be updated because');
		$InsertQryResult = DB_query($HeaderSQL, $ErrMsg, $DbgMsg, true);

		foreach ($_SESSION['Items' . $Identifier]->LineItems as $StockItem) {
			/* Check to see if the quantity reduced to the same quantity
			 as already invoiced - so should set the line to completed */
			if ($StockItem->Quantity == $StockItem->QtyInv) {
				$Completed = 1;
			} //$StockItem->Quantity == $StockItem->QtyInv
			else {
				/* order line is not complete */
				$Completed = 0;
			}

			$LineItemsSQL = "UPDATE salesorderdetails SET unitprice='" . $StockItem->Price . "',
													quantity='" . $StockItem->Quantity . "',
													discountpercent='" . floatval($StockItem->DiscountPercent) . "',
													completed='" . $Completed . "',
													poline='" . $StockItem->POLine . "',
													itemdue='" . FormatDateForSQL($StockItem->ItemDue) . "'
						WHERE salesorderdetails.orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'
						AND salesorderdetails.orderlineno='" . $StockItem->LineNumber . "'";

			$DbgMsg = _('The SQL that was used to modify the order line and failed was');
			$ErrMsg = _('The updated order line cannot be modified because');
			$Upd_LineItemResult = DB_query($LineItemsSQL, $ErrMsg, $DbgMsg, true);

		} //$_SESSION['Items' . $Identifier]->LineItems as $StockItem
		/* updated line items into sales order details */

		$Result = DB_Txn_Commit();
		$Quotation = $_SESSION['Items' . $Identifier]->Quotation;
		unset($_SESSION['Items' . $Identifier]->LineItems);
		unset($_SESSION['Items' . $Identifier]);

		if ($Quotation) { //handle Quotations and Orders print after modification
			prnMsg(_('Quotation Number') . ' ' . $_SESSION['ExistingOrder' . $Identifier] . ' ' . _('has been updated'), 'success');

			/*link to print the quotation */
			echo '<div class="centre">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Order'), '" alt="">
				', ' ', '<a href="', $RootPath, '/PDFQuotation.php?identifier=', urlencode($Identifier), '&amp;QuotationNo=', urlencode($_SESSION['ExistingOrder' . $Identifier]), '" target="_blank">', _('Print Quotation (Landscape)'), '</a>
			</div>';

			echo '<div class="centre">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Order'), '" alt="" />
				', ' ', '<a href="', $RootPath, '/PDFQuotationPortrait.php?identifier=', urlencode($Identifier), '&amp;QuotationNo=', urlencode($_SESSION['ExistingOrder' . $Identifier]), '" target="_blank">', _('Print Quotation (Portrait)'), '</a>
			</div>';

		} //$Quotation
		else {
			prnMsg(_('Order Number') . ' ' . $_SESSION['ExistingOrder' . $Identifier] . ' ' . _('has been updated'), 'success');

			echo '<div class="centre">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/printer.png" title="', _('Print'), '" alt="" />
				', ' ', '<a target="_blank" href="', $RootPath, '/PrintCustOrder.php?identifier=', urlencode($Identifier), '&amp;TransNo=', urlencode($_SESSION['ExistingOrder' . $Identifier]), '">', _('Print packing slip - pre-printed stationery'), '</a><br />
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/printer.png" title="', _('Print'), '" alt="" />
				', ' ', '<a target="_blank" href="', $RootPath, '/PrintCustOrder_generic.php?identifier=', urlencode($Identifier), '&amp;TransNo=', urlencode($_SESSION['ExistingOrder' . $Identifier]), '">', _('Print packing slip'), ' (', _('Laser'), ')', '</a><br />
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/reports.png" title="', _('Invoice'), '" alt="" />
				', ' ', '<a href="', $RootPath, '/ConfirmDispatch_Invoice.php?identifier=', urlencode($Identifier), '&amp;OrderNumber=', urlencode($_SESSION['ExistingOrder' . $Identifier]), '">', _('Confirm Order Delivery Quantities and Produce Invoice'), '</a><br />
				<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/sales.png" title="' . _('Order') . '" alt="" /></td>
				', ' ', '<a href="', $RootPath, '/SelectSalesOrder.php?identifier=', urlencode($Identifier), '">', _('Select A Different Order'), '</a>
			</div>';

		} //end of print orders
		include ('includes/footer.php');
		exit;
	} //isset($OK_to_PROCESS) and ($OK_to_PROCESS == 1 and $_SESSION['ExistingOrder' . $Identifier] != 0)
	

	if (isset($_POST['QuickEntry'])) {
		unset($_POST['PartSearch']);
	} //isset($_POST['QuickEntry'])
	

	if (isset($_POST['SelectingOrderItems'])) {
		foreach ($_POST as $FormVariable => $Quantity) {
			if (mb_strpos($FormVariable, 'OrderQty') !== false) {
				$NewItemArray[$_POST['StockID' . mb_substr($FormVariable, 8) ]] = filter_number_format($Quantity);
			} //mb_strpos($FormVariable, 'OrderQty') !== false
			
		} //$_POST as $FormVariable => $Quantity
		
	} //isset($_POST['SelectingOrderItems'])
	

	if (isset($_POST['UploadFile'])) {
		$NewItemArray = array();
		if (isset($_FILES['CSVFile']) and $_FILES['CSVFile']['name']) {
			//check file info
			$FileName = $_FILES['CSVFile']['name'];
			$TempName = $_FILES['CSVFile']['tmp_name'];
			$FileSize = $_FILES['CSVFile']['size'];
			//get file handle
			$FileHandle = fopen($TempName, 'r');
			$Row = 0;
			$InsertNum = 0;
			while (($FileRow = fgetcsv($FileHandle, 10000, ",")) !== False) {
				/* Check the stock code exists */
				++$Row;
				$SQL = "SELECT stockid FROM stockmaster WHERE stockid='" . $FileRow[0] . "'";
				$Result = DB_query($SQL);
				if (DB_num_rows($Result) > 0) {
					$NewItemArray[$FileRow[0]] = filter_number_format($FileRow[1]);
					++$InsertNum;
				}
			}
		}
		$_POST['SelectingOrderItems'] = 1;
		if (sizeof($NewItemArray) == 0) {
			prnMsg(_('There are no items that can be imported'), 'error');
		} else {
			prnMsg($InsertNum . ' ' . _('of') . ' ' . $Row . ' ' . _('rows have been added to the order'), 'info');
		}
	}

	if (isset($_GET['NewOrder'])) {
		/*New order entry - clear any existing order details from the Items object and initiate a newy*/
		if (isset($_SESSION['Items' . $Identifier])) {
			unset($_SESSION['Items' . $Identifier]->LineItems);
			$_SESSION['Items' . $Identifier]->ItemsOrdered = 0;
			unset($_SESSION['Items' . $Identifier]);
		} //isset($_SESSION['Items' . $Identifier])
		$_SESSION['ExistingOrder' . $Identifier] = 0;
		$_SESSION['Items' . $Identifier] = new cart;

		if ((isset($SupplierLogin) and $SupplierLogin == 0)) { //its a customer logon
			$_SESSION['Items' . $Identifier]->DebtorNo = $_SESSION['CustomerID'];
			$_SESSION['RequireCustomerSelection'] = 0;
		} //count($_SESSION['AllowedPageSecurityTokens']) == 1
		else {
			$_SESSION['Items' . $Identifier]->DebtorNo = '';
			$_SESSION['RequireCustomerSelection'] = 1;
		}

	} //isset($_GET['NewOrder'])
	if (isset($_GET['ModifyOrderNumber']) and $_GET['ModifyOrderNumber'] != '') {
		/* The delivery check screen is where the details of the order are either updated or inserted depending on the value of ExistingOrder */

		if (isset($_SESSION['Items' . $Identifier])) {
			unset($_SESSION['Items' . $Identifier]->LineItems);
			unset($_SESSION['Items' . $Identifier]);
		} //isset($_SESSION['Items' . $Identifier])
		$_SESSION['ExistingOrder' . $Identifier] = $_GET['ModifyOrderNumber'];
		$_SESSION['RequireCustomerSelection'] = 0;
		$_SESSION['Items' . $Identifier] = new cart;

		/*read in all the guff from the selected order into the Items cart  */

		$OrderHeaderSQL = "SELECT salesorders.debtorno,
			 				  debtorsmaster.name,
							  salesorders.branchcode,
							  salesorders.customerref,
							  salesorders.comments,
							  salesorders.orddate,
							  salesorders.ordertype,
							  salestypes.sales_type,
							  salesorders.shipvia,
							  salesorders.deliverto,
							  salesorders.deladd1,
							  salesorders.deladd2,
							  salesorders.deladd3,
							  salesorders.deladd4,
							  salesorders.deladd5,
							  salesorders.deladd6,
							  salesorders.contactphone,
							  salesorders.contactemail,
							  salesorders.salesperson,
							  salesorders.freightcost,
							  salesorders.deliverydate,
							  debtorsmaster.currcode,
							  currencies.decimalplaces,
							  paymentterms.terms,
							  salesorders.fromstkloc,
							  salesorders.printedpackingslip,
							  salesorders.datepackingslipprinted,
							  salesorders.quotation,
							  salesorders.quotedate,
							  salesorders.confirmeddate,
							  salesorders.deliverblind,
							  debtorsmaster.customerpoline,
							  locations.locationname,
							  custbranch.estdeliverydays,
							  custbranch.salesman
						FROM salesorders
						INNER JOIN debtorsmaster
							ON salesorders.debtorno = debtorsmaster.debtorno
						INNER JOIN salestypes
							ON salesorders.ordertype=salestypes.typeabbrev
						INNER JOIN custbranch
							ON salesorders.debtorno = custbranch.debtorno
							AND salesorders.branchcode = custbranch.branchcode
						INNER JOIN paymentterms
							ON debtorsmaster.paymentterms=paymentterms.termsindicator
						INNER JOIN locations
							ON locations.loccode=salesorders.fromstkloc
						INNER JOIN currencies
							ON debtorsmaster.currcode=currencies.currabrev
						INNER JOIN locationusers
							ON locationusers.loccode=salesorders.fromstkloc
							AND locationusers.userid='" . $_SESSION['UserID'] . "'
							AND locationusers.canupd=1
						WHERE salesorders.orderno = '" . $_GET['ModifyOrderNumber'] . "'";

		$ErrMsg = _('The order cannot be retrieved because');
		$GetOrdHdrResult = DB_query($OrderHeaderSQL, $ErrMsg);

		if (DB_num_rows($GetOrdHdrResult) == 1) {
			$MyRow = DB_fetch_array($GetOrdHdrResult);
			if ($_SESSION['SalesmanLogin'] != '' and $_SESSION['SalesmanLogin'] != $MyRow['salesman']) {
				prnMsg(_('Your account is set up to see only a specific salespersons orders. You are not authorised to modify this order'), 'error');

				include ('includes/footer.php');
				exit;
			} //$_SESSION['SalesmanLogin'] != '' and $_SESSION['SalesmanLogin'] != $MyRow['salesman']
			if (($_SESSION['CustomerID'] != '') and $MyRow['debtorno'] != $_SESSION['CustomerID']) {
				/* If it's a customer login and the invoice is for a different customer the do not print */
				prnMsg(_('This transaction is addressed to another customer and cannot be displayed for privacy reasons') . '. ' . _('Please select only transactions relevant to your company'), 'error');
				include ('includes/header.php');
				exit;
			}

			$_SESSION['Items' . $Identifier]->OrderNo = $_GET['ModifyOrderNumber'];
			$_SESSION['Items' . $Identifier]->DebtorNo = DB_escape_string($MyRow['debtorno']);
			$_SESSION['Items' . $Identifier]->CreditAvailable = GetCreditAvailable($_SESSION['Items' . $Identifier]->DebtorNo);
			/*CustomerID defined in header.php */
			$_SESSION['Items' . $Identifier]->Branch = DB_escape_string($MyRow['branchcode']);
			$_SESSION['Items' . $Identifier]->CustomerName = $MyRow['name'];
			$_SESSION['Items' . $Identifier]->CustRef = $MyRow['customerref'];
			$_SESSION['Items' . $Identifier]->Comments = stripcslashes($MyRow['comments']);
			$_SESSION['Items' . $Identifier]->PaymentTerms = $MyRow['terms'];
			$_SESSION['Items' . $Identifier]->DefaultSalesType = $MyRow['ordertype'];
			$_SESSION['Items' . $Identifier]->SalesTypeName = $MyRow['sales_type'];
			$_SESSION['Items' . $Identifier]->DefaultCurrency = $MyRow['currcode'];
			$_SESSION['Items' . $Identifier]->CurrDecimalPlaces = $MyRow['decimalplaces'];
			$_SESSION['Items' . $Identifier]->ShipVia = $MyRow['shipvia'];
			$BestShipper = $MyRow['shipvia'];
			$_SESSION['Items' . $Identifier]->DeliverTo = $MyRow['deliverto'];
			$_SESSION['Items' . $Identifier]->DeliveryDate = ConvertSQLDate($MyRow['deliverydate']);
			$_SESSION['Items' . $Identifier]->DelAdd1 = $MyRow['deladd1'];
			$_SESSION['Items' . $Identifier]->DelAdd2 = $MyRow['deladd2'];
			$_SESSION['Items' . $Identifier]->DelAdd3 = $MyRow['deladd3'];
			$_SESSION['Items' . $Identifier]->DelAdd4 = $MyRow['deladd4'];
			$_SESSION['Items' . $Identifier]->DelAdd5 = $MyRow['deladd5'];
			$_SESSION['Items' . $Identifier]->DelAdd6 = $MyRow['deladd6'];
			$_SESSION['Items' . $Identifier]->PhoneNo = $MyRow['contactphone'];
			$_SESSION['Items' . $Identifier]->Email = $MyRow['contactemail'];
			$_SESSION['Items' . $Identifier]->SalesPerson = $MyRow['salesperson'];
			$_SESSION['Items' . $Identifier]->Location = $MyRow['fromstkloc'];
			$_SESSION['Items' . $Identifier]->LocationName = $MyRow['locationname'];
			$_SESSION['Items' . $Identifier]->Quotation = $MyRow['quotation'];
			$_SESSION['Items' . $Identifier]->QuoteDate = ConvertSQLDate($MyRow['quotedate']);
			$_SESSION['Items' . $Identifier]->ConfirmedDate = ConvertSQLDate($MyRow['confirmeddate']);
			$_SESSION['Items' . $Identifier]->FreightCost = $MyRow['freightcost'];
			$_SESSION['Items' . $Identifier]->Orig_OrderDate = $MyRow['orddate'];
			$_SESSION['PrintedPackingSlip'] = $MyRow['printedpackingslip'];
			$_SESSION['DatePackingSlipPrinted'] = $MyRow['datepackingslipprinted'];
			$_SESSION['Items' . $Identifier]->DeliverBlind = $MyRow['deliverblind'];
			$_SESSION['Items' . $Identifier]->DefaultPOLine = $MyRow['customerpoline'];
			$_SESSION['Items' . $Identifier]->DeliveryDays = $MyRow['estdeliverydays'];

			//Get The exchange rate used for GPPercent calculations on adding or amending items
			if ($_SESSION['Items' . $Identifier]->DefaultCurrency != $_SESSION['CompanyRecord']['currencydefault']) {
				$ExRateResult = DB_query("SELECT rate FROM currencies WHERE currabrev='" . $_SESSION['Items' . $Identifier]->DefaultCurrency . "'");
				if (DB_num_rows($ExRateResult) > 0) {
					$ExRateRow = DB_fetch_row($ExRateResult);
					$ExRate = $ExRateRow[0];
				} //DB_num_rows($ExRateResult) > 0
				else {
					$ExRate = 1;
				}
			} //$_SESSION['Items' . $Identifier]->DefaultCurrency != $_SESSION['CompanyRecord']['currencydefault']
			else {
				$ExRate = 1;
			}

			/*need to look up customer name from debtors master then populate the line items array with the sales order details records */

			$LineItemsSQL = "SELECT salesorderdetails.orderlineno,
								salesorderdetails.stkcode,
								stockmaster.description,
								stockmaster.longdescription,
								stockmaster.volume,
								stockmaster.grossweight,
								stockmaster.units,
								stockmaster.serialised,
								stockmaster.nextserialno,
								stockmaster.eoq,
								salesorderdetails.unitprice,
								salesorderdetails.quantity,
								salesorderdetails.discountpercent,
								salesorderdetails.actualdispatchdate,
								salesorderdetails.qtyinvoiced,
								salesorderdetails.narrative,
								salesorderdetails.itemdue,
								salesorderdetails.poline,
								locstock.quantity as qohatloc,
								stockmaster.mbflag,
								stockmaster.discountcategory,
								stockmaster.decimalplaces,
								stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost AS standardcost,
								salesorderdetails.completed
							FROM salesorderdetails
							INNER JOIN stockmaster
								ON salesorderdetails.stkcode = stockmaster.stockid
							LEFT JOIN stockcosts
								ON stockcosts.stockid = stockmaster.stockid
								AND stockcosts.succeeded=0
							INNER JOIN locstock
								ON locstock.stockid = stockmaster.stockid
							WHERE  locstock.loccode = '" . $MyRow['fromstkloc'] . "'
								AND salesorderdetails.orderno ='" . $_GET['ModifyOrderNumber'] . "'
							ORDER BY salesorderdetails.orderlineno";

			$ErrMsg = _('The line items of the order cannot be retrieved because');
			$LineItemsResult = DB_query($LineItemsSQL, $ErrMsg);
			if (DB_num_rows($LineItemsResult) > 0) {
				while ($MyRow = DB_fetch_array($LineItemsResult)) {
					if ($MyRow['completed'] == 0) {
						$_SESSION['Items' . $Identifier]->add_to_cart($MyRow['stkcode'], $MyRow['quantity'], $MyRow['description'], $MyRow['longdescription'], $MyRow['unitprice'], $MyRow['discountpercent'], $MyRow['units'], $MyRow['volume'], $MyRow['grossweight'], $MyRow['qohatloc'], $MyRow['mbflag'], $MyRow['actualdispatchdate'], $MyRow['qtyinvoiced'], $MyRow['discountcategory'], 0, /*Controlled*/
						$MyRow['serialised'], $MyRow['decimalplaces'], $MyRow['narrative'], 'No', /* Update DB */
						$MyRow['orderlineno'], 0, '', ConvertSQLDate($MyRow['itemdue']), $MyRow['poline'], $MyRow['standardcost'], $MyRow['eoq'], $MyRow['nextserialno'], $ExRate, $Identifier);

						/*Just populating with existing order - no DBUpdates */
					} //$MyRow['completed'] == 0
					$LastLineNo = $MyRow['orderlineno'];
				} //$MyRow = DB_fetch_array($LineItemsResult)
				/* line items from sales order details */
				$_SESSION['Items' . $Identifier]->LineCounter = $LastLineNo + 1;
			} //end of checks on returned data set
			

			
		} //DB_num_rows($GetOrdHdrResult) == 1
		

		
	} //isset($_GET['ModifyOrderNumber']) and $_GET['ModifyOrderNumber'] != ''
	if (!isset($_SESSION['Items' . $Identifier])) {
		/* It must be a new order being created $_SESSION['Items'.$Identifier] would be set up from the order
		modification code above if a modification to an existing order. Also $ExistingOrder would be
		set to 1. The delivery check screen is where the details of the order are either updated or
		inserted depending on the value of ExistingOrder */

		$_SESSION['ExistingOrder' . $Identifier] = 0;
		$_SESSION['Items' . $Identifier] = new cart;
		$_SESSION['PrintedPackingSlip'] = 0;
		/*Of course cos the order aint even started !!*/

		if (($_SESSION['Items' . $Identifier]->DebtorNo == '' or !isset($_SESSION['Items' . $Identifier]->DebtorNo))) {
			/* need to select a customer for the first time out if authorisation allows it and if a customer
			has been selected for the order or not the session variable CustomerID holds the customer code
			already as determined from user id /password entry  */
			$_SESSION['RequireCustomerSelection'] = 1;
		} //($_SESSION['Items' . $Identifier]->DebtorNo == '' or !isset($_SESSION['Items' . $Identifier]->DebtorNo))
		else {
			$_SESSION['RequireCustomerSelection'] = 0;
		}
	} //!isset($_SESSION['Items' . $Identifier])
	if (isset($_POST['ChangeCustomer']) and $_POST['ChangeCustomer'] != '') {
		if ($_SESSION['Items' . $Identifier]->Any_Already_Delivered() == 0) {
			$_SESSION['RequireCustomerSelection'] = 1;
		} //$_SESSION['Items' . $Identifier]->Any_Already_Delivered() == 0
		else {
			prnMsg(_('The customer the order is for cannot be modified once some of the order has been invoiced'), 'warn');
		}
	} //isset($_POST['ChangeCustomer']) and $_POST['ChangeCustomer'] != ''
	//Customer logins are not allowed to select other customers hence in_array(2,$_SESSION['AllowedPageSecurityTokens'])
	if (isset($_POST['SearchCust']) and $_SESSION['RequireCustomerSelection'] == 1) {
		//insert wildcard characters in spaces
		$_POST['CustKeywords'] = mb_strtoupper(trim($_POST['CustKeywords']));
		$SearchString = str_replace(' ', '%', $_POST['CustKeywords']);

		$SQL = "SELECT custbranch.brname,
					custbranch.contactname,
					custbranch.phoneno,
					custbranch.faxno,
					custbranch.branchcode,
					custbranch.debtorno,
					debtorsmaster.name
				FROM custbranch
				LEFT JOIN debtorsmaster
					ON custbranch.debtorno=debtorsmaster.debtorno
				WHERE custbranch.brname " . LIKE . " '%" . $SearchString . "%'
					AND custbranch.branchcode " . LIKE . " '%" . mb_strtoupper(trim($_POST['CustCode'])) . "%'
					AND custbranch.phoneno " . LIKE . " '%" . trim($_POST['CustPhone']) . "%'
					AND custbranch.disabletrans=0";
		if ($_SESSION['SalesmanLogin'] != '') {
			$SQL.= " AND custbranch.salesman='" . $_SESSION['SalesmanLogin'] . "'";
		} //$_SESSION['SalesmanLogin'] != ''
		$SQL.= " ORDER BY custbranch.debtorno,
						custbranch.branchcode";

		$ErrMsg = _('The searched customer records requested cannot be retrieved because');
		$Result_CustSelect = DB_query($SQL, $ErrMsg);

		if (DB_num_rows($Result_CustSelect) == 1) {
			$MyRow = DB_fetch_array($Result_CustSelect);
			$SelectedCustomer = $MyRow['debtorno'];
			$SelectedBranch = $MyRow['branchcode'];
		} //DB_num_rows($Result_CustSelect) == 1
		elseif (DB_num_rows($Result_CustSelect) == 0) {
			prnMsg(_('No Customer Branch records contain the search criteria') . ' - ' . _('please try again') . ' - ' . _('Note a Customer Branch Name may be different to the Customer Name'), 'info');
		} //DB_num_rows($Result_CustSelect) == 0
		

		
	} //isset($_POST['SearchCust']) and $_SESSION['RequireCustomerSelection'] == 1)
	/*end of if search for customer codes/names */

	if (isset($_POST['JustSelectedACustomer']) and !isset($_POST['SearchCust'])) {
		/*Need to figure out the number of the form variable that the user clicked on */
		for ($i = 0;$i < count($_POST);$i++) { //loop through the returned customers
			if (isset($_POST['SubmitCustomerSelection' . $i])) {
				break;
			} //isset($_POST['SubmitCustomerSelection' . $i])
			

			
		} //$i = 0; $i < count($_POST); $i++
		if ($i == count($_POST) and !isset($SelectedCustomer)) { //if there is ONLY one customer searched at above, the $SelectedCustomer already setup, then there is a wrong warning
			prnMsg(_('Unable to identify the selected customer'), 'error');
		} elseif (!isset($SelectedCustomer)) {
			$SelectedCustomer = $_POST['SelectedCustomer' . $i];
			$SelectedBranch = $_POST['SelectedBranch' . $i];
		}
	} //isset($_POST['JustSelectedACustomer'])
	/* will only be true if page called from customer selection form or set because only one customer
	 record returned from a search so parse the $SelectCustomer string into customer code and branch code */
	if (isset($SelectedCustomer)) {
		$_SESSION['Items' . $Identifier]->DebtorNo = trim($SelectedCustomer);
		$_SESSION['Items' . $Identifier]->Branch = trim($SelectedBranch);

		// Now check to ensure this account is not on hold */
		$SQL = "SELECT debtorsmaster.name,
					holdreasons.dissallowinvoices,
					debtorsmaster.salestype,
					salestypes.sales_type,
					debtorsmaster.currcode,
					debtorsmaster.customerpoline,
					paymentterms.terms,
					currencies.decimalplaces
			FROM debtorsmaster INNER JOIN holdreasons
			ON debtorsmaster.holdreason=holdreasons.reasoncode
			INNER JOIN salestypes
			ON debtorsmaster.salestype=salestypes.typeabbrev
			INNER JOIN paymentterms
			ON debtorsmaster.paymentterms=paymentterms.termsindicator
			INNER JOIN currencies
			ON debtorsmaster.currcode=currencies.currabrev
			WHERE debtorsmaster.debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "'";

		$ErrMsg = _('The details of the customer selected') . ': ' . $_SESSION['Items' . $Identifier]->DebtorNo . ' ' . _('cannot be retrieved because');
		$DbgMsg = _('The SQL used to retrieve the customer details and failed was') . ':';
		$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

		$MyRow = DB_fetch_array($Result);
		if ($MyRow['dissallowinvoices'] != 1) {
			if ($MyRow['dissallowinvoices'] == 2) {
				prnMsg(_('The') . ' ' . htmlspecialchars($MyRow[0], ENT_QUOTES, 'UTF-8', false) . ' ' . _('account is currently flagged as an account that needs to be watched. Please contact the credit control personnel to discuss'), 'warn');
			} //$MyRow[1] == 2
			$_SESSION['RequireCustomerSelection'] = 0;
			$_SESSION['Items' . $Identifier]->CustomerName = $MyRow['name'];

			// the sales type determines the price list to be used by default the customer of the user is
			// defaulted from the entry of the userid and password.
			$_SESSION['Items' . $Identifier]->DefaultSalesType = $MyRow['salestype'];
			$_SESSION['Items' . $Identifier]->SalesTypeName = $MyRow['sales_type'];
			$_SESSION['Items' . $Identifier]->DefaultCurrency = $MyRow['currcode'];
			$_SESSION['Items' . $Identifier]->DefaultPOLine = $MyRow['customerpoline'];
			$_SESSION['Items' . $Identifier]->PaymentTerms = $MyRow['terms'];
			$_SESSION['Items' . $Identifier]->CurrDecimalPlaces = $MyRow['decimalplaces'];

			// the branch was also selected from the customer selection so default the delivery details from the customer branches table CustBranch. The order process will ask for branch details later anyway
			$Result = GetCustBranchDetails($Identifier);

			$MyRow = DB_fetch_array($Result);

			if ($_SESSION['SalesmanLogin'] != NULL and $_SESSION['SalesmanLogin'] != $MyRow['salesman']) {
				prnMsg(_('Your login is only set up for a particular salesperson. This customer has a different salesperson.'), 'error');
				include ('includes/footer.php');
				exit;
			} //$_SESSION['SalesmanLogin'] != NULL and $_SESSION['SalesmanLogin'] != $MyRow['salesman']
			$_SESSION['Items' . $Identifier]->DeliverTo = $MyRow['brname'];
			$_SESSION['Items' . $Identifier]->DelAdd1 = $MyRow['braddress1'];
			$_SESSION['Items' . $Identifier]->DelAdd2 = $MyRow['braddress2'];
			$_SESSION['Items' . $Identifier]->DelAdd3 = $MyRow['braddress3'];
			$_SESSION['Items' . $Identifier]->DelAdd4 = $MyRow['braddress4'];
			$_SESSION['Items' . $Identifier]->DelAdd5 = $MyRow['braddress5'];
			$_SESSION['Items' . $Identifier]->DelAdd6 = $MyRow['braddress6'];
			$_SESSION['Items' . $Identifier]->PhoneNo = $MyRow['phoneno'];
			$_SESSION['Items' . $Identifier]->Email = $MyRow['email'];
			$_SESSION['Items' . $Identifier]->Location = $MyRow['defaultlocation'];
			$_SESSION['Items' . $Identifier]->ShipVia = $MyRow['defaultshipvia'];
			$_SESSION['Items' . $Identifier]->DeliverBlind = $MyRow['deliverblind'];
			$_SESSION['Items' . $Identifier]->SpecialInstructions = $MyRow['specialinstructions'];
			$_SESSION['Items' . $Identifier]->DeliveryDays = $MyRow['estdeliverydays'];
			$_SESSION['Items' . $Identifier]->LocationName = $MyRow['locationname'];
			if ($_SESSION['SalesmanLogin'] != NULL and $_SESSION['SalesmanLogin'] != '') {
				$_SESSION['Items' . $Identifier]->SalesPerson = $_SESSION['SalesmanLogin'];
			} //$_SESSION['SalesmanLogin'] != NULL and $_SESSION['SalesmanLogin'] != ''
			else {
				$_SESSION['Items' . $Identifier]->SalesPerson = $MyRow['salesman'];
			}
			if ($_SESSION['Items' . $Identifier]->SpecialInstructions) prnMsg($_SESSION['Items' . $Identifier]->SpecialInstructions, 'warn');

			if ($_SESSION['CheckCreditLimits'] > 0) {
				/*Check credit limits is 1 for warn and 2 for prohibit sales */

				$_SESSION['Items' . $Identifier]->CreditAvailable = GetCreditAvailable($_SESSION['Items' . $Identifier]->DebtorNo);

				if ($_SESSION['CheckCreditLimits'] == 1 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0) {
					prnMsg(_('The') . ' ' . htmlspecialchars($MyRow[0], ENT_QUOTES, 'UTF-8', false) . ' ' . _('account is currently at or over their credit limit'), 'warn');
				} //$_SESSION['CheckCreditLimits'] == 1 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0
				elseif ($_SESSION['CheckCreditLimits'] == 2 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0) {
					prnMsg(_('No more orders can be placed by') . ' ' . htmlspecialchars($MyRow[0], ENT_QUOTES, 'UTF-8', false) . ' ' . _(' their account is currently at or over their credit limit'), 'warn');
					include ('includes/footer.php');
					exit;
				} //$_SESSION['CheckCreditLimits'] == 2 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0
				

				
			} //$_SESSION['CheckCreditLimits'] > 0
			

			
		} //$MyRow[1] != 1
		else {
			prnMsg(_('The') . ' ' . htmlspecialchars($MyRow[0], ENT_QUOTES, 'UTF-8', false) . ' ' . _('account is currently on hold please contact the credit control personnel to discuss'), 'warn');
		}

	} elseif ((!$_SESSION['Items' . $Identifier]->DefaultSalesType or $_SESSION['Items' . $Identifier]->DefaultSalesType == '') and !isset($_GET['NewOrder'])) {
		//Possible that the check to ensure this account is not on hold has not been done
		//if the customer is placing own order, if this is the case then
		//DefaultSalesType will not have been set as above
		$SQL = "SELECT debtorsmaster.name,
					holdreasons.dissallowinvoices,
					debtorsmaster.salestype,
					debtorsmaster.currcode,
					currencies.decimalplaces,
					debtorsmaster.customerpoline
			FROM debtorsmaster
			INNER JOIN holdreasons
				ON debtorsmaster.holdreason=holdreasons.reasoncode
			INNER JOIN currencies
				ON debtorsmaster.currcode=currencies.currabrev
			WHERE debtorsmaster.debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "'";

		$ErrMsg = _('The details for the customer selected') . ': ' . $_SESSION['Items' . $Identifier]->DebtorNo . ' ' . _('cannot be retrieved because');
		$DbgMsg = _('SQL used to retrieve the customer details was') . ':<br />' . $SQL;
		$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

		$MyRow = DB_fetch_array($Result);
		if ($MyRow[1] == 0) {
			$_SESSION['Items' . $Identifier]->CustomerName = $MyRow[0];

			// the sales type determines the price list to be used by default the customer of the user is
			// defaulted from the entry of the userid and password.
			$_SESSION['Items' . $Identifier]->DefaultSalesType = $MyRow['salestype'];
			$_SESSION['Items' . $Identifier]->DefaultCurrency = $MyRow['currcode'];
			$_SESSION['Items' . $Identifier]->CurrDecimalPlaces = $MyRow['decimalplaces'];
			$_SESSION['Items' . $Identifier]->Branch = $_SESSION['UserBranch'];
			$_SESSION['Items' . $Identifier]->DefaultPOLine = $MyRow['customerpoline'];

			// the branch would be set in the user data so default delivery details as necessary. However,
			// the order process will ask for branch details later anyway
			$Result = GetCustBranchDetails($Identifier);

			$MyRow = DB_fetch_array($Result);

			$_SESSION['Items' . $Identifier]->DeliverTo = $MyRow['brname'];
			$_SESSION['Items' . $Identifier]->DelAdd1 = $MyRow['braddress1'];
			$_SESSION['Items' . $Identifier]->DelAdd2 = $MyRow['braddress2'];
			$_SESSION['Items' . $Identifier]->DelAdd3 = $MyRow['braddress3'];
			$_SESSION['Items' . $Identifier]->DelAdd4 = $MyRow['braddress4'];
			$_SESSION['Items' . $Identifier]->DelAdd5 = $MyRow['braddress5'];
			$_SESSION['Items' . $Identifier]->DelAdd6 = $MyRow['braddress6'];
			$_SESSION['Items' . $Identifier]->PhoneNo = $MyRow['phoneno'];
			$_SESSION['Items' . $Identifier]->Email = $MyRow['email'];
			$_SESSION['Items' . $Identifier]->Location = $MyRow['defaultlocation'];
			$_SESSION['Items' . $Identifier]->DeliverBlind = $MyRow['deliverblind'];
			$_SESSION['Items' . $Identifier]->DeliveryDays = $MyRow['estdeliverydays'];
			$_SESSION['Items' . $Identifier]->LocationName = $MyRow['locationname'];
			if ($_SESSION['SalesmanLogin'] != NULL and $_SESSION['SalesmanLogin'] != '') {
				$_SESSION['Items' . $Identifier]->SalesPerson = $_SESSION['SalesmanLogin'];
			} else {
				$_SESSION['Items' . $Identifier]->SalesPerson = $MyRow['salesman'];
			}
		} //$MyRow[1] == 0
		else {
			prnMsg(_('Sorry, your account has been put on hold for some reason, please contact the credit control personnel.'), 'warn');
			include ('includes/footer.php');
			exit;
		}
	} //!$_SESSION['Items' . $Identifier]->DefaultSalesType or $_SESSION['Items' . $Identifier]->DefaultSalesType == ''
	if ($_SESSION['RequireCustomerSelection'] == 1 or !isset($_SESSION['Items' . $Identifier]->DebtorNo) or $_SESSION['Items' . $Identifier]->DebtorNo == '') {
		echo '<p class="page_title_text">
			<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/magnifier.png" title="', _('Search'), '" alt="" />', ' ', _('Enter an Order or Quotation'), ' : ', _('Search for the Customer Branch.'), '
		</p>';

		echo '<div class="page_help_text">', _('Orders/Quotations are placed against the Customer Branch. A Customer may have several Branches.'), '</div>';

		echo '<form action="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '?identifier=', urlencode($Identifier), '" method="post">';
		echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';

		echo '<fieldset>
			<legend>', _('Customer Search'), '</legend>
			<field>
				<label for="CustKeywords">', _('Part of the Customer Branch Name'), ':</label>
				<input type="search" name="CustKeywords" size="20" autofocus="autofocus" maxlength="25" />
			</field>
			<h1>', _('OR'), '</h1>
			<field>
				<label for="CustCode">', _('Part of the Customer Branch Code'), ':</label>
				<input type="search" name="CustCode" size="15" maxlength="18" />
			</field>
			<h1>', _('OR'), '</h1>
			<field>
				<label for="CustPhone">', _('Part of the Branch Phone Number'), ':</label>
				<input type="search" name="CustPhone" size="15" maxlength="18" />
			</field>
		</fieldset>
		<div class="centre">
			<input type="submit" name="SearchCust" value="', _('Search Now'), '" />
			<input type="reset" name="reset" value="', _('Reset'), '" />
		</div>';

		if (isset($Result_CustSelect)) {
			echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />
				<input type="hidden" name="JustSelectedACustomer" value="Yes" />
				<table>
					<thead>
						<tr>
							<th class="SortedColumn">', _('Customer'), '</th>
							<th class="SortedColumn">', _('Branch'), '</th>
							<th class="SortedColumn">', _('Contact'), '</th>
							<th>', _('Phone'), '</th>
							<th>', _('Fax'), '</th>
						</tr>
					</thead>';

			$j = 1;

			$LastCustomer = '';
			echo '<tbody>';
			while ($MyRow = DB_fetch_array($Result_CustSelect)) {
				if ($LastCustomer != $MyRow['name']) {
					echo '<tr class="striped_row">
						<td>' . htmlspecialchars($MyRow['name'], ENT_QUOTES, 'UTF-8', false) . '</td>';
				} //$LastCustomer != $MyRow['name']
				else {
					echo '<tr class="striped_row">
						<td></td>';
				}
				echo '<td><input type="submit" name="SubmitCustomerSelection', $j, '" value="', htmlspecialchars($MyRow['brname'], ENT_QUOTES, 'UTF-8', false), '" />
					<input type="hidden" name="SelectedCustomer', $j, '" value="', $MyRow['debtorno'], '" />
					<input type="hidden" name="SelectedBranch', $j, '" value="', $MyRow['branchcode'], '" /></td>
					<td>', $MyRow['contactname'], '</td>
					<td>', $MyRow['phoneno'], '</td>
					<td>', $MyRow['faxno'], '</td>
				</tr>';
				$LastCustomer = $MyRow['name'];
				++$j;
				//end of page full new headings if
				

				
			} //$MyRow = DB_fetch_array($Result_CustSelect)
			//end of while loop
			echo '</tbody>';
			echo '</table>';
		} //end if results to show
		echo '</form>';
		//end if RequireCustomerSelection
		

		
	} else { //dont require customer selection
		// everything below here only do if a customer is selected
		if (isset($_POST['CancelOrder'])) {
			$OK_to_delete = 1; //assume this in the first instance
			if ($_SESSION['ExistingOrder' . $Identifier] != 0) { //need to check that not already dispatched
				$SQL = "SELECT qtyinvoiced
					FROM salesorderdetails
					WHERE orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'
					AND qtyinvoiced>0";

				$InvQties = DB_query($SQL);

				if (DB_num_rows($InvQties) > 0) {
					$OK_to_delete = 0;

					prnMsg(_('There are lines on this order that have already been invoiced. Please delete only the lines on the order that are no longer required') . '<p>' . _('There is an option on confirming a dispatch/invoice to automatically cancel any balance on the order at the time of invoicing if you know the customer will not want the back order'), 'warn');
				} //DB_num_rows($InvQties) > 0
				

				
			} //$_SESSION['ExistingOrder' . $Identifier] != 0
			if ($OK_to_delete == 1) {
				if ($_SESSION['ExistingOrder' . $Identifier] != 0) {
					$SQL = "DELETE FROM salesorderdetails WHERE salesorderdetails.orderno ='" . $_SESSION['ExistingOrder' . $Identifier] . "'";
					$ErrMsg = _('The order detail lines could not be deleted because');
					$DelResult = DB_query($SQL, $ErrMsg);

					$SQL = "DELETE FROM salesorders WHERE salesorders.orderno='" . $_SESSION['ExistingOrder' . $Identifier] . "'";
					$ErrMsg = _('The order header could not be deleted because');
					$DelResult = DB_query($SQL, $ErrMsg);

					$_SESSION['ExistingOrder' . $Identifier] = 0;
				} //$_SESSION['ExistingOrder' . $Identifier] != 0
				unset($_SESSION['Items' . $Identifier]->LineItems);
				$_SESSION['Items' . $Identifier]->ItemsOrdered = 0;
				unset($_SESSION['Items' . $Identifier]);
				$_SESSION['Items' . $Identifier] = new cart;

				$_SESSION['RequireCustomerSelection'] = 0;
				prnMsg(_('This sales order has been cancelled as requested'), 'success');
				include ('includes/footer.php');
				exit;
			} //$OK_to_delete == 1
			

			
		} else {
			/*Not cancelling the order */

			echo '<p class="page_title_text">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/inventory.png" title="', _('Order'), '" alt="" />', ' ';

			if ($_SESSION['Items' . $Identifier]->Quotation == 1) {
				echo _('Quotation for customer'), ' ';
			} //$_SESSION['Items' . $Identifier]->Quotation == 1
			else {
				echo _('Order for customer'), ' ';
			}

			echo ':<b> ', stripslashes($_SESSION['Items' . $Identifier]->DebtorNo), ' ', _('Customer Name'), ': ', htmlspecialchars($_SESSION['Items' . $Identifier]->CustomerName, ENT_QUOTES, 'UTF-8', false);
			echo '</b></p>';

			echo '<div class="page_help_text">
				', '<b>', _('Default Options (can be modified during order)'), ':</b>
				<br />', _('Deliver To'), ':<b> ', htmlspecialchars($_SESSION['Items' . $Identifier]->DeliverTo, ENT_QUOTES, 'UTF-8', false), '</b>
				&nbsp;', _('From Location'), ':<b> ', $_SESSION['Items' . $Identifier]->LocationName, '</b>
				<br />', _('Sales Type'), '/', _('Price List'), ':<b> ', $_SESSION['Items' . $Identifier]->SalesTypeName, '</b>
				<br />', _('Terms'), ':<b> ', $_SESSION['Items' . $Identifier]->PaymentTerms, '</b>
			</div>';
		}

		$Msg = '';
		if (isset($_POST['Search']) or isset($_POST['Next']) or isset($_POST['Previous'])) {
			if (!empty($_POST['RawMaterialFlag'])) {
				$RawMaterialSellable = " OR stockcategory.stocktype='M'";
			} else {
				$RawMaterialSellable = '';
			}
			if (!empty($_POST['CustItemFlag'])) {
				$IncludeCustItem = " INNER JOIN custitem ON custitem.stockid=stockmaster.stockid
								AND custitem.debtorno='" . $_SESSION['Items' . $Identifier]->DebtorNo . "' ";
			} else {
				$IncludeCustItem = " LEFT OUTER JOIN custitem ON custitem.stockid=stockmaster.stockid
								AND custitem.debtorno='" . $_SESSION['Items' . $Identifier]->DebtorNo . "' ";
			}

			//insert wildcard characters in spaces
			$_POST['Keywords'] = mb_strtoupper($_POST['Keywords']);
			$KeywordsString = '%' . str_replace(' ', '%', $_POST['Keywords']) . '%';

			$_POST['StockCode'] = mb_strtoupper($_POST['StockCode']);
			$StockIdString = '%' . $_POST['StockCode'] . '%';

			if ($_POST['StockCat'] == 'All') {
				$_POST['StockCat'] = '%%';
			} //$_POST['StockCat'] == 'All'
			$SQL = "SELECT stockmaster.stockid,
						stockmaster.description,
						stockmaster.longdescription,
						stockmaster.units,
						custitem.cust_part,
						custitem.cust_description
					FROM stockmaster
					INNER JOIN stockcategory
						ON stockmaster.categoryid=stockcategory.categoryid" . $IncludeCustItem . "
					WHERE (stockcategory.stocktype='F' OR stockcategory.stocktype='D' OR stockcategory.stocktype='L' " . $RawMaterialSellable . ")
						AND stockmaster.mbflag <>'G'
						AND stockmaster.discontinued=0
						AND stockmaster.discontinued=0
						AND stockmaster.description " . LIKE . " '" . $KeywordsString . "'
						AND stockmaster.categoryid " . LIKE . " '" . $_POST['StockCat'] . "'
						AND stockmaster.stockid " . LIKE . " '" . $StockIdString . "'
					ORDER BY stockmaster.stockid";

			if (isset($_POST['Next'])) {
				$Offset = $_POST['NextList'];
			} //isset($_POST['Next'])
			if (isset($_POST['Previous'])) {
				$Offset = $_POST['PreviousList'];

			} //isset($_POST['Previous'])
			if (!isset($Offset) or $Offset < 0) {
				$Offset = 0;
			} //!isset($Offset) or $Offset < 0
			$SQL = $SQL . " LIMIT " . $_SESSION['DisplayRecordsMax'] . " OFFSET " . strval($_SESSION['DisplayRecordsMax'] * $Offset);

			$ErrMsg = _('There is a problem selecting the part records to display because');
			$DbgMsg = _('The SQL used to get the part selection was');

			$SearchResult = DB_query($SQL, $ErrMsg, $DbgMsg);

			if (DB_num_rows($SearchResult) == 0) {
				prnMsg(_('There are no products available meeting the criteria specified'), 'info');
			} //DB_num_rows($SearchResult) == 0
			if (DB_num_rows($SearchResult) == 1) {
				$MyRow = DB_fetch_array($SearchResult);
				$NewItem = $MyRow['stockid'];
				DB_data_seek($SearchResult, 0);
			} //DB_num_rows($SearchResult) == 1
			if (DB_num_rows($SearchResult) < $_SESSION['DisplayRecordsMax']) {
				$Offset = 0;
			} //DB_num_rows($SearchResult) < $_SESSION['DisplayRecordsMax']
			

			
		} //end of if search
		//Always do the stuff below if not looking for a customerid
		echo '<form action="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '?identifier=', urlencode($Identifier), '" id="SelectParts" method="post" enctype="multipart/form-data">';
		echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';
		echo '<input type="hidden" id="Identifier" value="', $Identifier, '" />';

		//Get The exchange rate used for GPPercent calculations on adding or amending items
		if ($_SESSION['Items' . $Identifier]->DefaultCurrency != $_SESSION['CompanyRecord']['currencydefault']) {
			$ExRateResult = DB_query("SELECT rate FROM currencies WHERE currabrev='" . $_SESSION['Items' . $Identifier]->DefaultCurrency . "'");
			if (DB_num_rows($ExRateResult) > 0) {
				$ExRateRow = DB_fetch_row($ExRateResult);
				$ExRate = $ExRateRow[0];
			} //DB_num_rows($ExRateResult) > 0
			else {
				$ExRate = 1;
			}
		} //$_SESSION['Items' . $Identifier]->DefaultCurrency != $_SESSION['CompanyRecord']['currencydefault']
		else {
			$ExRate = 1;
		}

		/*Process Quick Entry */
		/* If enter is pressed on the quick entry screen, the default button may be Recalculate */

		if (isset($_POST['SelectingOrderItems']) or isset($_POST['QuickEntry']) or isset($_POST['Recalculate'])) {
			/* get the item details from the database and hold them in the cart object */

			/*Discount can only be set later on  -- after quick entry -- so default discount to 0 in the first place */
			$AlreadyWarnedAboutCredit = false;
			$i = 1;
			while ($i <= $_SESSION['QuickEntries'] and isset($_POST['part_' . $i]) and $_POST['part_' . $i] != '') {
				$QuickEntryCode = 'part_' . $i;
				$QuickEntryQty = 'qty_' . $i;
				$QuickEntryPOLine = 'poline_' . $i;
				$QuickEntryItemDue = 'itemdue_' . $i;

				++$i;

				if (isset($_POST[$QuickEntryCode])) {
					$NewItem = mb_strtoupper($_POST[$QuickEntryCode]);
				} //isset($_POST[$QuickEntryCode])
				if (isset($_POST[$QuickEntryQty])) {
					$NewItemQty = filter_number_format($_POST[$QuickEntryQty]);
				} //isset($_POST[$QuickEntryQty])
				if (isset($_POST[$QuickEntryItemDue])) {
					$NewItemDue = $_POST[$QuickEntryItemDue];
				} //isset($_POST[$QuickEntryItemDue])
				else {
					$NewItemDue = DateAdd(Date($_SESSION['DefaultDateFormat']), 'd', $_SESSION['Items' . $Identifier]->DeliveryDays);
				}
				if (isset($_POST[$QuickEntryPOLine])) {
					$NewPOLine = $_POST[$QuickEntryPOLine];
				} //isset($_POST[$QuickEntryPOLine])
				else {
					$NewPOLine = 0;
				}

				if (!isset($NewItem)) {
					unset($NewItem);
					break;
					/* break out of the loop if nothing in the quick entry fields*/
				} //!isset($NewItem)
				if (!is_date($NewItemDue)) {
					prnMsg(_('An invalid date entry was made for ') . ' ' . $NewItem . ' ' . _('The date entry') . ' ' . $NewItemDue . ' ' . _('must be in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'warn');
					//Attempt to default the due date to something sensible?
					$NewItemDue = DateAdd(Date($_SESSION['DefaultDateFormat']), 'd', $_SESSION['Items' . $Identifier]->DeliveryDays);
				} //!is_date($NewItemDue)
				/*Now figure out if the item is a kit set - the field MBFlag='K'*/
				$SQL = "SELECT stockmaster.mbflag
					FROM stockmaster
					WHERE stockmaster.stockid='" . $NewItem . "'";

				$ErrMsg = _('Could not determine if the part being ordered was a kitset or not because');
				$DbgMsg = _('The sql that was used to determine if the part being ordered was a kitset or not was ');
				$KitResult = DB_query($SQL, $ErrMsg, $DbgMsg);

				if (DB_num_rows($KitResult) == 0) {
					prnMsg(_('The item code') . ' ' . $NewItem . ' ' . _('could not be retrieved from the database and has not been added to the order'), 'warn');
				} //DB_num_rows($KitResult) == 0
				elseif ($MyRow = DB_fetch_array($KitResult)) {
					if ($MyRow['mbflag'] == 'K') {
						/*It is a kit set item */
						$SQL = "SELECT bom.component,
							bom.quantity
							FROM bom
							WHERE bom.parent='" . $NewItem . "'
							AND bom.effectiveto > CURRENT_DATE
							AND bom.effectiveafter <= CURRENT_DATE";

						$ErrMsg = _('Could not retrieve kitset components from the database because') . ' ';
						$KitResult = DB_query($SQL, $ErrMsg, $DbgMsg);

						$ParentQty = $NewItemQty;
						while ($KitParts = DB_fetch_array($KitResult)) {
							$NewItem = $KitParts['component'];
							$NewItemQty = $KitParts['quantity'] * $ParentQty;
							$NewPOLine = 0;
							include ('includes/SelectOrderItems_IntoCart.php');
						} //$KitParts = DB_fetch_array($KitResult)
						

						
					} //$MyRow['mbflag'] == 'K'
					elseif ($MyRow['mbflag'] == 'G') {
						prnMsg(_('Phantom assemblies cannot be sold, these items exist only as bills of materials used in other manufactured items. The following item has not been added to the order') . ': ' . $NewItem, 'warn');
					} //$MyRow['mbflag'] == 'G'
					else {
						/*Its not a kit set item*/
						include ('includes/SelectOrderItems_IntoCart.php');
					}
				} //$MyRow = DB_fetch_array($KitResult)
				

				
			} //$i <= $_SESSION['QuickEntries'] and isset($_POST['part_' . $i]) and $_POST['part_' . $i] != ''
			unset($NewItem);
		} //isset($_POST['SelectingOrderItems']) or isset($_POST['QuickEntry']) or isset($_POST['Recalculate'])
		/* end of if quick entry */

		if (isset($_POST['AssetDisposalEntered'])) { //its an asset being disposed of
			if ($_POST['AssetToDisposeOf'] == 'NoAssetSelected') { //don't do anything unless an asset is disposed of
				prnMsg(_('No asset was selected to dispose of. No assets have been added to this customer order'), 'warn');
			} //$_POST['AssetToDisposeOf'] == 'NoAssetSelected'
			else { //need to add the asset to the order
				/*First need to create a stock ID to hold the asset and record the sale - as only stock items can be sold
				 * 		and before that we need to add a disposal stock category - if not already created
				 * 		first off get the details about the asset being disposed of */
				$AssetDetailsResult = DB_query("SELECT  fixedassets.description,
													fixedassets.longdescription,
													fixedassets.barcode,
													fixedassetcategories.costact,
													fixedassets.cost-fixedassets.accumdepn AS nbv
											FROM fixedassetcategories INNER JOIN fixedassets
											ON fixedassetcategories.categoryid=fixedassets.assetcategoryid
											WHERE fixedassets.assetid='" . $_POST['AssetToDisposeOf'] . "'");
				$AssetRow = DB_fetch_array($AssetDetailsResult);

				/* Check that the stock category for disposal "ASSETS" is defined already */
				$AssetCategoryResult = DB_query("SELECT categoryid FROM stockcategory WHERE categoryid='ASSETS'");
				if (DB_num_rows($AssetCategoryResult) == 0) {
					/*Although asset GL posting will come from the asset category - we should set the GL codes to something sensible
					 * based on the category of the asset under review at the moment - this may well change for any other assets sold subsequentely */

					/*OK now we can insert the stock category for this asset */
					$InsertAssetStockCatResult = DB_query("INSERT INTO stockcategory ( categoryid,
																				categorydescription,
																				stockact)
														VALUES ('ASSETS',
																'" . _('Asset Disposals') . "',
																'" . $AssetRow['costact'] . "')");
				} //DB_num_rows($AssetCategoryResult) == 0
				/*First check to see that it doesn't exist already assets are of the format "ASSET-" . $AssetID
				*/
				$TestAssetExistsAlreadyResult = DB_query("SELECT stockid
														FROM stockmaster
														WHERE stockid ='ASSET-" . $_POST['AssetToDisposeOf'] . "'");
				$j = 0;
				while (DB_num_rows($TestAssetExistsAlreadyResult) == 1) { //then it exists already ... bum
					++$j;
					$TestAssetExistsAlreadyResult = DB_query("SELECT stockid
														FROM stockmaster
														WHERE stockid ='ASSET-" . $_POST['AssetToDisposeOf'] . '-' . $j . "'");
				} //DB_num_rows($TestAssetExistsAlreadyResult) == 1
				if ($j > 0) {
					$AssetStockID = 'ASSET-' . $_POST['AssetToDisposeOf'] . '-' . $j;
				} //$j > 0
				else {
					$AssetStockID = 'ASSET-' . $_POST['AssetToDisposeOf'];
				}
				if ($AssetRow['nbv'] == 0) {
					$NBV = 0.001;
					/* stock must have a cost to be invoiced if the flag is set so set to 0.001 */
				} //$AssetRow['nbv'] == 0
				else {
					$NBV = $AssetRow['nbv'];
				}
				/*OK now we can insert the item for this asset */
				$InsertAssetAsStockItemSQL = "INSERT INTO stockmaster ( stockid,
																				description,
																				longdescription,
																				categoryid,
																				mbflag,
																				controlled,
																				serialised,
																				taxcatid)
										VALUES ('" . $AssetStockID . "',
												'" . DB_escape_string($AssetRow['description']) . "',
												'" . DB_escape_string($AssetRow['longdescription']) . "',
												'ASSETS',
												'D',
												'0',
												'0',
												'" . $_SESSION['DefaultTaxCategory'] . "')";
				$InsertAssetAsStockItemResult = DB_query($InsertAssetAsStockItemSQL);

				$InserAssetCostsSQL = "INSERT INTO stockcosts VALUES('" . $AssetStockID . "',
																'" . $NBV . "',
																0,
																0,
																CURRENT_TIME,
																0)";
				$InsertAssetCostsResult = DB_query($InserAssetCostsSQL);

				/*not forgetting the location records too */
				$InsertStkLocRecsResult = DB_query("INSERT INTO locstock (loccode,
																	stockid)
												SELECT loccode, '" . $AssetStockID . "'
												FROM locations");
				/*Now the asset has been added to the stock master we can add it to the sales order */
				$NewItemDue = date($_SESSION['DefaultDateFormat']);
				if (isset($_POST['POLine'])) {
					$NewPOLine = $_POST['POLine'];
				} //isset($_POST['POLine'])
				else {
					$NewPOLine = 0;
				}
				$NewItem = $AssetStockID;
				include ('includes/SelectOrderItems_IntoCart.php');
			} //end if adding a fixed asset to the order
			

			
		} //end if the fixed asset selection box was set
		/*Now do non-quick entry delete/edits/adds */

		if ((isset($_SESSION['Items' . $Identifier])) or isset($NewItem)) {
			if (isset($_GET['Delete'])) {
				//page called attempting to delete a line - GET['Delete'] = the line number to delete
				$QuantityAlreadyDelivered = $_SESSION['Items' . $Identifier]->Some_Already_Delivered($_GET['Delete']);
				if ($QuantityAlreadyDelivered == 0) {
					$_SESSION['Items' . $Identifier]->remove_from_cart($_GET['Delete'], 'Yes', $Identifier);
					/*Do update DB */
				} //$QuantityAlreadyDelivered == 0
				else {
					$_SESSION['Items' . $Identifier]->LineItems[$_GET['Delete']]->Quantity = $QuantityAlreadyDelivered;
				}
			} //isset($_GET['Delete'])
			$AlreadyWarnedAboutCredit = false;

			foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine) {
				if (isset($_POST['Quantity_' . $OrderLine->LineNumber])) {
					$Quantity = round(filter_number_format($_POST['Quantity_' . $OrderLine->LineNumber]), $OrderLine->DecimalPlaces);

					if (ABS($OrderLine->Price - filter_number_format($_POST['Price_' . $OrderLine->LineNumber])) > 0.01) {
						/*There is a new price being input for the line item */

						$Price = filter_number_format($_POST['Price_' . $OrderLine->LineNumber]);
						if (isset($_POST['Discount_' . $OrderLine->LineNumber]) and is_numeric(filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]))) {
							if ($_POST['Discount_' . $OrderLine->LineNumber] < 100) { //to avoid divided by zero error
								$_POST['GPPercent_' . $OrderLine->LineNumber] = (($Price * (1 - (filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]) / 100))) - $OrderLine->StandardCost * $ExRate) / ($Price * (1 - filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]) / 100) / 100);
							} else {
								$_POST['GPPercent_' . $OrderLine->LineNumber] = 0;
							}
						} else {
							$_POST['GPPercent_' . $OrderLine->LineNumber] = ($Price - $OrderLine->StandardCost * $ExRate) * 100 / $Price;
						}

					} elseif (isset($_POST['GPPercent_' . $OrderLine->LineNumber]) and ABS($OrderLine->GPPercent - filter_number_format($_POST['GPPercent_' . $OrderLine->LineNumber])) >= 0.01) {
						/* A GP % has been input so need to do a recalculation of the price at this new GP Percentage */

						prnMsg(_('Recalculated the price from the GP % entered - the GP % was') . ' ' . $OrderLine->GPPercent . '  the new GP % is ' . filter_number_format($_POST['GPPercent_' . $OrderLine->LineNumber]), 'info');

						$Price = ($OrderLine->StandardCost * $ExRate) / (1 - ((filter_number_format($_POST['GPPercent_' . $OrderLine->LineNumber]) + filter_number_format($_POST['Discount_' . $OrderLine->LineNumber])) / 100));
					} //ABS($OrderLine->GPPercent - filter_number_format($_POST['GPPercent_' . $OrderLine->LineNumber])) >= 0.01
					else {
						$Price = filter_number_format($_POST['Price_' . $OrderLine->LineNumber]);
						if (isset($_POST['Discount_' . $OrderLine->LineNumber]) and is_numeric(filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]))) {
							if ($_POST['Discount_' . $OrderLine->LineNumber] < 100 and $Price != 0) { //to avoid divided by zero error
								$_POST['GPPercent_' . $OrderLine->LineNumber] = (($Price * (1 - (filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]) / 100))) - $OrderLine->StandardCost * $ExRate) / ($Price * (1 - filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]) / 100) / 100);
							} else {
								$_POST['GPPercent_' . $OrderLine->LineNumber] = 0;
							}
						} else {
							$_POST['GPPercent_' . $OrderLine->LineNumber] = ($Price - $OrderLine->StandardCost * $ExRate) * 100 / $Price;
						}
					}
					if (isset($_POST['Discount_' . $OrderLine->LineNumber])) {
						$DiscountPercentage = filter_number_format($_POST['Discount_' . $OrderLine->LineNumber]);
					} else {
						$DiscountPercentage = 0;
					}
					if ($_SESSION['AllowOrderLineItemNarrative'] == 1) {
						$Narrative = $_POST['Narrative_' . $OrderLine->LineNumber];
					} //$_SESSION['AllowOrderLineItemNarrative'] == 1
					else {
						$Narrative = '';
					}

					if (!isset($OrderLine->DiscountPercent)) {
						$OrderLine->DiscountPercent = 0;
					} //!isset($OrderLine->DiscountPercent)
					if (!is_date($_POST['ItemDue_' . $OrderLine->LineNumber])) {
						prnMsg(_('An invalid date entry was made for ') . ' ' . $NewItem . ' ' . _('The date entry') . ' ' . $ItemDue . ' ' . _('must be in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'warn');
						//Attempt to default the due date to something sensible?
						$_POST['ItemDue_' . $OrderLine->LineNumber] = DateAdd(Date($_SESSION['DefaultDateFormat']), 'd', $_SESSION['Items' . $Identifier]->DeliveryDays);
					} //!is_date($_POST['ItemDue_' . $OrderLine->LineNumber])
					if ($Quantity < 0 or $Price < 0 or $DiscountPercentage > 100 or $DiscountPercentage < 0) {
						prnMsg(_('The item could not be updated because you are attempting to set the quantity ordered to less than 0 or the price less than 0 or the discount more than 100% or less than 0%'), 'warn');
					} //$Quantity < 0 or $Price < 0 or $DiscountPercentage > 100 or $DiscountPercentage < 0
					elseif ($_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber) != 0 and $_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->Price != $Price) {
						prnMsg(_('The item you attempting to modify the price for has already had some quantity invoiced at the old price the items unit price cannot be modified retrospectively'), 'warn');
					} //$_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber) != 0 and $_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->Price != $Price
					elseif ($_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber) != 0 and $_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->DiscountPercent != ($DiscountPercentage / 100)) {
						prnMsg(_('The item you attempting to modify has had some quantity invoiced at the old discount percent the items discount cannot be modified retrospectively'), 'warn');

					} //$_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber) != 0 and $_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->DiscountPercent != ($DiscountPercentage / 100)
					elseif ($_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->QtyInv > $Quantity) {
						prnMsg(_('You are attempting to make the quantity ordered a quantity less than has already been invoiced') . '. ' . _('The quantity delivered and invoiced cannot be modified retrospectively'), 'warn');
					} //$_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->QtyInv > $Quantity
					elseif ($OrderLine->Quantity != $Quantity or $OrderLine->Price != $Price or ABS($OrderLine->DiscountPercent - $DiscountPercentage / 100) > 0.001 or $OrderLine->Narrative != $Narrative or $OrderLine->ItemDue != $_POST['ItemDue_' . $OrderLine->LineNumber] or $OrderLine->POLine != $_POST['POLine_' . $OrderLine->LineNumber]) {
						$WithinCreditLimit = true;

						if ($_SESSION['CheckCreditLimits'] > 0 and $AlreadyWarnedAboutCredit == false) {
							/*Check credit limits is 1 for warn breach their credit limit and 2 for prohibit sales */
							$DifferenceInOrderValue = ($Quantity * $Price * (1 - $DiscountPercentage / 100)) - ($OrderLine->Quantity * $OrderLine->Price * (1 - $OrderLine->DiscountPercent));

							$_SESSION['Items' . $Identifier]->CreditAvailable-= $DifferenceInOrderValue;

							if ($_SESSION['CheckCreditLimits'] == 1 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0) {
								prnMsg(_('The customer account will breach their credit limit'), 'warn');
								$AlreadyWarnedAboutCredit = true;
							} //$_SESSION['CheckCreditLimits'] == 1 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0
							elseif ($_SESSION['CheckCreditLimits'] == 2 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0) {
								prnMsg(_('This change would put the customer over their credit limit and is prohibited'), 'warn');
								$WithinCreditLimit = false;
								$_SESSION['Items' . $Identifier]->CreditAvailable+= $DifferenceInOrderValue;
								$AlreadyWarnedAboutCredit = true;
							} //$_SESSION['CheckCreditLimits'] == 2 and $_SESSION['Items' . $Identifier]->CreditAvailable <= 0
							

							
						} //$_SESSION['CheckCreditLimits'] > 0 and $AlreadyWarnedAboutCredit == false
						/* The database data will be updated at this step, it will make big mistake if users do not know this and change the quantity to zero, unfortuately, the appearance shows that this change not allowed but the sales order details' quantity has been changed to zero in database. Must to filter this out! A zero quantity order line means nothing */
						if ($WithinCreditLimit and $Quantity > 0) {
							$_SESSION['Items' . $Identifier]->update_cart_item($OrderLine->LineNumber, $Quantity, $Price, ($DiscountPercentage / 100), $Narrative, 'Yes', /*Update DB */
							$_POST['ItemDue_' . $OrderLine->LineNumber], $_POST['POLine_' . $OrderLine->LineNumber], filter_number_format($_POST['GPPercent_' . $OrderLine->LineNumber]), $Identifier);
						} //within credit limit so make changes
						

						
					} //there are changes to the order line to process
					

					
				} //page not called from itself - POST variables not set
				

				
			} // Loop around all items on the order
			/* Now Run through each line of the order again to work out the appropriate discount from the discount matrix */
			$DiscCatsDone = array();

			foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine) {
				if ($OrderLine->DiscCat != '' and !in_array($OrderLine->DiscCat, $DiscCatsDone)) {
					$DiscCatsDone[] = $OrderLine->DiscCat;
					$QuantityOfDiscCat = 0;

					foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine_2) {
						/* add up total quantity of all lines of this DiscCat */
						if ($OrderLine_2->DiscCat == $OrderLine->DiscCat) {
							$QuantityOfDiscCat+= $OrderLine_2->Quantity;
						} //$OrderLine_2->DiscCat == $OrderLine->DiscCat
						

						
					} //$_SESSION['Items' . $Identifier]->LineItems as $OrderLine_2
					$Result = DB_query("SELECT MAX(discountrate) AS discount
									FROM discountmatrix
									WHERE salestype='" . $_SESSION['Items' . $Identifier]->DefaultSalesType . "'
									AND discountcategory ='" . $OrderLine->DiscCat . "'
									AND quantitybreak <= '" . $QuantityOfDiscCat . "'");
					$MyRow = DB_fetch_row($Result);
					if ($MyRow[0] == NULL) {
						$DiscountMatrixRate = 0;
					} //$MyRow[0] == NULL
					else {
						$DiscountMatrixRate = $MyRow[0];
					}
					if ($DiscountMatrixRate != 0) {
						/* need to update the lines affected */
						foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine_2) {
							if ($OrderLine_2->DiscCat == $OrderLine->DiscCat) {
								$_SESSION['Items' . $Identifier]->LineItems[$OrderLine_2->LineNumber]->DiscountPercent = $DiscountMatrixRate;
								$_SESSION['Items' . $Identifier]->LineItems[$OrderLine_2->LineNumber]->GPPercent = (($_SESSION['Items' . $Identifier]->LineItems[$OrderLine_2->LineNumber]->Price * (1 - $DiscountMatrixRate)) - $_SESSION['Items' . $Identifier]->LineItems[$OrderLine_2->LineNumber]->StandardCost * $ExRate) / ($_SESSION['Items' . $Identifier]->LineItems[$OrderLine_2->LineNumber]->Price * (1 - $DiscountMatrixRate) / 100);
							} //$OrderLine_2->DiscCat == $OrderLine->DiscCat
							

							
						} //$_SESSION['Items' . $Identifier]->LineItems as $OrderLine_2
						

						
					} //$MyRow[0] != 0
					

					
				} //$OrderLine->DiscCat != '' and !in_array($OrderLine->DiscCat, $DiscCatsDone)
				

				
			} //$_SESSION['Items' . $Identifier]->LineItems as $OrderLine
			/* end of discount matrix lookup code */
		} // the order session is started or there is a new item being added
		if (isset($_POST['DeliveryDetails'])) {

			$EarliestDispatch = CalcEarliestDispatchDate();

			if (isset($_SESSION['Items' . $Identifier]->SpecialInstructions) and mb_strlen($_SESSION['Items' . $Identifier]->SpecialInstructions) > 0) {
				prnMsg($_SESSION['Items' . $Identifier]->SpecialInstructions, 'info');
			} //isset($_SESSION['Items' . $Identifier]->SpecialInstructions) and mb_strlen($_SESSION['Items' . $Identifier]->SpecialInstructions) > 0
			echo '<p class="page_title_text">
		<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/inventory.png" title="', _('Delivery'), '" alt="" />', ' ', _('Delivery Details'), '
	</p>';

			echo '<p class="page_title_text">
		<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/customer.png" title="', _('Customer'), '" alt="" />', ' ', _('Customer Code'), ' :<b> ', stripslashes($_SESSION['Items' . $Identifier]->DebtorNo), '<br />
		</b>&nbsp;', _('Customer Name'), ' :<b> ', $_SESSION['Items' . $Identifier]->CustomerName, '</b>
	</p>';

			echo '<form action="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '?identifier=', urlencode($Identifier), '" method="post"  enctype="multipart/form-data">';
			echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';

			/*Display the order with or without discount depending on access level*/
			if (in_array(2, $_SESSION['AllowedPageSecurityTokens'])) {
				echo '<table>';

				if ($_SESSION['Items' . $Identifier]->Quotation == 1) {
					echo '<tr>
				<th colspan="7">', _('Quotation Summary'), '</th>
			</tr>';
				} //$_SESSION['Items' . $Identifier]->Quotation == 1
				else {
					echo '<tr>
				<th colspan="7">', _('Order Summary'), '</th>
			</tr>';
				}
				echo '<tr>
				<th>', _('Item Code'), '</th>
				<th>', _('Item Description'), '</th>
				<th>', _('Quantity'), '</th>
				<th>', _('Unit'), '</th>
				<th>', _('Price'), '</th>
				<th>', _('Discount'), ' %</th>
				<th>', _('Total'), '</th>
			</tr>';

				$_SESSION['Items' . $Identifier]->total = 0;
				$_SESSION['Items' . $Identifier]->totalVolume = 0;
				$_SESSION['Items' . $Identifier]->totalWeight = 0;

				foreach ($_SESSION['Items' . $Identifier]->LineItems as $StockItem) {
					$LineTotal = $StockItem->Quantity * $StockItem->Price * (1 - $StockItem->DiscountPercent);
					$DisplayLineTotal = locale_number_format($LineTotal, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
					$DisplayPrice = locale_number_format($StockItem->Price, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
					$DisplayQuantity = locale_number_format($StockItem->Quantity, $StockItem->DecimalPlaces);
					$DisplayDiscount = locale_number_format(($StockItem->DiscountPercent * 100), 2);

					echo '<tr class="striped_row">
				<td>', $StockItem->StockID, '</td>
				<td title="', $StockItem->LongDescription, '">', $StockItem->ItemDescription, '</td>
				<td class="number">', $DisplayQuantity, '</td>
				<td>', $StockItem->Units, '</td>
				<td class="number">', $DisplayPrice, '</td>
				<td class="number">', $DisplayDiscount, '</td>
				<td class="number">', $DisplayLineTotal, '</td>
			</tr>';

					$_SESSION['Items' . $Identifier]->total = $_SESSION['Items' . $Identifier]->total + $LineTotal;
					$_SESSION['Items' . $Identifier]->totalVolume = $_SESSION['Items' . $Identifier]->totalVolume + ($StockItem->Quantity * $StockItem->Volume);
					$_SESSION['Items' . $Identifier]->totalWeight = $_SESSION['Items' . $Identifier]->totalWeight + ($StockItem->Quantity * $StockItem->Weight);
				} //$_SESSION['Items' . $Identifier]->LineItems as $StockItem
				$DisplayTotal = number_format($_SESSION['Items' . $Identifier]->total, 2);
				echo '<tr class="striped_row">
			<td colspan="6" class="number"><b>', _('TOTAL Excl Tax/Freight'), '</b></td>
			<td class="number">' . $DisplayTotal . '</td>
		</tr>
		</table>';

				$DisplayVolume = locale_number_format($_SESSION['Items' . $Identifier]->totalVolume, 5);
				$DisplayWeight = locale_number_format($_SESSION['Items' . $Identifier]->totalWeight, 2);
				echo '<table>
			<tr class="striped_row">
				<td>', _('Total Weight'), ':</td>
				<td class="number">', $DisplayWeight, '</td>
				<td>', _('Total Volume'), ':</td>
				<td class="number">', $DisplayVolume, '</td>
			</tr>
		</table>';

			} //in_array(2, $_SESSION['AllowedPageSecurityTokens'])
			else {
				/*Display the order without discount */

				echo '<table>
			<tr>
				<th>', _('Item Description'), '</th>
				<th>', _('Quantity'), '</th>
				<th>', _('Unit'), '</th>
				<th>', _('Price'), '</th>
				<th>', _('Total'), '</th>
			</tr>';

				$_SESSION['Items' . $Identifier]->total = 0;
				$_SESSION['Items' . $Identifier]->totalVolume = 0;
				$_SESSION['Items' . $Identifier]->totalWeight = 0;
				$k = 0; // row colour counter
				foreach ($_SESSION['Items' . $Identifier]->LineItems as $StockItem) {
					$LineTotal = $StockItem->Quantity * $StockItem->Price * (1 - $StockItem->DiscountPercent);
					$DisplayLineTotal = locale_number_format($LineTotal, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
					$DisplayPrice = locale_number_format($StockItem->Price, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
					$DisplayQuantity = locale_number_format($StockItem->Quantity, $StockItem->DecimalPlaces);

					echo '<tr class="striped_row">
				<td>', $StockItem->ItemDescription, '</td>
				<td class="number">', $DisplayQuantity, '</td>
				<td>', $StockItem->Units, '</td>
				<td class="number">', $DisplayPrice, '</td>
				<td class="number">', $DisplayLineTotal, '</td>
			</tr>';

					$_SESSION['Items' . $Identifier]->total = $_SESSION['Items' . $Identifier]->total + $LineTotal;
					$_SESSION['Items' . $Identifier]->totalVolume = $_SESSION['Items' . $Identifier]->totalVolume + $StockItem->Quantity * $StockItem->Volume;
					$_SESSION['Items' . $Identifier]->totalWeight = $_SESSION['Items' . $Identifier]->totalWeight + $StockItem->Quantity * $StockItem->Weight;

				} //$_SESSION['Items' . $Identifier]->LineItems as $StockItem
				$DisplayTotal = locale_number_format($_SESSION['Items' . $Identifier]->total, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
				echo '</table>';
				$DisplayVolume = locale_number_format($_SESSION['Items' . $Identifier]->totalVolume, 5);
				$DisplayWeight = locale_number_format($_SESSION['Items' . $Identifier]->totalWeight, 2);
				echo '<table>
			<tr>
				<td>', _('Total Weight'), ':</td>
				<td>', $DisplayWeight, '</td>
				<td>', _('Total Volume'), ':</td>
				<td>', $DisplayVolume, '</td>
			</tr>
		</table>';
			}

			echo '<fieldset>
				<legend>', _('Delivery Details'), '</legend>';

			echo '<field>
				<label for="DeliverTo">', _('Deliver To'), ':</label>
				<input type="text" size="42" autofocus="autofocus" required="required" maxlength="40" name="DeliverTo" value="', stripslashes($_SESSION['Items' . $Identifier]->DeliverTo), '" />
			</field>';

			echo '<field>
				<label for="Location">', _('Deliver from the warehouse at'), ':</label>
				<select required="required" name="Location">';

			// BEGIN: **********************************************************************
			$SQL = "SELECT locations.loccode,
				locationname
			FROM locations
			INNER JOIN locationusers
				ON locationusers.loccode=locations.loccode
				AND locationusers.userid='" . $_SESSION['UserID'] . "'
				AND locationusers.canupd=1
			WHERE locations.allowinvoicing='1'
			ORDER BY locations.locationname";
			$ErrMsg = _('The stock locations could not be retrieved');
			$DbgMsg = _('SQL used to retrieve the stock locations was') . ':';

			$StkLocsResult = DB_query($SQL, $ErrMsg, $DbgMsg);
			// COMMENT: What if there is no authorized locations available for this user?
			while ($MyRow = DB_fetch_array($StkLocsResult)) {
				echo '<option', ($_SESSION['Items' . $Identifier]->Location == $MyRow['loccode'] ? ' selected="selected"' : ''), ' value="', $MyRow['loccode'], '">', $MyRow['locationname'], '</option>';
			}
			echo '</select>
			</field>';
			// END: ************************************************************************
			// Set the default date to earliest possible date if not set already
			if (!isset($_SESSION['Items' . $Identifier]->DeliveryDate)) {
				$_SESSION['Items' . $Identifier]->DeliveryDate = Date($_SESSION['DefaultDateFormat'], $EarliestDispatch);
			} //!isset($_SESSION['Items' . $Identifier]->DeliveryDate)
			if (!isset($_SESSION['Items' . $Identifier]->QuoteDate)) {
				$_SESSION['Items' . $Identifier]->QuoteDate = Date($_SESSION['DefaultDateFormat'], $EarliestDispatch);
			} //!isset($_SESSION['Items' . $Identifier]->QuoteDate)
			if (!isset($_SESSION['Items' . $Identifier]->ConfirmedDate)) {
				$_SESSION['Items' . $Identifier]->ConfirmedDate = Date($_SESSION['DefaultDateFormat'], $EarliestDispatch);
			} //!isset($_SESSION['Items' . $Identifier]->ConfirmedDate)
			// The estimated Dispatch date or Delivery date for this order
			echo '<field>
				<label for="DeliveryDate">', _('Estimated Delivery Date'), ':</label>
				<input class="date" type="text" size="15" maxlength="14" name="DeliveryDate" value="', $_SESSION['Items' . $Identifier]->DeliveryDate, '" />
			</field>';
			// The date when a quote was issued to the customer
			echo '<field>
				<label for="QuoteDate">', _('Quote Date'), ':</label>
				<input class="date" type="text" size="15" maxlength="14" name="QuoteDate" value="', $_SESSION['Items' . $Identifier]->QuoteDate, '" />
			</field>';
			// The date when the customer confirmed their order
			echo '<field>
				<label for="ConfirmedDate">', _('Confirmed Order Date'), ':</label>
				<input class="date" type="text" size="15" maxlength="14" name="ConfirmedDate" value="', $_SESSION['Items' . $Identifier]->ConfirmedDate, '" />
			</field>
			<field>
				<label for="BrAdd1">', _('Delivery Address 1'), ':</label>
				<input type="text" size="42" required="required" maxlength="40" name="BrAdd1" value="', $_SESSION['Items' . $Identifier]->DelAdd1, '" />
			</field>
			<field>
				<label for="BrAdd2">', _('Delivery Address 2'), ':</label>
				<input type="text" size="42" maxlength="40" name="BrAdd2" value="', $_SESSION['Items' . $Identifier]->DelAdd2, '" />
			</field>
			<field>
				<label for="BrAdd3">', _('Delivery Address 3'), ':</label>
				<input type="text" size="42" maxlength="40" name="BrAdd3" value="', $_SESSION['Items' . $Identifier]->DelAdd3, '" />
			</field>
			<field>
				<label for="BrAdd4">', _('Delivery Address 4'), ':</label>
				<input type="text" size="42" maxlength="40" name="BrAdd4" value="', $_SESSION['Items' . $Identifier]->DelAdd4, '" />
			</field>
			<field>
				<label for="BrAdd5">', _('Delivery Address 5'), ':</label>
				<input type="text" size="42" maxlength="40" name="BrAdd5" value="', $_SESSION['Items' . $Identifier]->DelAdd5, '" />
			</field>';
			echo '<field>
				<label for="BrAdd6">', _('Country'), ':</label>
				<select name="BrAdd6">';
			foreach ($CountriesArray as $CountryEntry => $CountryName) {
				if (isset($_POST['BrAdd6']) and (strtoupper($_POST['BrAdd6']) == strtoupper($CountryName))) {
					echo '<option selected="selected" value="', $CountryName, '">', $CountryName, '</option>';
				} elseif (!isset($_POST['BrAdd6']) and $CountryName == $_SESSION['Items' . $Identifier]->DelAdd6) {
					echo '<option selected="selected" value="', $CountryName, '">', $CountryName, '</option>';
				} else {
					echo '<option value="', $CountryName, '">', $CountryName, '</option>';
				}
			}
			echo '</select>
			</field>';
			echo '<field>
				<label for="PhoneNo">', _('Contact Phone Number'), ':</label>
				<input type="tel" size="25" maxlength="25" name="PhoneNo" value="', $_SESSION['Items' . $Identifier]->PhoneNo, '" />
			</field>
			<field>
				<label for="Email">', _('Contact Email'), ':</label>
				<input type="email" size="40" maxlength="38" name="Email" value="', $_SESSION['Items' . $Identifier]->Email, '" />
			</field>
			<field>
				<label for="CustRef">', _('Customer Reference'), ':</label>
				<input type="text" size="25" maxlength="50" name="CustRef" value="', $_SESSION['Items' . $Identifier]->CustRef, '" />
			</field>
			<field>
				<label for="Comments">', _('Comments'), ':</label>
				<textarea name="Comments" cols="31" rows="5">', $_SESSION['Items' . $Identifier]->Comments, '</textarea>
			</field>';

			if (isset($SupplierLogin) and $SupplierLogin == 0) {
				echo '<input type="hidden" name="SalesPerson" value="', $_SESSION['Items' . $Identifier]->SalesPerson, '" />
					<input type="hidden" name="DeliverBlind" value="1" />
					<input type="hidden" name="FreightCost" value="0" />
					<input type="hidden" name="ShipVia" value="', $_SESSION['Items' . $Identifier]->ShipVia, '" />
					<input type="hidden" name="Quotation" value="0" />';
			} //isset($SupplierLogin) and $SupplierLogin == 0
			else {
				echo '<field>
					<label for="SalesPerson">', _('Sales person'), ':</label>
					<select name="SalesPerson">';
				$SalesPeopleResult = DB_query("SELECT salesmancode, salesmanname FROM salesman WHERE current=1");
				if (!isset($_POST['SalesPerson']) and $_SESSION['SalesmanLogin'] != NULL) {
					$_SESSION['Items' . $Identifier]->SalesPerson = $_SESSION['SalesmanLogin'];
				} //!isset($_POST['SalesPerson']) AND $_SESSION['SalesmanLogin'] != NULL
				while ($SalesPersonRow = DB_fetch_array($SalesPeopleResult)) {
					if ($SalesPersonRow['salesmancode'] == $_SESSION['Items' . $Identifier]->SalesPerson) {
						echo '<option selected="selected" value="', $SalesPersonRow['salesmancode'], '">', $SalesPersonRow['salesmanname'], '</option>';
					} //$SalesPersonRow['salesmancode'] == $_SESSION['Items' . $Identifier]->SalesPerson
					else {
						echo '<option value="', $SalesPersonRow['salesmancode'], '">', $SalesPersonRow['salesmanname'], '</option>';
					}
				} //$SalesPersonRow = DB_fetch_array($SalesPeopleResult)
				echo '</select>
				</field>';

				/* This field will control whether or not to display the company logo and
				 address on the packlist */

				echo '<field>
					<label for="DeliverBlind">', _('Packlist Type'), ':</label>
					<select name="DeliverBlind">';

				if ($_SESSION['Items' . $Identifier]->DeliverBlind == 2) {
					echo '<option value="1">', _('Show Company Details/Logo'), '</option>';
					echo '<option selected="selected" value="2">', _('Hide Company Details/Logo'), '</option>';
				} //$_SESSION['Items' . $Identifier]->DeliverBlind == 2
				else {
					echo '<option selected="selected" value="1">', _('Show Company Details/Logo'), '</option>';
					echo '<option value="2">', _('Hide Company Details/Logo'), '</option>';
				}
			}

			echo '</select>
			</field>';

			if (isset($_SESSION['PrintedPackingSlip']) and $_SESSION['PrintedPackingSlip'] == 1) {
				echo '<field>
					<label for="ReprintPackingSlip">', _('Reprint packing slip'), ':</label>
					<select name="ReprintPackingSlip">
						<option value="0">', _('Yes'), '</option>
						<option selected="selected" value="1">', _('No'), '</option>
					</select>
					', _('Last printed'), ': ', ConvertSQLDate($_SESSION['DatePackingSlipPrinted']), '
				</field>';
			} //isset($_SESSION['PrintedPackingSlip']) AND $_SESSION['PrintedPackingSlip'] == 1
			else {
				echo '<input type="hidden" name="ReprintPackingSlip" value="0" />';
			}

			echo '<field>
				<label for="FreightCost">', _('Charge Freight Cost ex tax'), ':</label>
				<input type="text" class="number" size="10" maxlength="12" name="FreightCost" value="', $_SESSION['Items' . $Identifier]->FreightCost, '" />';

			if ($_SESSION['DoFreightCalc'] == true) {
				echo '<input type="submit" name="Update" value="', _('Recalc Freight Cost'), '" />';
			} //$_SESSION['DoFreightCalc'] == true
			echo '</field>';

			if ((!isset($_POST['ShipVia']) or $_POST['ShipVia'] == '') and isset($_SESSION['Items' . $Identifier]->ShipVia)) {
				$_POST['ShipVia'] = $_SESSION['Items' . $Identifier]->ShipVia;
			} //(!isset($_POST['ShipVia']) OR $_POST['ShipVia'] == '') AND isset($_SESSION['Items' . $Identifier]->ShipVia)
			echo '<field>
				<label for="ShipVia">', _('Freight/Shipper Method'), ':</label>
				<select name="ShipVia">';
			$ErrMsg = _('The shipper details could not be retrieved');
			$DbgMsg = _('SQL used to retrieve the shipper details was') . ':';

			$SQL = "SELECT shipper_id, shippername FROM shippers";
			$ShipperResults = DB_query($SQL, $ErrMsg, $DbgMsg);
			while ($MyRow = DB_fetch_array($ShipperResults)) {
				if ($MyRow['shipper_id'] == $_POST['ShipVia']) {
					echo '<option selected="selected" value="', $MyRow['shipper_id'], '">', $MyRow['shippername'], '</option>';
				} //$MyRow['shipper_id'] == $_POST['ShipVia']
				else {
					echo '<option value="', $MyRow['shipper_id'], '">', $MyRow['shippername'], '</option>';
				}
			} //$MyRow = DB_fetch_array($ShipperResults)
			echo '</select>
			</field>';

			echo '<field>
				<label for="Quotation">', _('Quotation Only'), ':</label>
				<select name="Quotation">';
			if ($_SESSION['Items' . $Identifier]->Quotation == 1) {
				echo '<option selected="selected" value="1">', _('Yes'), '</option>';
				echo '<option value="0">', _('No'), '</option>';
			} //$_SESSION['Items' . $Identifier]->Quotation == 1
			else {
				echo '<option value="1">', _('Yes'), '</option>';
				echo '<option selected="selected" value="0">', _('No'), '</option>';
			}
			echo '</select>
			</field>';

			echo '<field>
				<label for="Attachment">', _('Order Attachment'), '</label>
				<input type="file" name="Attachment" id="Attachment" />
			</field>';

			echo '</fieldset>';

			echo '<div class="centre">
				<input type="submit" name="BackToLineDetails" value="', _('Modify Order Lines'), '" /><br />';

			if ($_SESSION['ExistingOrder' . $Identifier] == 0) {
				echo '<input type="submit" name="ProcessOrder" value="', _('Place Order'), '" /><br />';
				echo '<a href="' . $RootPath . '/RecurringSalesOrders.php?identifier=', urlencode($Identifier), '&amp;NewRecurringOrder=Yes">', _('Create Recurring Order'), '</a><br /><br />';
			} //$_SESSION['ExistingOrder' . $Identifier] == 0
			else {
				echo '<input type="submit" name="ProcessOrder" value="', _('Commit Order Changes'), '" />';
			}

			echo '</form>';
			include ('includes/footer.php');
			exit;
		} //isset($_POST['DeliveryDetails'])
		if (isset($NewItem)) {
			/* get the item details from the database and hold them in the cart object make the quantity 1 by default then add it to the cart */
			/*Now figure out if the item is a kit set - the field MBFlag='K'*/
			$SQL = "SELECT stockmaster.mbflag
		   		FROM stockmaster
				WHERE stockmaster.stockid='" . $NewItem . "'";

			$ErrMsg = _('Could not determine if the part being ordered was a kitset or not because');

			$KitResult = DB_query($SQL, $ErrMsg);

			$NewItemQty = 1;
			/*By Default */
			$Discount = 0;
			/*By default - can change later or discount category override */

			if ($MyRow = DB_fetch_array($KitResult)) {
				if ($MyRow['mbflag'] == 'K') {
					/*It is a kit set item */
					$SQL = "SELECT bom.component,
							bom.quantity
						FROM bom
						WHERE bom.parent='" . $NewItem . "'
						AND bom.effectiveto > CURRENT_DATE
						AND bom.effectiveafter <= CURRENT_DATE";

					$ErrMsg = _('Could not retrieve kitset components from the database because');
					$KitResult = DB_query($SQL, $ErrMsg);

					$ParentQty = $NewItemQty;
					while ($KitParts = DB_fetch_array($KitResult)) {
						$NewItem = $KitParts['component'];
						$NewItemQty = $KitParts['quantity'] * $ParentQty;
						$NewPOLine = 0;
						$NewItemDue = date($_SESSION['DefaultDateFormat']);
						include ('includes/SelectOrderItems_IntoCart.php');
					} //$KitParts = DB_fetch_array($KitResult)
					

					
				} //$MyRow['mbflag'] == 'K'
				else {
					/*Its not a kit set item*/
					$NewItemDue = date($_SESSION['DefaultDateFormat']);
					$NewPOLine = 0;

					include ('includes/SelectOrderItems_IntoCart.php');
				}

			} //$MyRow = DB_fetch_array($KitResult)
			/* end of if its a new item */

		} //isset($NewItem)
		if (isset($NewItemArray) and isset($_POST['SelectingOrderItems'])) {
			/* get the item details from the database and hold them in the cart object make the quantity 1 by default then add it to the cart */
			/*Now figure out if the item is a kit set - the field MBFlag='K'*/
			$AlreadyWarnedAboutCredit = false;
			foreach ($NewItemArray as $NewItem => $NewItemQty) {
				if ($NewItemQty > 0) {
					$SQL = "SELECT stockmaster.mbflag
						FROM stockmaster
						WHERE stockmaster.stockid='" . $NewItem . "'";

					$ErrMsg = _('Could not determine if the part being ordered was a kitset or not because');

					$KitResult = DB_query($SQL, $ErrMsg);

					//$NewItemQty = 1; /*By Default */
					$Discount = 0;
					/*By default - can change later or discount category override */

					if ($MyRow = DB_fetch_array($KitResult)) {
						if ($MyRow['mbflag'] == 'K') {
							/*It is a kit set item */
							$SQL = "SELECT bom.component,
										bom.quantity
								FROM bom
								WHERE bom.parent='" . $NewItem . "'
								AND bom.effectiveto > CURRENT_DATE
								AND bom.effectiveafter <= CURRENT_DATE";

							$ErrMsg = _('Could not retrieve kitset components from the database because');
							$KitResult = DB_query($SQL, $ErrMsg);

							$ParentQty = $NewItemQty;
							while ($KitParts = DB_fetch_array($KitResult)) {
								$NewItem = $KitParts['component'];
								$NewItemQty = $KitParts['quantity'] * $ParentQty;
								$NewItemDue = date($_SESSION['DefaultDateFormat']);
								$NewPOLine = 0;
								include ('includes/SelectOrderItems_IntoCart.php');
							} //$KitParts = DB_fetch_array($KitResult)
							

							
						} //$MyRow['mbflag'] == 'K'
						else {
							/*Its not a kit set item*/
							$NewItemDue = date($_SESSION['DefaultDateFormat']);
							$NewPOLine = 0;
							include ('includes/SelectOrderItems_IntoCart.php');
						}
					} //$MyRow = DB_fetch_array($KitResult)
					/* end of if its a new item */
				} //$NewItemQty > 0
				/*end of if its a new item */
			} //$NewItemArray as $NewItem => $NewItemQty
			/* loop through NewItem array */
		} //isset($NewItemArray) and isset($_POST['SelectingOrderItems'])
		/* if the NewItem_array is set */

		/* Run through each line of the order and work out the appropriate discount from the discount matrix */
		$DiscCatsDone = array();
		$Counter = 0;
		foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine) {
			if ($OrderLine->DiscCat != "" and !in_array($OrderLine->DiscCat, $DiscCatsDone)) {
				$DiscCatsDone[$Counter] = $OrderLine->DiscCat;
				$QuantityOfDiscCat = 0;

				foreach ($_SESSION['Items' . $Identifier]->LineItems as $StkItems_2) {
					/* add up total quantity of all lines of this DiscCat */
					if ($StkItems_2->DiscCat == $OrderLine->DiscCat) {
						$QuantityOfDiscCat+= $StkItems_2->Quantity;
					} //$StkItems_2->DiscCat == $OrderLine->DiscCat
					

					
				} //$_SESSION['Items' . $Identifier]->LineItems as $StkItems_2
				$Result = DB_query("SELECT MAX(discountrate) AS discount
								FROM discountmatrix
								WHERE salestype='" . $_SESSION['Items' . $Identifier]->DefaultSalesType . "'
								AND discountcategory ='" . $OrderLine->DiscCat . "'
								AND quantitybreak <= '" . $QuantityOfDiscCat . "'");
				$MyRow = DB_fetch_row($Result);
				if ($MyRow[0] == NULL) {
					$DiscountMatrixRate = 0;
				} //$MyRow[0] == NULL
				else {
					$DiscountMatrixRate = $MyRow[0];
				}
				if ($DiscountMatrixRate != 0) {
					foreach ($_SESSION['Items' . $Identifier]->LineItems as $StkItems_2) {
						if ($StkItems_2->DiscCat == $OrderLine->DiscCat) {
							$_SESSION['Items' . $Identifier]->LineItems[$StkItems_2->LineNumber]->DiscountPercent = $DiscountMatrixRate;
						}
					} //$StkItems_2->DiscCat == $OrderLine->DiscCat
					

					
				} //$_SESSION['Items' . $Identifier]->LineItems as $StkItems_2
				

				
			} //$OrderLine->DiscCat != "" and !in_array($OrderLine->DiscCat, $DiscCatsDone)
			

			
		} //$_SESSION['Items' . $Identifier]->LineItems as $OrderLine
		/* end of discount matrix lookup code */

		if (count($_SESSION['Items' . $Identifier]->LineItems) > 0) {
			/*only show order lines if there are any */

			/* This is where the order as selected should be displayed  reflecting any deletions or insertions*/
			if ($_SESSION['Items' . $Identifier]->DefaultPOLine == 1) { // Does customer require PO Line number by sales order line?
				$ShowPOLine = 1; // Show one additional column:  'PO Line'.
				

				
			} else {
				$ShowPOLine = 0; // Do NOT show 'PO Line'.
				

				
			}

			if (in_array(1000, $_SESSION['AllowedPageSecurityTokens'])) { //Is it an internal user with appropriate permissions?
				$ShowDiscountGP = 2; // Show two additional columns: 'Discount' and 'GP %'.
				

				
			} else {
				$ShowDiscountGP = 0; // Do NOT show 'Discount' and 'GP %'.
				

				
			}

			echo '<div class="page_help_text">', _('Quantity (required) - Enter the number of units ordered.  Price (required) - Enter the unit price.  Discount (optional) - Enter a percentage discount.  GP% (optional) - Enter a percentage Gross Profit (GP) to add to the unit cost.  Due Date (optional) - Enter a date for delivery. Items bordered in red do not have enough stock to fulfil the order.'), '</div>';
			echo '<table width="90%" cellpadding="2" style="border-collapse: collapse;">
				<tr>';
			if ($ShowPOLine) {
				echo '<th>', _('PO Line'), '</th>';
			} //$_SESSION['Items' . $Identifier]->DefaultPOLine == 1
			echo '<th>', _('Item Code'), '</th>
				<th>', _('Item Description'), '</th>
				<th>', _('Quantity'), '</th>
				<th>', _('QOH'), '</th>
				<th>', _('Unit'), '</th>
				<th>', _('Price'), '</th>';

			if ($ShowDiscountGP) {
				echo '<th>', _('Discount'), '</th>
				<th>', _('GP %'), '</th>';
			} //in_array(1000, $_SESSION['AllowedPageSecurityTokens'])
			echo '<th>', _('Total'), '</th>
			<th>', _('Due Date'), '</th>
			<th>&nbsp;</th>
		</tr>';

			$_SESSION['Items' . $Identifier]->total = 0;
			$_SESSION['Items' . $Identifier]->totalVolume = 0;
			$_SESSION['Items' . $Identifier]->totalWeight = 0;

			foreach ($_SESSION['Items' . $Identifier]->LineItems as $OrderLine) {
				$LineTotal = $OrderLine->Quantity * $OrderLine->Price * (1 - $OrderLine->DiscountPercent);
				$DisplayLineTotal = locale_number_format($LineTotal, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
				$DisplayDiscount = locale_number_format(($OrderLine->DiscountPercent * 100), 2);
				$QtyOrdered = $OrderLine->Quantity;
				$QtyRemain = $QtyOrdered - $OrderLine->QtyInv;

				if ($OrderLine->QOHatLoc < $OrderLine->Quantity and ($OrderLine->MBflag == 'B' or $OrderLine->MBflag == 'M')) {
					/*There is a stock deficiency in the stock location selected */
					echo '<tr class="error_row">'; //rows show red where stock deficiency
					

					
				} else {
					echo '<tr class="striped_row">';
				}

				if ($ShowPOLine) { // Show the input field only if required.
					echo '<td><input maxlength="20" name="POLine_', $OrderLine->LineNumber, '" size="20" type="text" value="', $OrderLine->POLine, '" /></td>';
				} else {
					echo '<input name="POLine_', $OrderLine->LineNumber, '" type="hidden" value="" />';
				}

				echo '<td><a href="', $RootPath, '/StockStatus.php?identifier=', urlencode($Identifier), '&amp;StockID=', urlencode($OrderLine->StockID), '&amp;DebtorNo=', urlencode($_SESSION['Items' . $Identifier]->DebtorNo), '" target="_blank">', $OrderLine->StockID, '</a></td>
				<td title="', $OrderLine->LongDescription, '">', $OrderLine->ItemDescription, '</td>';

				echo '<td><input class="number" type="text" name="Quantity_', $OrderLine->LineNumber, '" size="6" required="required" maxlength="11" value="', locale_number_format($OrderLine->Quantity, $OrderLine->DecimalPlaces), '" />';
				if ($QtyRemain != $QtyOrdered) {
					echo '<br />', locale_number_format($OrderLine->QtyInv, $OrderLine->DecimalPlaces), ' ', _('of'), ' ', locale_number_format($OrderLine->Quantity, $OrderLine->DecimalPlaces), ' ', _('invoiced');
				} //$QtyRemain != $QtyOrdered
				echo '</td>
					<td class="number">', locale_number_format($OrderLine->QOHatLoc, $OrderLine->DecimalPlaces), '</td>
					<td>', $OrderLine->Units, '</td>';

				if (in_array(1000, $_SESSION['AllowedPageSecurityTokens'])) {
					/*OK to display with discount if it is an internal user with appropriate permissions */
					echo '<td><input class="number" type="text" name="Price_', $OrderLine->LineNumber, '" size="16" required="required" maxlength="16" value="', locale_number_format($OrderLine->Price, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces), '" /></td>
					<td><input class="number" type="text" name="Discount_', $OrderLine->LineNumber, '" size="5" required="required" maxlength="4" value="', locale_number_format(($OrderLine->DiscountPercent * 100), 2), '" /></td>
					<td><input class="number" type="text" name="GPPercent_', $OrderLine->LineNumber, '" size="4" required="required" maxlength="40" value="', locale_number_format($OrderLine->GPPercent, 2), '" /></td>';
				} //in_array(1000, $_SESSION['AllowedPageSecurityTokens'])
				else {
					echo '<td class="number">', locale_number_format($OrderLine->Price, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
					echo '<input type="hidden" name="Price_', $OrderLine->LineNumber, '" value="', locale_number_format($OrderLine->Price, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces), '" /></td>';
				}
				if ($_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber)) {
					$RemTxt = _('Clear Remaining');
				} //$_SESSION['Items' . $Identifier]->Some_Already_Delivered($OrderLine->LineNumber)
				else {
					$RemTxt = _('Delete');
				}
				echo '<td class="number">', $DisplayLineTotal, '</td>';
				$LineDueDate = $OrderLine->ItemDue;
				if (!is_date($OrderLine->ItemDue)) {
					$LineDueDate = DateAdd(Date($_SESSION['DefaultDateFormat']), 'd', $_SESSION['Items' . $Identifier]->DeliveryDays);
					$_SESSION['Items' . $Identifier]->LineItems[$OrderLine->LineNumber]->ItemDue = $LineDueDate;
				} //!is_date($OrderLine->ItemDue)
				echo '<td><input type="text" class="date" name="ItemDue_', $OrderLine->LineNumber, '" size="10" required="required" maxlength="10" value="', $LineDueDate, '" /></td>';

				echo '<td><a href="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '?identifier=', urlencode($Identifier), '&amp;Delete=', $OrderLine->LineNumber, '" onclick="return MakeConfirm(\'', _('Are You Sure?'), '\', \'Confirm Delete\', this);">', $RemTxt, '</a></td></tr>';

				if ($_SESSION['AllowOrderLineItemNarrative'] == 1) {
					echo '<tr><td colspan="10">', _('Narrative'), ':<textarea name="Narrative_', $OrderLine->LineNumber, '" cols="100%" rows="1">', stripslashes(AddCarriageReturns($OrderLine->Narrative)), '</textarea><br /></td></tr>';
				} //$_SESSION['AllowOrderLineItemNarrative'] == 1
				else {
					echo '<tr><td><input type="hidden" name="Narrative" value="" /></td></tr>';
				}

				$_SESSION['Items' . $Identifier]->total = $_SESSION['Items' . $Identifier]->total + $LineTotal;
				$_SESSION['Items' . $Identifier]->totalVolume = $_SESSION['Items' . $Identifier]->totalVolume + $OrderLine->Quantity * $OrderLine->Volume;
				$_SESSION['Items' . $Identifier]->totalWeight = $_SESSION['Items' . $Identifier]->totalWeight + $OrderLine->Quantity * $OrderLine->Weight;

			} //$_SESSION['Items' . $Identifier]->LineItems as $OrderLine
			/* end of loop around items */

			$DisplayTotal = locale_number_format($_SESSION['Items' . $Identifier]->total, $_SESSION['Items' . $Identifier]->CurrDecimalPlaces);
			if (in_array(1000, $_SESSION['AllowedPageSecurityTokens'])) {
				$ColSpanNumber = 2;
			} //in_array(1000, $_SESSION['AllowedPageSecurityTokens'])
			else {
				$ColSpanNumber = 1;
			}
			echo '<tr class="striped_row">
				<td class="number" colspan="7"><b>', _('TOTAL Excl Tax/Freight'), '</b></td>
				<td colspan="', $ColSpanNumber, '" class="number">', $DisplayTotal, '</td>
			</tr>
		</table>';

			$DisplayVolume = locale_number_format($_SESSION['Items' . $Identifier]->totalVolume, 2);
			$DisplayWeight = locale_number_format($_SESSION['Items' . $Identifier]->totalWeight, 2);
			echo '<table>
				<tr class="striped_row">
					<td>', _('Total Weight'), ':</td>
					<td>', $DisplayWeight, '</td>
					<td>', _('Total Volume'), ':</td>
					<td>', $DisplayVolume, '</td>
				</tr>
			</table>';

			echo '<div class="centre">
				<input type="submit" name="Recalculate" value="', _('Re-Calculate'), '" />
				<input type="submit" name="DeliveryDetails" value="', _('Enter Delivery Details and Confirm Order'), '" />
			</div>';
		} // end of if lines
		/* Now show the stock item selection search stuff below */

		if ((!isset($_POST['QuickEntry']) and !isset($_POST['SelectAsset']))) {
			echo '<input type="hidden" name="PartSearch" value="', _('Yes Please'), '" />';

			if ($_SESSION['FrequentlyOrderedItems'] > 0) { //show the Frequently Order Items selection where configured to do so
				// Select the most recently ordered items for quick select
				$SixMonthsAgo = DateAdd(Date($_SESSION['DefaultDateFormat']), 'm', -6);

				$SQL = "SELECT stockmaster.units,
						stockmaster.description,
						stockmaster.longdescription,
						stockmaster.stockid,
						salesorderdetails.stkcode,
						SUM(qtyinvoiced) salesqty
					FROM `salesorderdetails`INNER JOIN `stockmaster`
					ON  salesorderdetails.stkcode = stockmaster.stockid
					WHERE ActualDispatchDate >= '" . FormatDateForSQL($SixMonthsAgo) . "'
					GROUP BY stkcode
					ORDER BY salesqty DESC
					LIMIT " . $_SESSION['FrequentlyOrderedItems'];

				$Result2 = DB_query($SQL);
				echo '<p class="page_title_text" >
					<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/magnifier.png" title="', _('Search'), '" alt="" />', ' ', _('Frequently Ordered Items'), '
				</p>';

				echo '<div class="page_help_text">', _('Frequently Ordered Items'), _(', shows the most frequently ordered items in the last 6 months.  You can choose from this list, or search further for other items'), '.</div>';

				echo '<table>
					<thead>
						<tr>
							<th class="SortedColumn">', _('Code'), '</th>
							<th class="SortedColumn">', _('Description'), '</th>
							<th>', _('Units'), '</th>
							<th>', _('On Hand'), '</th>
							<th>', _('On Demand'), '</th>
							<th>', _('On Order'), '</th>
							<th>', _('Available'), '</th>
							<th>', _('Quantity'), '</th>
						</tr>
					</thead>';
				$i = 0;

				echo '<tbody>';
				while ($MyRow = DB_fetch_array($Result2)) {
					// This code needs sorting out, but until then :
					$ImageSource = _('No Image');
					// Find the quantity in stock at location
					$QOHSQL = "SELECT SUM(locstock.quantity) AS qoh,
								decimalplaces
							FROM locstock
							INNER JOIN stockmaster
								ON stockmaster.stockid=locstock.stockid
							WHERE locstock.stockid='" . $MyRow['stockid'] . "'
							AND loccode = '" . $_SESSION['Items' . $Identifier]->Location . "'";
					$QOHResult = DB_query($QOHSQL);
					$QOHRow = DB_fetch_array($QOHResult);
					$QOH = $QOHRow['qoh'];

					// Find the quantity on outstanding sales orders
					$SQL = "SELECT SUM(salesorderdetails.quantity-salesorderdetails.qtyinvoiced) AS dem
						FROM salesorderdetails INNER JOIN salesorders
						ON salesorders.orderno = salesorderdetails.orderno
						WHERE salesorders.fromstkloc='" . $_SESSION['Items' . $Identifier]->Location . "'
						AND salesorderdetails.completed=0
						AND salesorders.quotation=0
						AND salesorderdetails.stkcode='" . $MyRow['stockid'] . "'";

					$ErrMsg = _('The demand for this product from') . ' ' . $_SESSION['Items' . $Identifier]->Location . ' ' . _('cannot be retrieved because');
					$DemandResult = DB_query($SQL, $ErrMsg);

					$DemandRow = DB_fetch_row($DemandResult);
					if ($DemandRow[0] != null) {
						$DemandQty = $DemandRow[0];
					} //$DemandRow[0] != null
					else {
						$DemandQty = 0;
					}

					// Get the QOO due to Purchase orders for all locations. Function defined in SQL_CommonFunctions.php
					$PurchQty = GetQuantityOnOrderDueToPurchaseOrders($MyRow['stockid']);
					// Get the QOO dues to Work Orders for all locations. Function defined in SQL_CommonFunctions.php
					$WoQty = GetQuantityOnOrderDueToWorkOrders($MyRow['stockid']);

					$OnOrder = $PurchQty + $WoQty;

					$Available = $QOH - $DemandQty + $OnOrder;

					echo '<tr class="striped_row">
							<td>', $MyRow['stockid'], '</td>
							<td data-title="', $MyRow['longdescription'], '">', $MyRow['description'], '</td>
							<td>', $MyRow['units'], '</td>
							<td class="number">', locale_number_format($QOH, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($DemandQty, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($OnOrder, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($Available, $QOHRow['decimalplaces']), '</td>
							<td><input class="number" type="text" required="required" maxlength="10" size="6" name="OrderQty', $i, '" value="0" />
								<input type="hidden" name="StockID', $i, '" value="', $MyRow['stockid'], '" />
							</td>
						</tr>';
					++$i;
					//end of page full new headings if
					

					
				} //$MyRow = DB_fetch_array($Result2)
				//end of while loop for Frequently Ordered Items
				echo '</tbody>';
				echo '<td style="text-align:center" colspan="8">
					<input type="hidden" name="SelectingOrderItems" value="1" />
					<input type="submit" value="', _('Add to Sales Order'), '" />
				</td>
			</tr>';
				echo '</table>';
			} //end of if Frequently Ordered Items > 0
			echo '<div class="centre">', $Msg, '</div>';

			echo '<p class="page_title_text">
				<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/magnifier.png" title="', _('Search'), '" alt="" />', ' ', _('Search for Order Items'), '
			</p>';

			echo '<div class="page_help_text">', _('Search for Order Items'), _(', Searches the database for items, you can narrow the results by selecting a stock category, or just enter a partial item description or partial item code'), '</div>';

			echo '<fieldset>
				<legend class="search">', _('Search Criteria'), '</legend>
				<field>
					<label for="StockCat">', _('Select a Stock Category'), '</label>
					<select name="StockCat">';

			if (!isset($_POST['StockCat']) or $_POST['StockCat'] == 'All') {
				echo '<option selected="selected" value="All">', _('All'), '</option>';
				$_POST['StockCat'] = 'All';
			} //!isset($_POST['StockCat']) or $_POST['StockCat'] == 'All'
			else {
				echo '<option value="All">', _('All'), '</option>';
			}
			$SQL = "SELECT categoryid,
						categorydescription
				FROM stockcategory
				WHERE stocktype='F' OR stocktype='D' OR stocktype='L'
				ORDER BY categorydescription";

			$Result1 = DB_query($SQL);
			while ($MyRow1 = DB_fetch_array($Result1)) {
				if ($_POST['StockCat'] == $MyRow1['categoryid']) {
					echo '<option selected="selected" value="', $MyRow1['categoryid'], '">', $MyRow1['categorydescription'], '</option>';
				} //$_POST['StockCat'] == $MyRow1['categoryid']
				else {
					echo '<option value="', $MyRow1['categoryid'], '">', $MyRow1['categorydescription'], '</option>';
				}
			} //$MyRow1 = DB_fetch_array($Result1)
			echo '</select>
			<fieldhelp>', _('Select the stock category to search in, or to search over all stock categories select All'), '</fieldhelp>
		</field>';

			echo '<field>
				<label for="Keywords">', _('Enter partial Description'), '</label>';

			if (isset($_POST['Keywords'])) {
				echo '<input type="search" name="Keywords" size="20" maxlength="25" value="', $_POST['Keywords'], '" />';
			} else {
				echo '<input type="search" name="Keywords" size="20" maxlength="25" value="" />';
			}
			echo '<fieldhelp>', _('Enter all or part of the item description you are searching for'), '</fieldhelp>
			</field>';

			echo '<h1>', _('OR'), '</h1>';

			echo '<field>
				<label for="StockCode">', _('Enter extract of the Stock Code'), '</label>';
			if (isset($_POST['StockCode'])) {
				echo '<input type="search" autofocus="autofocus" name="StockCode" size="15" maxlength="18" value="', $_POST['StockCode'], '" />';
			} else {
				echo '<input type="search" autofocus="autofocus" name="StockCode" size="15" maxlength="18" value="" />';
			}
			echo '<fieldhelp>', _('Enter all or part of the item code you are searching for'), '</fieldhelp>
			</field>';

			echo '<field>
				<label for="CustItemFlag">' . _('Customer Item flag') . '</label>
				<input type="checkbox" name="CustItemFlag" value="C" />
				<fieldhelp>', _('If checked, only items for this customer will show'), '</fieldhelp>
			</field>
		</fieldset>';

			echo '<div class="centre">
				<input type="submit" name="Search" value="' . _('Search Now') . '" />
				<input type="submit" name="QuickEntry" value="' . _('Use Quick Entry') . '" />
				<h2>' . _('Or') . '</h2>
				' . _('Upload items from csv file') . '<input type="file" name="CSVFile" />
				<input type="submit" name="UploadFile" value="' . _('Upload File') . '" />
			</div>';
			echo '<div class="page_help_text">' . _('The csv file should have exactly 2 columns, part code and quantity.') . '</div>';

			if (isset($SearchResult)) {
				echo '<div class="page_help_text">', _('Select an item by entering the quantity required.  Click Order when ready.'), '</div>';
				$i = 1;
				echo '<table>
					<thead>
						<tr>
							<td colspan="1">
								<input type="hidden" name="PreviousList" value="', strval($Offset - 1), '" />
								<input type="submit" name="Previous" value="', _('Previous'), '" />
							</td>
							<td style="text-align:center" colspan="7">
								<input type="hidden" name="SelectingOrderItems" value="1" />
								<input type="submit" value="', _('Add to Sales Order'), '" />
							</td>
							<td style="text-align:right" colspan="1">
								<input type="hidden" name="NextList" value="', strval($Offset + 1), '" />
								<input type="submit" name="Next" value="', _('Next'), '" />
							</td>
						</tr>
						<tr>
							<th class="SortedColumn">', _('Code'), '</th>
							<th class="SortedColumn">', _('Description'), '</th>
							<th class="SortedColumn">', _('Customer Item'), '</th>
							<th>', _('Units'), '</th>
							<th>', _('On Hand'), '</th>
							<th>', _('On Demand'), '</th>
							<th>', _('On Order'), '</th>
							<th>', _('Available'), '</th>
							<th>', _('Quantity'), '</th>
						</tr>
					</thead>';
				$ImageSource = _('No Image');

				echo '<tbody>';
				while ($MyRow = DB_fetch_array($SearchResult)) {
					// Find the quantity in stock at location
					$QOHSQL = "SELECT quantity AS qoh,
									stockmaster.decimalplaces
							   FROM locstock INNER JOIN stockmaster
							   ON locstock.stockid = stockmaster.stockid
							   WHERE locstock.stockid='" . $MyRow['stockid'] . "' AND
							   loccode = '" . $_SESSION['Items' . $Identifier]->Location . "'";
					$QOHResult = DB_query($QOHSQL);
					$QOHRow = DB_fetch_array($QOHResult);
					$QOH = $QOHRow['qoh'];

					// Find the quantity on outstanding sales orders
					$SQL = "SELECT SUM(salesorderdetails.quantity-salesorderdetails.qtyinvoiced) AS dem
						FROM salesorderdetails INNER JOIN salesorders
						ON salesorders.orderno = salesorderdetails.orderno
						 WHERE  salesorders.fromstkloc='" . $_SESSION['Items' . $Identifier]->Location . "'
						 AND salesorderdetails.completed=0
						 AND salesorders.quotation=0
						 AND salesorderdetails.stkcode='" . $MyRow['stockid'] . "'";

					$ErrMsg = _('The demand for this product from') . ' ' . $_SESSION['Items' . $Identifier]->Location . ' ' . _('cannot be retrieved because');
					$DemandResult = DB_query($SQL, $ErrMsg);

					$DemandRow = DB_fetch_row($DemandResult);
					if ($DemandRow[0] != null) {
						$DemandQty = $DemandRow[0];
					} //$DemandRow[0] != null
					else {
						$DemandQty = 0;
					}

					// Get the QOO due to Purchase orders for all locations. Function defined in SQL_CommonFunctions.php
					$PurchQty = GetQuantityOnOrderDueToPurchaseOrders($MyRow['stockid']);
					// Get the QOO dues to Work Orders for all locations. Function defined in SQL_CommonFunctions.php
					$WoQty = GetQuantityOnOrderDueToWorkOrders($MyRow['stockid']);

					$OnOrder = $PurchQty + $WoQty;
					$Available = $QOH - $DemandQty + $OnOrder;

					echo '<tr class="striped_row">
							<td>', $MyRow['stockid'], '</td>
							<td data-title="', $MyRow['longdescription'], '">', $MyRow['description'], '</td>
							<td>', $MyRow['cust_part'], '-', $MyRow['cust_description'], '</td>
							<td>', $MyRow['units'], '</td>
							<td class="number">', locale_number_format($QOH, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($DemandQty, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($OnOrder, $QOHRow['decimalplaces']), '</td>
							<td class="number">', locale_number_format($Available, $QOHRow['decimalplaces']), '</td>
							<td><input class="number" type="text" size="6" required="required" maxlength="10" name="OrderQty', $i, '" value="0" />
							<input type="hidden" name="StockID', $i, '" value="', $MyRow['stockid'], '" />
							</td>
						</tr>';
					++$i;
					//end of page full new headings if
					

					
				} //$MyRow = DB_fetch_array($SearchResult)
				//end of while loop
				echo '</tbody>';
				echo '<tfoot>
					<tr>
						<td>
							<input type="hidden" name="PreviousList" value="', strval($Offset - 1), '" />
							<input type="submit" name="Previous" value="', _('Previous'), '" />
						</td>
						<td style="text-align:center" colspan="7">
							<input type="hidden" name="SelectingOrderItems" value="1" />
							<input type="submit" value="', _('Add to Sales Order'), '" />
						</td>
						<td style="text-align:right">
							<input type="hidden" name="NextList" value="', strval($Offset + 1), '" />
							<input type="submit" name="Next" value="', _('Next'), '" />
						</td>
					</tr>
				</tfoot>';
				echo '</table>';

			} //end if SearchResults to show
			

			
		} //(!isset($_POST['QuickEntry']) and !isset($_POST['SelectAsset']))
		/*end of PartSearch options to be displayed */
		elseif (isset($_POST['QuickEntry'])) {
			/* show the quick entry form variable */
			/*FORM VARIABLES TO POST TO THE ORDER  WITH PART CODE AND QUANTITY */
			echo '<div class="page_help_text">', _('Use this screen for the '), _('Quick Entry'), _(' of products to be ordered'), '</div>';

			echo '<table>
				<tr>';
			/*do not display colum unless customer requires po line number by sales order line*/
			if ($_SESSION['Items' . $Identifier]->DefaultPOLine == 1) {
				echo '<th>', _('PO Line'), '</th>';
			} //$_SESSION['Items' . $Identifier]->DefaultPOLine == 1
			echo '<th>', _('Part Code'), '</th>
				<th>', _('Quantity'), '</th>
				<th>', _('Due Date'), '</th>
			</tr>';
			$DefaultDeliveryDate = DateAdd(Date($_SESSION['DefaultDateFormat']), 'd', $_SESSION['Items' . $Identifier]->DeliveryDays);
			for ($i = 1;$i <= $_SESSION['QuickEntries'];$i++) {
				echo '<tr class="striped_row">';
				/* Do not display colum unless customer requires po line number by sales order line*/
				if ($_SESSION['Items' . $Identifier]->DefaultPOLine > 0) {
					echo '<td>
						<input type="text" name="poline_', $i, '" size="21" maxlength="20" />
					</td>';
				} //$_SESSION['Items' . $Identifier]->DefaultPOLine > 0
				echo '<td>
					<input type="text" name="part_', $i, '" size="21" maxlength="20" />
				</td>
				<td>
					<input type="text" name="qty_', $i, '" size="6" maxlength="6" />
				</td>
				<td>
					<input type="text" class="date" name="itemdue_', $i, '" size="25" maxlength="25" value="', $DefaultDeliveryDate, '" />
				</td>
			</tr>';
			} //$i = 1; $i <= $_SESSION['QuickEntries']; $i++
			echo '</table>';

			echo '<div class="centre"><input type="submit" name="QuickEntry" value="', _('Quick Entry'), '" />
				<input type="submit" name="PartSearch" value="', _('Search Parts'), '" />
			</div>';

			echo '</form>';
		} //isset($_POST['QuickEntry'])
		elseif (isset($_POST['SelectAsset'])) {
			echo '<div class="page_help_text">', _('Use this screen to select an asset to dispose of to this customer'), '</div>';

			echo '<table>';
			/*do not display colum unless customer requires po line number by sales order line*/
			if ($_SESSION['Items' . $Identifier]->DefaultPOLine == 1) {
				echo '<tr>
					<td>', _('PO Line'), '</td>
					<td><input type="text" name="poline" size="21" maxlength="20" /></td>
				</tr>';
			} //$_SESSION['Items' . $Identifier]->DefaultPOLine == 1
			echo '<tr>
				<td>', _('Asset to Dispose Of'), ':</td>
				<td><select name="AssetToDisposeOf">';
			$AssetsResult = DB_query("SELECT assetid, description FROM fixedassets WHERE disposaldate='0000-00-00'");
			echo '<option selected="selected" value="NoAssetSelected">', _('Select Asset To Dispose of From the List Below'), '</option>';
			while ($AssetRow = DB_fetch_array($AssetsResult)) {
				echo '<option value="', $AssetRow['assetid'], '">', $AssetRow['assetid'], ' - ', $AssetRow['description'], '</option>';
			} //$AssetRow = DB_fetch_array($AssetsResult)
			echo '</select>
			</td>
		</tr>
	</table>';
			echo '<div class="centre">
				<input type="submit" name="AssetDisposalEntered" value="', _('Add Asset To Order'), '" />
				<input type="submit" name="PartSearch" value="', _('Search Parts'), '" />
			</div>';

			echo '</form>';

		} //end of if it is a Quick Entry screen/part search or asset selection form to display
		if ($_SESSION['Items' . $Identifier]->ItemsOrdered >= 1) {
			echo '<form action="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '?identifier=', urlencode($Identifier), '" method="post" name="deleteform">';
			echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';
			echo '<div class="centre">
				<input type="submit" name="CancelOrder" value="', _('Cancel Whole Order'), '" onclick="return MakeConfirm(\'', _('Are you sure you wish to cancel this entire order?'), '\');" />
			</div>
		</form>';
		} //$_SESSION['Items' . $Identifier]->ItemsOrdered >= 1
		

		
	} //end of else not selecting a customer
	include ('includes/footer.php');

	function GetCustBranchDetails($Identifier) {
		$SQL = "SELECT custbranch.brname,
						custbranch.branchcode,
						custbranch.braddress1,
						custbranch.braddress2,
						custbranch.braddress3,
						custbranch.braddress4,
						custbranch.braddress5,
						custbranch.braddress6,
						custbranch.phoneno,
						custbranch.email,
						custbranch.defaultlocation,
						custbranch.defaultshipvia,
						custbranch.deliverblind,
						custbranch.specialinstructions,
						custbranch.estdeliverydays,
						locations.locationname,
						custbranch.salesman
					FROM custbranch
					INNER JOIN locations
					ON custbranch.defaultlocation=locations.loccode
					WHERE custbranch.branchcode='" . $_SESSION['Items' . $Identifier]->Branch . "'
					AND custbranch.debtorno = '" . $_SESSION['Items' . $Identifier]->DebtorNo . "'";

		$ErrMsg = _('The customer branch record of the customer selected') . ': ' . $_SESSION['Items' . $Identifier]->DebtorNo . ' ' . _('cannot be retrieved because');
		$DbgMsg = _('SQL used to retrieve the branch details was') . ':';
		$Result = DB_query($SQL, $ErrMsg, $DbgMsg);
		return $Result;
	}
?>