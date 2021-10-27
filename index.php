<?php
$PageSecurity = 0;
include ('includes/session.php');
$Title = _('KwaMoja ERP');
$ViewTopic = 'Dashboard';
$BookMark = 'MainScreen';
if (!isset($RootPath)) {
	$RootPath = dirname(htmlspecialchars(basename(__FILE__)));
	if ($RootPath == '/' or $RootPath == "\\") {
		$RootPath = '';
	}
	}

	$ViewTopic = isset($ViewTopic) ? '?ViewTopic=' . $ViewTopic : '';
	$BookMark = isset($BookMark) ? '#' . $BookMark : '';

	if (isset($_GET['Theme'])) {
		$_SESSION['Theme'] = $_GET['Theme'];
		$SQL = "UPDATE www_users SET theme='" . $_GET['Theme'] . "' WHERE userid='" . $_SESSION['UserID'] . "'";
		$Result = DB_query($SQL);
	}

	if ($LanguagesArray[$_SESSION['Language']]['Direction'] == 'rtl' and mb_substr($_SESSION['Theme'], -4) != '-rtl') {
		$_SESSION['Theme'] = $_SESSION['Theme'] . '-rtl';
	}

	if (isset($Title) and $Title == _('Copy a BOM to New Item Code')) { //solve the cannot modify heaer information in CopyBOM.php scritps
		ob_start();
	}

	echo '<!DOCTYPE html>';

	echo '<html>
		<head>
			<meta http-equiv="Content-Type" content="application/html; charset=utf-8; cache-control: no-cache, no-store, must-revalidate; Pragma: no-cache" />
			<title>', _('KwaMoja'), ' - ', $Title, '</title>
			<link rel="icon" href="', $PathPrefix, $RootPath, '/favicon.ico?v=2" />
			<link href="', $PathPrefix, $RootPath, '/css/', $_SESSION['Theme'], '/styles.css?v=30" rel="stylesheet" type="text/css" media="screen" />
			<link href="', $PathPrefix, $RootPath, '/css/print.css" rel="stylesheet" type="text/css" media="print" />
			<meta name="viewport" content="width=device-width, initial-scale=1">';
	echo '<script async type="text/javascript" src = "', $PathPrefix, $RootPath, '/javascripts/MiscFunctions.js"></script>';
	echo '<script async type="text/javascript" src = "', $PathPrefix, $RootPath, '/javascripts/Modal.js"></script>';
	echo '<script>
		localStorage.setItem("DateFormat", "', $_SESSION['DefaultDateFormat'], '");
		localStorage.setItem("Theme", "', $_SESSION['Theme'], '");
	</script>';

	if ($_SESSION['ShowPageHelp'] == 0) {
		echo '<link href="', $PathPrefix, $RootPath, '/css/', $_SESSION['Theme'], '/page_help_off.css" rel="stylesheet" type="text/css" media="screen" />';
	} else {
		echo '<link href="', $PathPrefix, $RootPath, '/css/', $_SESSION['Theme'], '/page_help_on.css" rel="stylesheet" type="text/css" media="screen" />';
	}

	if ($_SESSION['ShowFieldHelp'] == 0) {
		echo '<link href="', $PathPrefix, $RootPath, '/css/', $_SESSION['Theme'], '/field_help_off.css" rel="stylesheet" type="text/css" media="screen" />';
	} else {
		echo '<link href="', $PathPrefix, $RootPath, '/css/', $_SESSION['Theme'], '/field_help_on.css" rel="stylesheet" type="text/css" media="screen" />';
	}

	if ($Debug === 0) {
		echo '</head>';
		if (isset($AutoPrintPage)) {
			echo '<body onload="window.print()" id="body">';
		} else {
			echo '<body onload="initial(); load()" onunload="GUnload()" id="body">';
		}
	} else {
		echo '<link href="', $PathPrefix, $RootPath, '/css/holmes.css" rel="stylesheet" type="text/css" />';
		echo '</head>';
		echo '<body class="holmes-debug" onload="initial()">';
	}

	if (isset($_GET['FontSize'])) {
		$SQL = "UPDATE www_users
				SET fontsize='" . $_GET['FontSize'] . "'
				WHERE userid = '" . $_SESSION['UserID'] . "'";
		$Result = DB_query($SQL);
		switch ($_GET['FontSize']) {
			case 0:
				$_SESSION['ScreenFontSize'] = '0.667rem';
			break;
			case 1:
				$_SESSION['ScreenFontSize'] = '0.833rem';
			break;
			case 2:
				$_SESSION['ScreenFontSize'] = '1rem';
			break;
			default:
				$_SESSION['ScreenFontSize'] = '0.833rem';
		}
	}
	echo '<style>
			body {
					font-size: ', $_SESSION['ScreenFontSize'], ';
				}
			</style>';

	$ScriptName = basename($_SERVER['SCRIPT_NAME']);
	echo '<div class="ShowModal" id="modal"></div>';

	$DashBoardURL = 'index.php';

	echo '<link href="', $RootPath, '/dashboard/css/dashboard.css?v=1" rel="stylesheet" type="text/css" media="screen" />';

	$SQL = "SELECT scripts FROM dashboard_users WHERE userid = '" . $_SESSION['UserID'] . "' ";

	$Result = DB_query($SQL);

	$MyRow = DB_fetch_array($Result);
	$ScriptArray = explode(',', $MyRow['scripts']);

	$UserSQL = "SELECT scripts FROM dashboard_users WHERE userid = '" . $_SESSION['UserID'] . "' ";
	$Result = DB_query($UserSQL);
	if (DB_num_rows($Result) == 0) {
		$InsertSQL = "INSERT INTO dashboard_users VALUES(null, '" . $_SESSION['UserID'] . "', '')";
		$InsertResult = DB_query($InsertSQL);
	}

	if (isset($_GET['Remove'])) {
		foreach ($ScriptArray as $Key => $Value) {
			if ($Value == $_GET['Remove']) {
				unset($ScriptArray[$Key]);
			}
		}
		$UpdateSQL = "UPDATE dashboard_users SET scripts='" . implode(',', $ScriptArray) . "' WHERE userid = '" . $_SESSION['UserID'] . "'";
		$UpdateResult = DB_query($UpdateSQL);
	}

	if (isset($_GET['Reports']) and count($ScriptArray) < 7) {
		$ScriptArray[] = $_GET['Reports'];
		asort($ScriptArray);
		$UpdateSQL = "UPDATE dashboard_users SET scripts='" . implode(',', $ScriptArray) . "' WHERE userid = '" . $_SESSION['UserID'] . "' ";
		$UpdateResult = DB_query($UpdateSQL);
	} else if (isset($_POST['Reports']) and count($ScriptArray) == 7) {
		prnMsg(_('A maximum of 6 reports is allowd on each users dashboard'), 'warn');
	}

	if (!isset($_SESSION['MenuItems'])) {
		include ('includes/MainMenuLinksArray.php');
	}

	echo '<div class="title_bar">', $Title, ' - ', stripslashes($_SESSION['CompanyRecord']['coyname']), '
		<span class="ThemeChanger"><label for="Theme" class="ScriptTitle">', _('Theme'), ':</label>';

	echo '<select name="Theme" class="Themes" id="favourites" onchange="window.open (\'index.php?Theme=\' + this.value,\'_self\',false)">';

	$Themes = glob('css/*', GLOB_ONLYDIR);
	foreach ($Themes as $ThemeName) {
		$ThemeName = basename($ThemeName);
		if ($ThemeName != 'mobile' and mb_substr($ThemeName, -4) != '-rtl') {
			if ($_SESSION['Theme'] == $ThemeName) {
				echo '<option selected="selected" value="', $ThemeName, '">', ucfirst($ThemeName), '</option>';
			} else {
				echo '<option value="', $ThemeName, '">', ucfirst($ThemeName), '</option>';
			}
		}
	}
	echo '</select></span>
			<a id="exit" class="close_button" title="', _('Logout'), '" href="', $PathPrefix, $RootPath, '/Logout.php" onclick="return MakeConfirm(\'', _('Are you sure you wish to logout?'), '\', \'', _('Confirm Logout'), '\', this);">
			X
		</a>
	</div>';

	echo '<div id="menuiconcontainer" class="menuiconcontainer" title="Show Menu" onclick="ShowModules()">
		<div class="bar1"></div>
		<div class="bar2"></div>
		<div class="bar3"></div>
	</div>';
	echo '<div id="mask">';
	//=== MainMenuDiv =======================================================================
	

	echo '<nav class="ModuleList" id="ModuleList">
		<ul class="ListHolder">'; //===HJ===
	echo '<div class="CloseModuleList" onclick="ShowModules()">X</div>';

	echo '<div id="TopLogo" class="TopLogo">KwaMoja</div>';
	$i = 0;
	while ($i < count($_SESSION['ModuleLink'])) {
		// This determines if the user has display access to the module see config.php and header_main.php
		// for the authorisation and security code
		if ($_SESSION['ModulesEnabled'][$i] == 1) {
			// If this is the first time the application is loaded then it is possible that
			// SESSION['Module'] is not set if so set it to the first module that is enabled for the user
			if (!isset($_SESSION['Module']) or $_SESSION['Module'] == '') {
				$_SESSION['Module'] = $_SESSION['ModuleLink'][$i];
			}
			echo '<li class="Module" onclick="ShowModal(\'Menu.php?Application=', urlencode($_SESSION['ModuleLink'][$i]), '\')">
					<a id="MainMenu">', $_SESSION['ModuleList'][$i], '</a>
				</li>';
		}
		++$i;
	}
	echo '</ul>
	</nav>'; // MainMenuDiv ===HJ===
	echo '</div>';
	$SQL = "SELECT id,
				scripts,
				pagesecurity,
				description
			FROM dashboard_scripts";
	$Result = DB_query($SQL);

	$i = 0;
	echo '<table>
		<tr>';
	while ($MyRow = DB_fetch_array($Result)) {
		if (in_array($MyRow['id'], $ScriptArray) and in_array($MyRow['pagesecurity'], $_SESSION['AllowedPageSecurityTokens'])) {
			echo '<td class="dashboard_cell" name="', $MyRow['scripts'], '" id="dashboard_cell', $i, '" title="', $MyRow['description'], '" onload="">';
			include ('dashboard/' . $MyRow['scripts']);
			echo '</td>';
			if ($i == 2) {
				echo '</tr><tr>';
			}
			++$i;
		}
	}
	echo '</tr>
	</table>';
	DB_data_seek($Result, 0);

	//echo '<form action="', htmlspecialchars(basename(__FILE__), ENT_QUOTES, 'UTF-8'), '" method="post">';
	//echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';
	

	echo '<fieldset style="margin:auto;width:33%">
		<field>
			<label for="Reports">', _('Add reports to your dashboard'), '</label>
			<select name="Reports" onchange="GetContent(\'body\', \'index.php?Reports=\'+this.value)">
			<option value=""></option>';
	while ($MyRow = DB_fetch_array($Result)) {
		if (!in_array($MyRow['id'], $ScriptArray) and in_array($MyRow['pagesecurity'], $_SESSION['AllowedPageSecurityTokens'])) {
			echo '<option value="', $MyRow['id'], '">', $MyRow['description'], '</option>';
		}
	}
	echo '</select>
	</field>
</fieldset>';

	//echo '<input type="submit" name="submit" value="" style="display:none;" />';
	

	//echo '</form>';
	

	echo '<script async type="text/javascript" src = "', $RootPath, '/dashboard/javascript/dashboard.js"></script>';
?>