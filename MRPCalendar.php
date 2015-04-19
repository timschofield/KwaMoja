<?php

/* MRPCalendar.php
 * Maintains the calendar of valid manufacturing dates for MRP
 */

include('includes/session.inc');
$Title = _('MRP Calendar');
include('includes/header.inc');


if (isset($_POST['ChangeDate'])) {
	$ChangeDate = trim(mb_strtoupper($_POST['ChangeDate']));
} elseif (isset($_GET['ChangeDate'])) {
	$ChangeDate = trim(mb_strtoupper($_GET['ChangeDate']));
}

echo '<p class="page_title_text" >
		<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/inventory.png" title="' . _('Inventory') . '" alt="" />' . ' ' . $Title . '
	</p>';

if (isset($_POST['submit'])) {
	submit($ChangeDate);
} elseif (isset($_POST['update'])) {
	update($ChangeDate);
} elseif (isset($_POST['ListAll'])) {
	ShowDays();
} else {
	ShowInputForm($ChangeDate);
}

function submit(&$ChangeDate) {

	//initialize no input errors
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible

	if (!is_date($_POST['FromDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid From Date'), 'error');
	}

	if (!is_date($_POST['ToDate'])) {
		$InputError = 1;
		prnMsg(_('Invalid To Date'), 'error');

	}

	// Use FormatDateForSQL to put the entered dates into right format for sql
	// Use ConvertSQLDate to put sql formatted dates into right format for functions such as
	// DateDiff and DateAdd
	$FormatFromDate = FormatDateForSQL($_POST['FromDate']);
	$FormatToDate = FormatDateForSQL($_POST['ToDate']);
	$ConvertFromDate = ConvertSQLDate($FormatFromDate);
	$ConvertToDate = ConvertSQLDate($FormatToDate);

	$DateGreater = Date1GreaterThanDate2($_POST['ToDate'], $_POST['FromDate']);
	$DateDiff = DateDiff($ConvertToDate, $ConvertFromDate, 'd'); // Date1 minus Date2

	if ($DateDiff < 1) {
		$InputError = 1;
		prnMsg(_('To Date Must Be Greater Than From Date'), 'error');
	}

	if ($InputError == 1) {
		ShowInputForm($ChangeDate);
		return;
	}

	$SQL = "DROP TABLE IF EXISTS mrpcalendar";
	$Result = DB_query($SQL);

	$SQL = "CREATE TABLE mrpcalendar (
				calendardate date NOT NULL,
				daynumber int(6) NOT NULL,
				manufacturingflag smallint(6) NOT NULL default '1',
				INDEX (daynumber),
				PRIMARY KEY (calendardate)) DEFAULT CHARSET=utf8";
	$ErrMsg = _('The SQL to create passbom failed with the message');
	$Result = DB_query($SQL, $ErrMsg);

	$i = 0;

	/* $DaysTextArray used so can get text of day based on the value get from DayOfWeekFromSQLDate of
	the calendar date. See if that text is in the ExcludeDays array note no gettext here hard coded english days from $_POST*/
	$DaysTextArray = array(
		'Sunday',
		'Monday',
		'Tuesday',
		'Wednesday',
		'Thursday',
		'Friday',
		'Saturday'
	);

	$ExcludeDays = array(
		$_POST['Sunday'],
		$_POST['Monday'],
		$_POST['Tuesday'],
		$_POST['Wednesday'],
		$_POST['Thursday'],
		$_POST['Friday'],
		$_POST['Saturday']
	);

	$CalDate = $ConvertFromDate;
	for ($i = 0; $i <= $DateDiff; $i++) {
		$DateAdd = FormatDateForSQL(DateAdd($CalDate, 'd', $i));

		// If the check box for the calendar date's day of week was clicked, set the manufacturing flag to 0
		$DayOfWeek = DayOfWeekFromSQLDate($DateAdd);
		$ManuFlag = 1;
		foreach ($ExcludeDays as $exday) {
			if ($exday == $DaysTextArray[$DayOfWeek]) {
				$ManuFlag = 0;
			}
		}

		$SQL = "INSERT INTO mrpcalendar (
					calendardate,
					daynumber,
					manufacturingflag)
				 VALUES ('" . $DateAdd . "',
						'1',
						'" . $ManuFlag . "')";
		$Result = DB_query($SQL, $ErrMsg);
	}

	// Update daynumber. Set it so non-manufacturing days will have the same daynumber as a valid
	// manufacturing day that precedes it. That way can read the table by the non-manufacturing day,
	// subtract the leadtime from the daynumber, and find the valid manufacturing day with that daynumber.
	$DayNumber = 1;
	$SQL = "SELECT * FROM mrpcalendar
			ORDER BY calendardate";
	$Result = DB_query($SQL, $ErrMsg);
	while ($MyRow = DB_fetch_array($Result)) {
		if ($MyRow['manufacturingflag'] == "1") {
			$DayNumber++;
		}
		$CalDate = $MyRow['calendardate'];
		$SQL = "UPDATE mrpcalendar SET daynumber = '" . $DayNumber . "'
					WHERE calendardate = '" . $CalDate . "'";
		$Resultupdate = DB_query($SQL, $ErrMsg);
	}
	prnMsg(_('The MRP Calendar has been created'), 'success');
	ShowInputForm($ChangeDate);

} // End of function submit()


function update(&$ChangeDate) {
	// Change manufacturing flag for a date. The value "1" means the date is a manufacturing date.
	// After change the flag, re-calculate the daynumber for all dates.

	$InputError = 0;
	$CalDate = FormatDateForSQL($ChangeDate);
	$SQL = "SELECT COUNT(*) FROM mrpcalendar
		  WHERE calendardate='$CalDate'
		  GROUP BY calendardate";
	$Result = DB_query($SQL);
	$MyRow = DB_fetch_row($Result);
	if ($MyRow[0] < 1 or !is_date($ChangeDate)) {
		$InputError = 1;
		prnMsg(_('Invalid Change Date'), 'error');
	}

	if ($InputError == 1) {
		ShowInputForm($ChangeDate);
		return;
	}

	$SQL = "SELECT mrpcalendar.* FROM mrpcalendar WHERE calendardate='$CalDate'";
	$Result = DB_query($SQL);
	$MyRow = DB_fetch_row($Result);
	$newmanufacturingflag = 0;
	if ($MyRow[2] == 0) {
		$newmanufacturingflag = 1;
	}
	$SQL = "UPDATE mrpcalendar SET manufacturingflag = '" . $newmanufacturingflag . "'
			WHERE calendardate = '" . $CalDate . "'";
	$ErrMsg = _('Cannot update the MRP Calendar');
	$Resultupdate = DB_query($SQL, $ErrMsg);
	prnMsg(_('The MRP calendar record for') . ' ' . $ChangeDate . ' ' . _('has been updated'), 'success');
	unset($ChangeDate);
	ShowInputForm($ChangeDate);

	// Have to update daynumber any time change a date from or to a manufacturing date
	// Update daynumber. Set it so non-manufacturing days will have the same daynumber as a valid
	// manufacturing day that precedes it. That way can read the table by the non-manufacturing day,
	// subtract the leadtime from the daynumber, and find the valid manufacturing day with that daynumber.
	$DayNumber = 1;
	$SQL = "SELECT * FROM mrpcalendar ORDER BY calendardate";
	$Result = DB_query($SQL, $ErrMsg);
	while ($MyRow = DB_fetch_array($Result)) {
		if ($MyRow['manufacturingflag'] == '1') {
			$DayNumber++;
		}
		$CalDate = $MyRow['calendardate'];
		$SQL = "UPDATE mrpcalendar SET daynumber = '" . $DayNumber . "'
					WHERE calendardate = '" . $CalDate . "'";
		$Resultupdate = DB_query($SQL, $ErrMsg);
	} // End of while

} // End of function update()


function ShowDays() { //####LISTALL_LISTALL_LISTALL_LISTALL_LISTALL_LISTALL_LISTALL_####

	// List all records in date range
	$FromDate = FormatDateForSQL($_POST['FromDate']);
	$ToDate = FormatDateForSQL($_POST['ToDate']);
	$SQL = "SELECT calendardate,
				   daynumber,
				   manufacturingflag,
				   DAYNAME(calendardate) as dayname
			FROM mrpcalendar
			WHERE calendardate >='" . $FromDate . "'
			AND calendardate <='" . $ToDate . "'";

	$ErrMsg = _('The SQL to find the parts selected failed with the message');
	$Result = DB_query($SQL, $ErrMsg);

	echo '<br />
		<table class="selection">
		<tr>
			<th>' . _('Date') . '</th>
			<th>' . _('Manufacturing Date') . '</th>
		</tr>';
	$ctr = 0;
	while ($MyRow = DB_fetch_array($Result)) {
		$flag = _('Yes');
		if ($MyRow['manufacturingflag'] == 0) {
			$flag = _('No');
		}
		printf('<tr>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
				</tr>', ConvertSQLDate($MyRow[0]), _($MyRow[3]), $flag);
	} //END WHILE LIST LOOP

	echo '</table>';
	echo '<br /><br />';
	unset($ChangeDate);
	ShowInputForm($ChangeDate);

} // End of function ShowDays()


function ShowInputForm(&$ChangeDate) { //####DISPLAY_DISPLAY_DISPLAY_DISPLAY_DISPLAY_DISPLAY_#####

	// Display form fields. This function is called the first time
	// the page is called, and is also invoked at the end of all of the other functions.

	if (!isset($_POST['FromDate'])) {
		$_POST['FromDate'] = date($_SESSION['DefaultDateFormat']);
		$_POST['ToDate'] = date($_SESSION['DefaultDateFormat']);
	}
	echo '<form action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post">
		  <div>
			<br />
			<br />';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<br /><table class="selection">';

	echo '<tr>
			<td>' . _('From Date') . ':</td>
			<td><input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="FromDate" size="10" required="required" maxlength="10" value="' . $_POST['FromDate'] . '" /></td></tr>
			<tr><td>' . _('To Date') . ':</td>
			<td><input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="ToDate" size="10" required="required" maxlength="10" value="' . $_POST['ToDate'] . '" /></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td>' . _('Exclude The Following Days') . '</td>
		</tr>
		<tr>
			<td>' . _('Saturday') . ':</td>
			<td><input type="checkbox" name="Saturday" value="Saturday" /></td>
		</tr>
		<tr>
			<td>' . _('Sunday') . ':</td>
			<td><input type="checkbox" name="Sunday" value="Sunday" /></td>
		</tr>
		<tr>
			<td>' . _('Monday') . ':</td>
			<td><input type="checkbox" name="Monday" value="Monday" /></td>
		</tr>
		<tr>
			<td>' . _('Tuesday') . ':</td>
			<td><input type="checkbox" name="Tuesday" value="Tuesday" /></td>
		</tr>
		<tr>
			<td>' . _('Wednesday') . ':</td>
			<td><input type="checkbox" name="Wednesday" value="Wednesday" /></td>
		</tr>
		<tr>
			<td>' . _('Thursday') . ':</td>
			<td><input type="checkbox" name="Thursday" value="Thursday" /></td>
		</tr>
		<tr>
			<td>' . _('Friday') . ':</td>
			<td><input type="checkbox" name="Friday" value="Friday" /></td>
		</tr>
		</table><br />
		<div class="centre">
			<input type="submit" name="submit" value="' . _('Create Calendar') . '" />
			<input type="submit" name="ListAll" value="' . _('List Date Range') . '" />
		</div>';

	if (!isset($_POST['ChangeDate'])) {
		$_POST['ChangeDate'] = date($_SESSION['DefaultDateFormat']);
	}

	echo '<br />
		<table class="selection">
		<tr>
			<td>' . _('Change Date Status') . ':</td>
			<td><input type="text" name="ChangeDate" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" size="10" maxlength="10" value="' . $_POST['ChangeDate'] . '" /></td>
			<td><input type="submit" name="update" value="' . _('Update') . '" /></td>
		</tr>
		</table>
		<br />
		<br />
		</div>
		</form>';

} // End of function ShowInputForm()

include('includes/footer.inc');
?>