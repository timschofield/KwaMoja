<?php
/* $Id: Z_ImportSuppliers.php 6067 2013-07-10 02:04:22Z tehonu $*/

include('includes/session.php');
$Title = _('Import Items');
include('includes/header.php');

if (isset($_POST['FormID'])) {
	if (!isset($_POST['UpdateIfExists'])) {
		$_POST['UpdateIfExists'] = 0;
	} else {
		$_POST['UpdateIfExists'] = 1;
	}
} else {
	$_POST['UpdateIfExists'] = 0;
}
// If this script is called with a file object, then the file contents are imported
// If this script is called with the gettemplate flag, then a template file is served
// Otherwise, a file upload form is displayed

$FieldHeadings = array(
	'SupplierID', //0
	'SuppName', //1
	'Address1', //2
	'Address2', //3
	'Address3', //4
	'Address4', //5
	'Address5', //6
	'Address6', //7
	'Phone', //8
	'Fax', //9
	'Email', //10
	'SupplierType', //11
	'CurrCode', //12
	'SupplierSince', //13
	'PaymentTerms', //14
	'BankPartics', //15
	'BankRef', //16
	'BankAct', //17
	'Remittance', //18
	'TaxGroup', //19
	'FactorID', //20
	'TaxRef', //21
	'lat', //22
	'lng' //23
);

if (isset($_FILES['userfile']) and $_FILES['userfile']['name']) { //start file processing

	//initialize
	$FieldTarget = count($FieldHeadings);
	$InputError = 0;

	//check file info
	$FileName = $_FILES['userfile']['name'];
	$TempName = $_FILES['userfile']['tmp_name'];
	$FileSize = $_FILES['userfile']['size'];

	//get file handle
	$FileHandle = fopen($TempName, 'r');

	//get the header row
	$headRow = fgetcsv($FileHandle, 10000, ",");

	//check for correct number of fields
	if (count($headRow) != count($FieldHeadings)) {
		prnMsg(_('File contains ' . count($headRow) . ' columns, expected ' . count($FieldHeadings) . '. Try downloading a new template.'), 'error');
		fclose($FileHandle);
		include('includes/footer.php');
		exit;
	}

	//test header row field name and sequence
	$head = 0;
	foreach ($headRow as $headField) {
		if (mb_strtoupper($headField) != mb_strtoupper($FieldHeadings[$head])) {
			prnMsg(_('File contains incorrect headers (' . mb_strtoupper($headField) . ' != ' . mb_strtoupper($header[$head]) . '. Try downloading a new template.'), 'error');
			fclose($FileHandle);
			include('includes/footer.php');
			exit;
		}
		$head++;
	}

	//start database transaction
	DB_Txn_Begin();

	//loop through file rows
	$row = 1;
	$UpdatedNum = 0;
	$InsertNum = 0;
	while (($filerow = fgetcsv($FileHandle, 10000, ",")) !== FALSE) {
		//check for correct number of fields
		$fieldCount = count($filerow);
		if ($fieldCount != $FieldTarget) {
			prnMsg(_($FieldTarget . ' fields required, ' . $fieldCount . ' fields received'), 'error');
			fclose($FileHandle);
			include('includes/footer.php');
			exit;
		}

		// cleanup the data (csv files often import with empty strings and such)
		foreach ($filerow as &$Value) {
			$Value = trim($Value);
		}

		$SupplierID = mb_strtoupper($filerow[0]);
		$_POST['SuppName'] = $filerow[1];
		$_POST['Address1'] = $filerow[2];
		$_POST['Address2'] = $filerow[3];
		$_POST['Address3'] = $filerow[4];
		$_POST['Address4'] = $filerow[5];
		$_POST['Address5'] = $filerow[6];
		$_POST['Address6'] = $filerow[7];
		$_POST['Phone'] = $filerow[8];
		$_POST['Fax'] = $filerow[9];
		$_POST['Email'] = $filerow[10];
		$_POST['SupplierType'] = $filerow[11];
		$_POST['CurrCode'] = $filerow[12];
		$_POST['SupplierSince'] = $filerow[13];
		$_POST['PaymentTerms'] = $filerow[14];
		$_POST['BankPartics'] = $filerow[15];
		$_POST['BankRef'] = $filerow[16];
		$_POST['BankAct'] = $filerow[17];
		$_POST['Remittance'] = $filerow[18];
		$_POST['TaxGroup'] = $filerow[19];
		$_POST['FactorID'] = $filerow[20];
		$_POST['TaxRef'] = $filerow[21];
		$latitude = $filerow[22];
		$longitude = $filerow[23];
		//initialise no input errors assumed initially before we test
		/* actions to take once the user has clicked the submit button
		ie the page has called itself with some user input */

		if (mb_strlen(trim($_POST['SuppName'])) > 40 or mb_strlen(trim($_POST['SuppName'])) == 0 or trim($_POST['SuppName']) == '') {

			$InputError = 1;
			prnMsg(_('The supplier name must be entered and be forty characters or less long'), 'error');
		}
		if (mb_strlen($SupplierID) == 0) {
			$InputError = 1;
			prnMsg(_('The Supplier Code cannot be empty'), 'error');
		}
		if (ContainsIllegalCharacters($SupplierID)) {
			$InputError = 1;
			prnMsg(_('The supplier code cannot contain any of the illegal characters'), 'error');
		}
		if (mb_strlen($_POST['Phone']) > 25) {
			$InputError = 1;
			prnMsg(_('The telephone number must be 25 characters or less long'), 'error');
		}
		if (mb_strlen($_POST['Fax']) > 25) {
			$InputError = 1;
			prnMsg(_('The fax number must be 25 characters or less long'), 'error');
		}
		if (mb_strlen($_POST['Email']) > 55) {
			$InputError = 1;
			prnMsg(_('The email address must be 55 characters or less long'), 'error');
		}
		if (mb_strlen($_POST['Email']) > 0 and !IsEmailAddress($_POST['Email'])) {
			$InputError = 1;
			prnMsg(_('The email address is not correctly formed'), 'error');
		}
		if (mb_strlen($_POST['BankRef']) > 12) {
			$InputError = 1;
			prnMsg(_('The bank reference text must be less than 12 characters long'), 'error');
		}
		if (!is_date($_POST['SupplierSince'])) {
			$InputError = 1;
			prnMsg(_('The supplier since field must be a date in the format') . ' ' . $_SESSION['DefaultDateFormat'], 'error');
		}

		if ($InputError != 1) {

			$SQL_SupplierSince = FormatDateForSQL($_POST['SupplierSince']);

			//first off validate inputs sensible
			$SQL = "SELECT COUNT(supplierid) FROM suppliers WHERE supplierid='" . $SupplierID . "'";
			$Result = DB_query($SQL);
			$MyRow = DB_fetch_row($Result);
			$SuppExists = ($MyRow[0] > 0);
			if ($SuppExists and $_POST['UpdateIfExists'] != 1) {
				$UpdatedNum++;
			} elseif ($SuppExists) {
				$UpdatedNum++;
				$supptranssql = "SELECT supplierno
								FROM supptrans
								WHERE supplierno='" . $SupplierID . "'";
				$suppresult = DB_query($supptranssql);
				$supptrans = DB_num_rows($suppresult);

				$suppcurrssql = "SELECT currcode
								FROM suppliers
								WHERE supplierid='" . $SupplierID . "'";
				$currresult = DB_query($suppcurrssql);
				$suppcurr = DB_fetch_row($currresult);

				$SQL = "UPDATE suppliers SET suppname='" . $_POST['SuppName'] . "',
							address1='" . $_POST['Address1'] . "',
							address2='" . $_POST['Address2'] . "',
							address3='" . $_POST['Address3'] . "',
							address4='" . $_POST['Address4'] . "',
							address5='" . $_POST['Address5'] . "',
							address6='" . $_POST['Address6'] . "',
							telephone='" . $_POST['Phone'] . "',
							fax = '" . $_POST['Fax'] . "',
							email = '" . $_POST['Email'] . "',
							supptype = '" . $_POST['SupplierType'] . "',";
				if ($supptrans == 0)
					$SQL .= "currcode='" . $_POST['CurrCode'] . "',";
				$SQL .= "suppliersince='" . $SQL_SupplierSince . "',
							paymentterms='" . $_POST['PaymentTerms'] . "',
							bankpartics='" . $_POST['BankPartics'] . "',
							bankref='" . $_POST['BankRef'] . "',
							bankact='" . $_POST['BankAct'] . "',
							remittance='" . $_POST['Remittance'] . "',
							taxgroupid='" . $_POST['TaxGroup'] . "',
							factorcompanyid='" . $_POST['FactorID'] . "',
							lat='" . $latitude . "',
							lng='" . $longitude . "',
							taxref='" . $_POST['TaxRef'] . "'
						WHERE supplierid = '" . $SupplierID . "'";

				if ($suppcurr[0] != $_POST['CurrCode']) {
					prnMsg(_('Cannot change currency code as transactions already exist'), 'info');
				}

				$ErrMsg = _('The supplier could not be updated because');
				$DbgMsg = _('The SQL that was used to update the supplier but failed was');
				// echo $SQL;
				$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

			} else { //its a new supplier
				$InsertNum++;
				$SQL = "INSERT INTO suppliers (supplierid,
											suppname,
											address1,
											address2,
											address3,
											address4,
											address5,
											address6,
											telephone,
											fax,
											email,
											supptype,
											currcode,
											suppliersince,
											paymentterms,
											bankpartics,
											bankref,
											bankact,
											remittance,
											taxgroupid,
											factorcompanyid,
											lat,
											lng,
											taxref)
									 VALUES ('" . $SupplierID . "',
										'" . $_POST['SuppName'] . "',
										'" . $_POST['Address1'] . "',
										'" . $_POST['Address2'] . "',
										'" . $_POST['Address3'] . "',
										'" . $_POST['Address4'] . "',
										'" . $_POST['Address5'] . "',
										'" . $_POST['Address6'] . "',
										'" . $_POST['Phone'] . "',
										'" . $_POST['Fax'] . "',
										'" . $_POST['Email'] . "',
										'" . $_POST['SupplierType'] . "',
										'" . $_POST['CurrCode'] . "',
										'" . $SQL_SupplierSince . "',
										'" . $_POST['PaymentTerms'] . "',
										'" . $_POST['BankPartics'] . "',
										'" . $_POST['BankRef'] . "',
										'" . $_POST['BankAct'] . "',
										'" . $_POST['Remittance'] . "',
										'" . $_POST['TaxGroup'] . "',
										'" . $_POST['FactorID'] . "',
										'" . $latitude . "',
										'" . $longitude . "',
										'" . $_POST['TaxRef'] . "')";

				$ErrMsg = _('The supplier') . ' ' . $_POST['SuppName'] . ' ' . _('could not be added because');
				$DbgMsg = _('The SQL that was used to insert the supplier but failed was');

				$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

			}
			if (DB_error_no() == 0) {

			} else { //location insert failed so set some useful error info
				$InputError = 1;
			}
		} else { //item insert failed so set some useful error info
			$InputError = 1;
		}
		if ($InputError == 1) { //this row failed so exit loop
			break;
		}

		$row++;

	}

	if ($InputError == 1) { //exited loop with errors so rollback
		prnMsg(_('Failed on row ' . $row . '. Batch import has been rolled back.'), 'error');
		DB_Txn_Rollback();
	} else { //all good so commit data transaction
		DB_Txn_Commit();
		prnMsg(_('Batch Import of') . ' ' . $FileName . ' ' . _('has been completed. All transactions committed to the database.'), 'success');
		if ($_POST['UpdateIfExists'] == 1) {
			prnMsg(_('Updated') . ': ' . $UpdatedNum . ' ' . _('Insert') . ':' . $InsertNum);
		} else {
			prnMsg(_('Exist') . ': ' . $UpdatedNum . ' ' . _('Insert') . ':' . $InsertNum);
		}

	}

	fclose($FileHandle);

} elseif (isset($_POST['gettemplate']) or isset($_GET['gettemplate'])) { //download an import template

	echo '<br /><br /><br />"' . implode('","', $FieldHeadings) . '"<br /><br /><br />';

} else { //show file upload form

	prnMsg(_('Please ensure that your csv file charset is UTF-8, otherwise the data will not store correctly in database'), 'warn');

	echo '
		<br />
		<a href="Z_ImportSuppliers.php?gettemplate=1">Get Import Template</a>
		<br />
		<br />';
	echo '<form action="Z_ImportSuppliers.php" method="post" enctype="multipart/form-data">';
	echo '<div class="centre">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<input type="hidden" name="MAX_FILE_SIZE" value="1000000" />' . _('Upload file') . ': <input name="userfile" type="file" />
			<input type="submit" value="' . _('Send File') . '" />';

	echo '<br/>', _('Update if SupplierNo exists'), ':<input type="checkbox" name="UpdateIfExists">';
	echo '</div>
		</form>';

}

include('includes/footer.php');
?>