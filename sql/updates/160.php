<?php

ChangeColumnType('tagref', $'tags', 'INT(11)', 'NOT Null', '');

CreateTable('gltags',
"CREATE TABLE `gltags` (
  `counterindex` INT(11) NOT NULL DEFAULT '0',
  `tagref` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counterindex`, `tagref`),
  FOREIGN KEY (counterindex) REFERENCES gltrans(counterindex),
  FOREIGN KEY (tagref) REFERENCES tags(tagref)
)");


executeSQL("INSERT INTO gltags (SELECT counterindex, tag  FROM gltrans)");

DropColumn('tag', 'gltrans');

UpdateDBNo(basename(__FILE__, '.php'));

?>