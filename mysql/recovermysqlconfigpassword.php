#! /usr/bin/php  -q
<?php
$fp = fopen(".mylogin.cnf", "r");
if (!$fp) {
  die("Cannot open .mylogin.cnf");
}

# read key
fseek($fp, 4);
$key = fread($fp, 20);

# generate real key
$rkey = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
for ($i = 0; $i < strlen($key); $i++) {
 $rkey[$i % 16] = ( $rkey[$i % 16] ^ $key[$i] );
}

# for each line
while ($len = fread($fp, 4)) {
  # as integer
  $len = unpack("V", $len);
  $len = $len[1];

  # decrypt  
  $crypt = fread($fp, $len);
  $plain = openssl_decrypt($crypt, 'aes-128-ecb', $rkey, true);

  # print
  print $plain;
}

