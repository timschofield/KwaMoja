<?php
echo '</section>';

echo '<div class="footer_bar">
		KwaMoja ', _('version'), ' ', $_SESSION['VersionNumber'], '.', $_SESSION['DBUpdateNumber'], '
		<div class="footer_date">', _(date('l jS \of F Y h:i:s A')), '</div>
	</div>';
/*
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
				echo '<div name="success" style="display:none;"><b>' . $Prefix . '</b> : ' . $Message[0] . '</div>';
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
*/
echo '</body>';
echo '</html>';

?>