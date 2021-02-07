#!/usr/bin/perl
#
# timi@crystal.rdstm.ro
#

use SNMP_util;

$ip = $ARGV[0];
$comm = $ARGV[1];

my %opt = (
    description=>".1.3.6.1.4.1.2636.3.1.13.1.5",
    temp=>".1.3.6.1.4.1.2636.3.1.13.1.7",
    cpu=>".1.3.6.1.4.1.2636.3.1.13.1.8",
    buffpoolutil=>".1.3.6.1.4.1.2636.3.1.13.1.11",
    heaputil=>".1.3.6.1.4.1.2636.3.1.13.1.12",
);

$base_oid=".1.3.6.1.4.1.2636.3.1.13.1";

if ($ARGV[2] eq "get"){ 
	$reindex=$ARGV[3];
	$idget=$ARGV[4];
	if ($reindex eq "index"){
	    print $idget;
	} else {
	    $oid_base=$opt{$ARGV[3]};
	    $oid=$oid_base.$idget;
	    $fpc = &snmpget("$comm\@$ip:161:1:2",$oid);
	    print $fpc."\n";
	}
} else {

$ContainersIndex=".1";
$L1Index=".2";
$L2Index=".3";
$L3Index=".4";

(@walk) = &snmpwalk("$comm\@$ip:161:1:2",$base_oid.$ContainersIndex);
foreach $line(@walk) {
 ($crap, $idContainers) = split(/:/, $line);
 push (@Containers,$idContainers);
}

(@walk) = &snmpwalk("$comm\@$ip:161:1:2",$base_oid.$L1Index);
foreach $line(@walk) {
 ($crap, $idL1) = split(/:/, $line);
 push (@L1Index,$idL1);
}

(@walk) = &snmpwalk("$comm\@$ip:161:1:2",$base_oid.$L2Index);
foreach $line(@walk) {
 ($crap, $idL2) = split(/:/, $line);
 push (@L2Index,$idL2);
}

(@walk) = &snmpwalk("$comm\@$ip:161:1:2",$base_oid.$L3Index);
foreach $line(@walk) {
 ($crap, $idL3) = split(/:/, $line);
 push (@L3Index,$idL3);
}

if ($ARGV[2] eq "index") {
    while (@Containers){
	$idC = shift @Containers;
        $idL1 = shift @L1Index;
        $idL2 = shift @L2Index;
        $idL3 = shift @L3Index;
        $idx = ".".$idC.".".$idL1.".".$idL2.".".$idL3;
        # PEM
        if ($idC == 2){
		print $idx."!".$idx."\n";
        }
        # FAN
        if ($idC == 4){
		print $idx."!".$idx."\n";
        }
	# FPC
        if ($idC == 7){
		print $idx."!".$idx."\n";
        }
        # Routing Engine
        if ($idC == 9){
		print $idx."!".$idx."\n";
        }
        # CB
        if ($idC == 12){
	    print $idx."!".$idx."\n";
        }
    }
} 


if ($ARGV[2] eq "query"){ 
    $oid_base=$opt{$ARGV[3]};
    while (@Containers){
	$idC = shift @Containers;
        $idL1 = shift @L1Index;
        $idL2 = shift @L2Index;
        $idL3 = shift @L3Index;
        $idx = ".".$idC.".".$idL1.".".$idL2.".".$idL3;
        $oid_complete=$oid_base.$idx;
	if ($ARGV[3] eq "index") {
	    if (($idC == 2) || ($idC == 4) || ($idC == 7) || ($idC == 9) || ($idC == 12)){
		print $idx."!".$idx."\n";
	    }
	}
        # PEM
        elsif ($idC == 2){
		$fpc = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $idx."!".$fpc."\n";
        }
        # FAN
        elsif ($idC == 4){
		$fpc = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $idx."!".$fpc."\n";
        }
	# FPC
        elsif ($idC == 7){
		$fpc = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $idx."!".$fpc."\n";
        }
        # Routing Engine
        elsif ($idC == 9){
		$fpc = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $idx."!".$fpc."\n";
        }
        # CB
        elsif ($idC == 12){
		$fpc = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $idx."!".$fpc."\n";
        }
    }
}
}