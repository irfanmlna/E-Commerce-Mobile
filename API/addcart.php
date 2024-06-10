<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['id_product']) && isset($_POST['id_user'])) {
        $id_product = $_POST['id_product'];
        $id_user = $_POST['id_user'];

        // Cek apakah id_user sudah ada dalam tabel cart
        $check_query = "SELECT * FROM cart WHERE id_product = '$id_product' AND id_user = '$id_user'";
        $check_result = $koneksi->query($check_query);

        if ($check_result->num_rows > 0) {
            // id_user sudah ada dalam tabel cart
            $response['isSuccess'] = false;
            $response['message'] = "Produk sudah ada di keranjang";
        } else {
            // id_user belum ada dalam tabel cart, tambahkan data
            $sql = "INSERT INTO cart (id_product, id_user) VALUES ('$id_product', '$id_user')";
            if ($koneksi->query($sql) === TRUE) {
                $response['isSuccess'] = true;
                $response['message'] = "Berhasil Menambahkan ke keranjang";
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Gagal Menambahkan ke keranjang: " . $koneksi->error;
            }
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
?>
