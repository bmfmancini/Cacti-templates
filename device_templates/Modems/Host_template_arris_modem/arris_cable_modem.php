<?php

/*
	This script is meant for use on the Arris model TM402G
	DOCSIS cable modem only. There is no warranty, guarantee,
	or any other disclosed agreement governing this utility.

	Tested to work on: 
		System:  ARRIS DOCSIS 1.1 / PacketCable 1.0 Touchstone Telephony Modem HW_REV: 32
		VENDOR: Arris Interactive, L.L.C.
		BOOTR: 5.01
		SW_REV: 4.5.69R.D11PLUS
		MODEL: TM402G  

*/

$fp = fsockopen("192.168.100.1", 80, $errno, $errstr, 30);
if (!$fp) {
   echo "$errstr ($errno)<br />\n";
} else {
   $out = "GET / HTTP/1.1\r\n";
   $out .= "Host: 192.168.100.1\r\n";
   $out .= "Connection: Close\r\n\r\n";

   fwrite($fp, $out);
   while (!feof($fp)) {
       $html = $html . fgets($fp,4096);
   }
   fclose($fp);
   $html = strip_tags($html);
        $html = str_replace("\t"," ",$html);
        $html = str_replace("\n"," ",$html);
        $html = str_replace("\r"," ",$html);
        $html = str_replace("&nbsp;"," ",$html);
        $html = str_replace("\t"," ",$html);

        while (strpos($html,"  ") <> false) {
                $html = str_replace("  "," ",$html);
        }

}

function find_value($f_string,$f_start,$f_end,$f_offset='default')
  {
        if ($f_offset <> "default") {
                $s_offset = strpos($f_string,$f_offset);
        }
        else {
                $s_offset = 0;
        }
        $s_start = strpos($f_string,$f_start,$s_offset);
        $s_start = $s_start + strlen($f_start);
        $s_end = strpos($f_string,$f_end,$s_offset);
        $value = substr($f_string,$s_start,$s_end - $s_start);
        return trim($value);
  }

echo "ds_power:". find_value($html,"MHz","dBmV") . " ds_snr:". find_value($html,"Ratio:"," dB ") . " us_power:". find_value($html,"MHz","dBmV","Upstream");

?>


