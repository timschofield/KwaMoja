<?php
/* This is where the delivery details are confirmed/entered/modified and
 * the order committed to the database once the place order/modify order
 * button is hit.
*/

include ('includes/DefineCartClass.php');

/* Session started in header.php for password checking the session will
 * contain the details of the order from the Cart class object. The details
 * of the order come from SelectOrderItems.php
*/

include ('includes/session.php');
$Title = _('Order Delivery Details');
$ViewTopic = 'SalesOrders'; // Filename's id in ManualContents.php's TOC.
$BookMark = 'DeliveryDetails'; // Anchor's id in the manual's html document.
include ('includes/header.php');
include ('includes/FreightCalculation.php');
include ('includes/SQL_CommonFunctions.php');
include ('includes/CountriesArray.php');

if (isset($_GET['identifier'])) {
	$Identifier = $_GET['identifier'];
	} //isset($_GET['identifier'])
	unset($_SESSION['WarnOnce']);
	if (!isset($_SESSION['Items' . $Identifier]) or !isset($_SESSION['Items' . $Identifier]->DebtorNo)) {
		prnMsg(_('This page can only be read if an order has been entered') . '. ' . _('To enter an order select customer transactions then sales order entry'), 'error');
		include ('includes/footer.php');
		exit;
	} //!isset($_SESSION['Items' . $Identifier]) or !isset($_SESSION['Items' . $Identifier]->DebtorNo)
	if ($_SESSION['Items' . $Identifier]->ItemsOrdered == 0) {
		prnMsg(_('This page can only be read if an there are items on the order') . '. ' . _('To enter an order select customer transactions then sales order entry'), 'error');
		include ('includes/footer.php');
		exit;
	} //$_SESSION['Items' . $Identifier]->ItemsOrdered == 0
	/*Calculate the earliest dispacth date in DateFunctions.php */

	$EarliestDispatch = CalcEarliestDispatchDate();
	include ('includes/footer.php');
?>