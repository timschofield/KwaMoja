<?php

if (!isset($PathPrefix)) {
	$PathPrefix = '';
}

include($PathPrefix . 'config.php');

if (isset($SessionSavePath)) {
	session_save_path($SessionSavePath);
}

ini_set('session.gc_Maxlifetime', $SessionLifeTime);
ini_set('max_execution_time', $MaximumExecutionTime);

session_name('KwaMojaapi');
session_start();

include($PathPrefix . 'includes/LanguageSetup.php');
//  Establish a DB connection, if possible.   NOTE that this connection
//  may not have the same 'value' as any previous connection, so
//  save the new one in the session variable.
if (isset($_SESSION['DatabaseName']) and $_SESSION['DatabaseName'] != '') {
	include($PathPrefix . 'includes/ConnectDB.php');
	$_SESSION['db'] = $db;
}
include($PathPrefix . 'includes/DateFunctions.php');

// Un comment to turn off attempts counter
//$_SESSION['AttemptsCounter'] = 0;

if (!isset($_SESSION['AttemptsCounter'])) {
	$_SESSION['AttemptsCounter'] = 0;
}

if (isset($_SESSION['HTTPS_Only']) and $_SESSION['HTTPS_Only'] == 1) {
	if ($_SERVER['HTTPS'] != 'on') {
		prnMsg(_('KwaMoja is configured to allow only secure socket connections. Pages must be called with https://') . ' .....', 'error');
		exit;
	}
}

// Now check that the user as logged in has access to the page being called. The $PageSecurity
// value must be set in the script before header.php is included. $SecurityGroups is an array of
// arrays defining access for each group of users. These definitions can be modified by a system admin under setup

function CryptPass($Password) {
	if (PHP_VERSION_ID < 50500) {
		$Salt = base64_encode(mcrypt_create_iv(22, MCRYPT_DEV_URANDOM));
		$Salt = str_replace('+', '.', $Salt);
		$Hash = crypt($Password, '$2y$10$' . $Salt . '$');
	} else {
		$Hash = password_hash($Password, PASSWORD_DEFAULT);
	}
	return $Hash;
}

function VerifyPass($Password, $Hash) {
	if(PHP_VERSION_ID < 50500) {
		return (crypt($Password, $Hash) == $Hash);
	} else {
		return password_verify($Password, $Hash);
	}
}

// API wrapper for DB issues - no HTML output, AND remember any error message
function api_DB_query($SQL, $db, $EMsg = '', $DMsg = '', $Transaction = '', $TrapErrors = false) {
	//  Basically we have disabled the error reporting from the standard
	//  query function,  and will remember any error message in the session
	//  data.

	$Result = api_DB_query($SQL, $db, $EMsg, $DMsg, $Transaction, $TrapErrors);
	if (DB_error_no() != 0) {
		$_SESSION['db_err_msg'] = "SQL: " . $SQL . "\nDB error message: " . DB_error_msg($db) . "\n";
	} else {
		$_SESSION['db_err_msg'] = '';
	}

	return $Result;
}
?>