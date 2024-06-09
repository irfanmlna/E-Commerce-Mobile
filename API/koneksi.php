<?php

$koneksi = mysqli_connect("localhost", "root", "", "db_store");

if($koneksi){

} else {
	echo "gagal Connect";
}

?>