<?
// Include Midtrans PHP SDK
require_once(dirname(__FILE__) . '/midtrans-php-master/Midtrans.php');
include 'koneksi.php';

// Set your Merchant Server Key
\Midtrans\Config::$serverKey = 'SB-Mid-server-8O8xFkI3HZoh6S6TKQ75trso'; // Ganti dengan merchant server key Anda
\Midtrans\Config::$isProduction = false; // Set true jika sudah di production

// Proses pembayaran
function processPayment($orderId, $totalAmount, $customerAddress,$user_id, $snapToken) {
    // Buat transaksi pembayaran
    $transaction = array(
        'transaction_details' => array(
            'order_id' => $orderId,
            'gross_amount' => $totalAmount,
        ),
        'customer_details' => array(
            'address' => $customerAddress
        ),
        'credit_card' => array(
            'secure' => true,
        ),
    );

    try {
        // Lakukan pembayaran menggunakan Midtrans Snap dan ambil snap token
        $payment = \Midtrans\Snap::createTransaction($transaction);
        
        // Simpan data pembayaran ke dalam tabel payments
        // Misalnya, menggunakan database MySQL
        $conn = new mysqli("localhost", "root", "", "db_ecommerce");
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        $sql = "INSERT INTO payments (order_id, amount, customer_address, status, snap_token, id_user)
                VALUES ('$orderId', $totalAmount, '$customerAddress', 'pending', '$payment->token', '$user_id')";
        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return $payment;
        } else {
            $conn->close();
            return false;
        }
        
    } catch (Exception $e) {
        return false;
    }
}
// Endpoint untuk checkout
// Endpoint untuk checkout
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['orderId']) && isset($_POST['totalAmount']) && isset($_POST['customerAddress'])) {
    $orderId = $_POST['orderId'];
    $totalAmount = $_POST['totalAmount'];
    $customerAddress = $_POST['customerAddress'];
    $user_id = $_POST['user_id'];
    // Generate snap token
    $snapToken = processPayment($orderId, $totalAmount, $customerAddress,$user_id, 'SB-Mid-client-jLX4oWShl5K3rVva');
    if ($snapToken) {
        // Kirim snap token ke Flutter
        echo json_encode(array('snapToken' => $snapToken));
    } else {
        echo json_encode(array('error' => 'Failed to generate snap token'));
    }
}