<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'koneksi.php';

// $id_user = $koneksi->real_escape_string($_POST['id_user']);
$sql = "SELECT categories.id,categories.category_name,categories.imagecat,(SELECT COUNT(*) FROM products WHERE products.id_category = categories.id) AS jumlah FROM categories";
$result = $koneksi->query($sql);

$response = array();

if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Data Category";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal menampilkan Data Category";
    $response['data'] = null;
}

echo json_encode($response);

?>
