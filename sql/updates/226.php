<?php
NewSysType('100', 'Radiology Tests Batch');

CreateTable('care_radio_test_type', "CREATE TABLE IF NOT EXISTS care_radio_test_type (
  `nr` int(11) NOT NULL auto_increment,
  `type` varchar(50) collate latin1_general_ci NOT NULL,
  `name` varchar(100) collate latin1_general_ci NOT NULL,
  `stockid` varchar(20) collate latin1_general_ci NOT NULL DEFAULT '',
  `history` text collate latin1_general_ci,
  `modify_id` varchar(35) collate latin1_general_ci NOT NULL,
  `modify_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `create_id` varchar(35) collate latin1_general_ci NOT NULL,
  `create_time` timestamp NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`nr`),
  KEY `encounter_nr` (`type`)
)");

InsertRecord('care_radio_test_type', array('nr'), array(1), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(1, '_rx_athrography_', _('Athrography'), 'X001', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(2), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(2, '_rx_barium_enema_', _('Barium Enema'), 'X002', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(3), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(3, '_rx_barium_meal_', _('Barium Meal'), 'X003', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(4), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(4, '_rx_barium_swallow_', _('Barium Swallow'), 'X004', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(5), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(5, '_rx_chest_x_ray_', _('Chest X-Ray'), 'X005', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(6), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(6, '_rx_ct_scan_', _('CT-SCAN'), 'X006', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(7), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(7, '_rx_ct_scan_abdomen_', _('CT-SCAN-Abdomen'), 'X007', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(8), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(8, '_rx_ct_scan_spine_', _('CT-SCAN-Spine'), 'X008', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(9), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(9, '_rx_cystography_', _('Cystography'), 'X009', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(10), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(10, '_rx_lower_extremities_', _('Lower Extremities'), 'X015', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(11), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(11, '_rx_pelvis_hip_joint_', _('Pelvis/Hip joint'), 'X016', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(12), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(12, '_rx_skull_', _('Skull'), 'X017', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(13), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(13, '_rx_upper_extremities_', _('Upper Extremities'), 'X018', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(14), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(14, '_rx_upright_abdomen_', _('Upright Abdomen'), 'X019', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(15), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(15, '_rx_urethrography_', _('Urethrography'), 'X020', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(16), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(16, '_rx_athrography_', _('Utrasound'), 'X021', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(17), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(17, '_rx_utrasound_', _('Vertebral Column'), 'X022', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(18), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(18, '_rx_ecg_', _('ECG'), 'X023', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(19), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(19, '_rx_echo_', _('ECHO'), 'X024', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(20), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(20, '_rx_fistulagraphy_', _('Fistulagraphy'), 'X025', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(21), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(21, '_rx_hsg_', _('HSG'), 'X026', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));
InsertRecord('care_radio_test_type', array('nr'), array(22), array('nr', 'type', 'name', 'stockid', 'history', 'modify_id', 'modify_time', 'create_id', 'create_time'), array(22, '_rx_ivu_', _('IVU'), 'X027', 'Created' . ' - ' . date($_SESSION['DefaultDateFormat']) . ' - ' . $_SESSION['UserID'], $_SESSION['UserID'], date('Y-m-d H:i:s'), $_SESSION['UserID'], date('Y-m-d H:i:s')));

CreateTable('care_test_request_radio', "CREATE TABLE IF NOT EXISTS `care_test_request_radio` (
  `batch_nr` int(11) NOT NULL auto_increment,
  `encounter_nr` int(11) unsigned NOT NULL default '0',
  `dept_nr` smallint(5) unsigned NOT NULL default '0',
  `test_nr` varchar(9) NOT NULL default '0',
  `test_type` varchar(50) NOT NULL,
  `if_patmobile` tinyint(1) NOT NULL default '0',
  `if_allergy` tinyint(1) NOT NULL default '0',
  `if_hyperten` tinyint(1) NOT NULL default '0',
  `if_pregnant` tinyint(1) NOT NULL default '0',
  `clinical_info` text NOT NULL,
  `test_request` text NOT NULL,
  `send_date` date NOT NULL default '0000-00-00',
  `send_doctor` varchar(35) NOT NULL default '0',
  `r_cm_2` varchar(15) NOT NULL default '',
  `mtr` varchar(35) NOT NULL default '',
  `test_date` date NOT NULL default '0000-00-00',
  `test_time` time NOT NULL default '00:00:00',
  `results` text NOT NULL,
  `results_date` date NOT NULL default '0000-00-00',
  `results_doctor` varchar(35) NOT NULL default '',
  `status` varchar(10) NOT NULL default '',
  `history` text NOT NULL,
  `modify_id` varchar(35) NOT NULL default '',
  `modify_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `create_id` varchar(35) NOT NULL default '',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  `process_id` varchar(35) NOT NULL default '',
  `process_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`batch_nr`),
  UNIQUE KEY `batch_nr_2` (`batch_nr`),
  KEY `batch_nr` (`batch_nr`,`encounter_nr`),
  KEY `send_date` (`send_date`)
)");

CreateTable('care_test_findings_radio', "CREATE TABLE IF NOT EXISTS `care_test_findings_radio` (
  `batch_nr` int(11) unsigned NOT NULL default '0',
  `encounter_nr` int(11) unsigned NOT NULL default '0',
  `room_nr` smallint(5) unsigned NOT NULL default '0',
  `dept_nr` smallint(5) unsigned NOT NULL default '0',
  `findings` text NOT NULL,
  `diagnosis` text NOT NULL,
  `doctor_id` varchar(35) NOT NULL default '',
  `findings_date` date NOT NULL default '0000-00-00',
  `findings_time` time NOT NULL default '00:00:00',
  `status` varchar(10) NOT NULL default '',
  `history` text,
  `modify_id` varchar(35) NOT NULL default '',
  `modify_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `create_id` varchar(35) NOT NULL default '',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`batch_nr`,`encounter_nr`),
  KEY `send_date` (`findings_date`),
  KEY `findings_date` (`findings_date`)
)");

NewScript('KCMCMaintainRadiologyTests.php', 10);
NewScript('KCMCRadiologyLaboratory.php', 10);
NewScript('KCMCRequestRadiologyTest.php', 10);
NewScript('KCMCPendingRadiologyTests.php', 10);

NewMenuItem('hospital', 'Reports', _('Radiology Department'), '/KCMCRadiologyLaboratory.php', 7);

NewConfigValue('radiology_cat', '');

UpdateDBNo(basename(__FILE__, '.php'));

?>