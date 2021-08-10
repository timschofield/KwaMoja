<?php
NewScript('KCMCMaintainBacteriologyTests.php', 10);

AddColumn('stockid', 'care_baclabor_test_type', 'varchar(20)', 'NOT NULL', '', 'name');

NewConfigValue('qrcodes_dir', '');
NewConfigValue('barcodes_dir', '');
NewConfigValue('bacteriology_cat', '');

UpdateDBNo(basename(__FILE__, '.php'));

?>