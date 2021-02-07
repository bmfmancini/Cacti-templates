<?php
/*
* Copyright (C) 2020 Orange
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License
* as published by the Free Software Foundation; either version 2
* of the License, or (at your option) any later version.
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/ 

/*
* Router Cisco ASR9k
* 
* Module:	Cisco ASR9k Memory
* Version:  0.1
* Created:  2020-05-26 by Marius Bostiog
*/

/* do NOT run this script through a web browser */
if (!isset($_SERVER["argv"][0]) || isset($_SERVER['REQUEST_METHOD'])  || isset($_SERVER['REMOTE_ADDR'])) {
   die("<br><strong>This script is only meant to run at the command line.</strong>");
}

$no_http_headers = true;

if (!isset($called_by_script_server)) {

	array_shift($_SERVER["argv"]);

	print call_user_func_array("getData", $_SERVER["argv"]);
}


function getData ($hostname, $comm, $cmd, $arg1 = "", $arg2 = ""){

$oids = [
    "index" => ".1.3.6.1.4.1.9.9.221.1.1.1.1.2",
    "physName" => ".1.3.6.1.2.1.47.1.1.1.1.7",
    "physDescr" => ".1.3.6.1.2.1.47.1.1.1.1.2",
    "HCUsed" => ".1.3.6.1.4.1.9.9.221.1.1.1.1.18",
    "HCFree" => ".1.3.6.1.4.1.9.9.221.1.1.1.1.20"
];

if ($cmd == "index"){
    $return_arr = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));

    foreach($return_arr as $val){
        print $val . "\n";
    }
}
elseif ($cmd == "query") {
    $arg = $arg1;

switch ($arg){
    case "index":
        $arrIndex = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));
        foreach($arrIndex as $val){
            print $val . "!" . $val . "\n";
        }
        break;
    case "physName":
        $arrIndex = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));
        
        foreach($arrIndex as $index){
            $arrVal = preg_replace("/(STRING: \")/", "", snmp2_get($hostname, $comm, $oids[$arg] . "." . $index));
            print $index . "!" . preg_replace("/\"/", "", $arrVal) . "\n";
        }
        break;
    case "physDescr":
        $arrIndex = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));
        foreach($arrIndex as $index){
            $arrVal = preg_replace("/(STRING: \")/", "", snmp2_get($hostname, $comm, $oids[$arg] . "." . $index));
            print $index . "!" . preg_replace("/\"/", "", $arrVal) . "\n";
        }
        break;
    case "HCUsed":
        $arrIndex = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));
        foreach($arrIndex as $index){
        $arrVal = getValues(snmp2_walk($hostname, $comm, $oids[$arg] . "." . $index));
        print $index . "!" . $arrVal . "\n";
        }
        break;
    case "HCFree":
        $arrIndex = reindexData(snmp2_real_walk($hostname, $comm, $oids['index']));
        foreach($arrIndex as $index){
        $arrVal = getValues(snmp2_walk($hostname, $comm, $oids[$arg] . "." . $index));
        print $index . "!" . $arrVal . "\n";
        }
        break;
    default:
        break;
}
}
elseif($cmd == "get"){
    $arg=$arg1;
    $index = $arg2;

    if($arg == 'limit'){

    }
    else {
        return getValues(snmp2_walk($hostname, $comm, $oids[$arg] . "." . $index));
    }
}
}

function reindexData ($arr){
    $return_arr = [];
    foreach($arr as $oid => $val){
        $index = preg_replace("/(.*9.9.221.1.1.1.1.2.)/", "", $oid);
        $return_arr[] = preg_replace('/\.([0-9]{1,9})/', "", $index);
    }

    return array_unique($return_arr);
}

function getValues ($arr) {
    $return_val = 0;
    foreach($arr as $val){
        $return_val += intval(preg_replace("/(Counter64: )/", "", $val)); 
    }
    return $return_val;
}