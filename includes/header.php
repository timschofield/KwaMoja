<?php
$ScriptName = basename($_SERVER['SCRIPT_NAME']);

echo '<div class="title_bar">', $Title, ' - ', stripslashes($_SESSION['CompanyRecord']['coyname']), '
		<div id="exit" class="close_button" onclick="CloseModal()" title="', _('Close this window'), '">X</div>';
if (isset($BookMark) and $BookMark != '') {
	echo '<div id="exit" class="close_button" onclick="ShowHelp(\'', $ViewTopic, '\',\'', $BookMark, '\')" title="', _('Help for this function'), '">?</div>';
	}
	echo '</div>';

	echo '<section id="ModalBody" class="ModalBody">';
	echo '<div class="help-bubble" id="help-bubble">
		<div class="help-header" id="help-header">
			<div id="help_exit" class="close_button" onclick="CloseHelp()" title="', _('Close this window'), '">X</div>
		</div>
		<div class="help-content" id="help-content"></div>
	</div>';
	echo '<div id="mask">
		<div id="dialog"></div>
	</div>';

	if (isset($Messages) and count($Messages) > 0) {
		foreach ($Messages as $Message) {
			$Prefix = '';
			switch ($Message[1]) {
				case 'error':
					$Class = 'error';
					$Prefix = $Prefix ? $Prefix : _('ERROR') . ' ' . _('Report');
					if (isset($_SESSION['LogSeverity']) and $_SESSION['LogSeverity'] > 3) {
						fwrite($LogFile, date('Y-m-d h-m-s') . ',' . $Type . ',' . $_SESSION['UserID'] . ',' . trim($Msg, ',') . "\n");
					}
					echo '<div name="error" class="' . $Class . ' noPrint"><b>' . $Prefix . '</b> : ' . $Message[0] . '</div>';
				break;
				case 'warn':
					$Class = 'warn';
					$Prefix = $Prefix ? $Prefix : _('WARNING') . ' ' . _('Report');
					if (isset($_SESSION['LogSeverity']) and $_SESSION['LogSeverity'] > 3) {
						fwrite($LogFile, date('Y-m-d h-m-s') . ',' . $Type . ',' . $_SESSION['UserID'] . ',' . trim($Msg, ',') . "\n");
					}
					echo '<br /><div name="warn" style="display:none;"><b>' . $Prefix . '</b> : ' . $Message[0] . '</div>';
				break;
				case 'success':
					$Class = 'success';
					$Prefix = $Prefix ? $Prefix : _('SUCCESS') . ' ' . _('Report');
					if (isset($_SESSION['LogSeverity']) and $_SESSION['LogSeverity'] > 3) {
						fwrite($LogFile, date('Y-m-d h-m-s') . ',' . $Type . ',' . $_SESSION['UserID'] . ',' . trim($Msg, ',') . "\n");
					}
					echo '<div name="success"><b>' . $Prefix . '</b> : ' . $Message[0] . '</div>';
				break;
				case 'info':
				default:
					$Prefix = $Prefix ? $Prefix : _('INFORMATION') . ' ' . _('Message');
					$Class = 'info';
					if (isset($_SESSION['LogSeverity']) and $_SESSION['LogSeverity'] > 2) {
						fwrite($LogFile, date('Y-m-d h-m-s') . ',' . $Type . ',' . $_SESSION['UserID'] . ',' . trim($Msg, ',') . "\n");
					}
					echo '<div name="info" style="display:none;"><b>' . $Prefix . '</b> : ' . $Message[0] . '</div>';
			}
		}
	}

	echo '</body>';
	echo '</html>';

?>