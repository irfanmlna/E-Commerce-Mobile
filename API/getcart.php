<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'koneksi.php';

$id_user = $koneksi->real_escape_string($_POST['id_user']);
$sql = "SELECT c.id, p.product_name, p.product_image, p.product_desc, p.product_price, p.product_stock
        FROM cart c 
        JOIN products p ON c.id_product = p.id 
        WHERE c.id_user = '$id_user'";
$result = $koneksi->query($sql);

$response = array();

if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Data Cart";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        // Ensure product_stock is an integer
        $row['product_stock'] = (int)$row['product_stock'];
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal menampilkan Data Cart";
    $response['data'] = null;
}

echo json_encode($response);

?>
