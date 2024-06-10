<?php
require_once 'vendor/autoload.php';

// Set server key Midtrans
\Midtrans\Config::$serverKey = 'SB-Mid-server-8O8xFkI3HZoh6S6TKQ75trso';
\Midtrans\Config::$isProduction = false;
\Midtrans\Config::$isSanitized = true;
\Midtrans\Config::$is3ds = true;

try {
    $notif = new \Midtrans\Notification();

    $transaction = $notif->transaction_status;
    $type = $notif->payment_type;
    $order_id = $notif->order_id;
    $fraud = $notif->fraud_status;

    $conn = new mysqli("localhost", "root", "", "db_ecommerce");

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    if ($transaction == 'capture') {
        if ($type == 'credit_card') {
            if ($fraud == 'challenge') {
                // TODO: Update your database with order status "challenge"
                $sql = "UPDATE payments SET status='challenge' WHERE order_id='$order_id'";
            } else {
                // TODO: Update your database with order status "success"
                $sql = "UPDATE payments SET status='success' WHERE order_id='$order_id'";
            }
        }
    } else if ($transaction == 'settlement') {
        // TODO: Update your database with order status "success"
        $sql = "UPDATE payments SET status='success' WHERE order_id='$order_id'";
    } else if ($transaction == 'pending') {
        // TODO: Update your database with order status "pending"
        $sql = "UPDATE payments SET status='pending' WHERE order_id='$order_id'";
    } else if ($transaction == 'deny') {
        // TODO: Update your database with order status "deny"
        $sql = "UPDATE payments SET status='deny' WHERE order_id='$order_id'";
    } else if ($transaction == 'expire') {
        // TODO: Update your database with order status "expire"
        $sql = "UPDATE payments SET status='expire' WHERE order_id='$order_id'";
    } else if ($transaction == 'cancel') {
        // TODO: Update your database with order status "cancel"
        $sql = "UPDATE payments SET status='cancel' WHERE order_id='$order_id'";
    }

    if ($conn->query($sql) === TRUE) {
        echo "Record updated successfully";
    } else {
        echo "Error updating record: " . $conn->error;
    }

    $conn->close();
} catch (Exception $e) {
    echo "Exception: " . $e->getMessage();
}
?>
