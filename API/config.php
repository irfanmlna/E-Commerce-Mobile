<?php
// config.php

require_once 'vendor/autoload.php';

\Midtrans\Config::$serverKey = 'SB-Mid-server-8O8xFkI3HZoh6S6TKQ75trso';
\Midtrans\Config::$isProduction = false; // Ubah ke true untuk production
\Midtrans\Config::$isSanitized = true;
\Midtrans\Config::$is3ds = true;
