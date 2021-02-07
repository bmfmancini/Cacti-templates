#!/usr/bin/perl
#
# timi@crystal.rdstm.ro
#
use SNMP_util;

$ip = $ARGV[0];
$comm = $ARGV[1];

$index_oid=".1.3.6.1.2.1.2.2.1.1.";

my %opt = (
    desc => ".1.3.6.1.2.1.2.2.1.2.",
    ifname => ".1.3.6.1.2.1.31.1.1.1.1.",
    ifalias => ".1.3.6.1.2.1.31.1.1.1.18.",
    iftype => ".1.3.6.1.2.1.2.2.1.3.",
    ifspeed => ".1.3.6.1.2.1.2.2.1.5.",
);

my %queue = (
    queue1 => "0",
    queue2 => "1",
    queue3 => "2",
    queue4 => "3",
    queue5 => "4",
    queue6 => "5",
    queue7 => "6",
    queue8 => "7",
);

$cos_drop_oid=".1.3.6.1.4.1.2636.3.15.4.1.11.";

if ($ARGV[2] eq "get"){
    $id_int = $ARGV[4];
    if ($ARGV[3] eq "index"){
	print $id_int;
    } else {
        $queuenr = $queue{$ARGV[3]};
	($get_cos_drop)= &snmpget("$comm\@$ip:161:1:2",$cos_drop_oid.$id_int.".".$queuenr);
	print $get_cos_drop;
    }
} else {

(@walk)= &snmpwalk("$comm\@$ip:161:1:2",$index_oid);

foreach $line(@walk) {
    ($crap, $id_int) = split(/:/, $line);
    ($get_iftype)= &snmpget("$comm\@$ip:161:1:2",$opt{iftype}.$id_int);
	if ($get_iftype eq "6"){
	    push (@id_int,$id_int);
	}
}

if ($ARGV[2] eq "index") {
    while (@id_int) {
	$id_int = shift @id_int;
	    print $id_int."!".$id_int."\n";
    }
} 


if ($ARGV[2] eq "query") {
    while (@id_int){
	$id_int = shift @id_int;
        if ($ARGV[3] eq "index"){
		print $id_int."!".$id_int."\n";
        } elsif ($oid_base=$opt{$ARGV[3]}){
	    $oid_complete=$oid_base.$id_int;
	    ($get_snmp) = &snmpget("$comm\@$ip:161:1:2",$oid_complete);
		print $id_int."!".$get_snmp."\n";
        }
    }
}
}