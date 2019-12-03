<?php
$ScriptTitle = _('MRP dashboard');

$SQL = "SELECT DISTINCT id FROM dashboard_scripts WHERE scripts='" . basename(basename(__FILE__)) . "'";
$DashboardResult = DB_query($SQL);
$DashboardRow = DB_fetch_array($DashboardResult);

echo '<div class="container">
		<table class="DashboardTable">
			<tr>
				<th colspan="4">
					<div class="CanvasTitle">', $ScriptTitle, '
						<a class="CloseButton" href="', $DashBoardURL, '?Remove=', urlencode($DashboardRow['id']), '" target="_parent" id="CloseButton">X</a>
					</div>
				</th>
			</tr>';

$SQL = "SELECT stockmaster.stockid,
				stockmaster.description,
				stockmaster.mbflag,
				SUM(locstock.quantity) AS qoh,
				stockmaster.units,
				stockmaster.decimalplaces
			FROM stockmaster,
				locstock
			WHERE stockmaster.stockid=locstock.stockid
			GROUP BY stockmaster.stockid,
					stockmaster.description,
					stockmaster.units,
					stockmaster.mbflag,
					stockmaster.decimalplaces
			ORDER BY stockmaster.stockid LIMIT 5";

$searchresult = DB_query($SQL);
echo '<tbody>
		<tr>
			<th>', _('Code'), '</th>
			<th>', _('Description'), '</th>
			<th>', _('Total QTY on Hand'), '</th>
			<th>', _('Units'), '</th>
		</tr>';
$k = 0;
while ($row = DB_fetch_array($searchresult)) {
	$StockId = $row['stockid'];
	$qoh = locale_number_format($row['qoh'], $row['decimalplaces']);

	echo '<tr class="striped_row">
			<td><a href="', $RootPath, '/StockStatus.php?StockID=', urlencode($StockId), '" target="_blank">', $row['stockid'], '</td>
			<td>', $row['description'], '</td>
			<td class="number">', $qoh, '</td>
			<td>', $row['units'], '</td>
		</tr>';

}

echo '</tbody>
	</table>';

?>