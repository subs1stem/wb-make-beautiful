#!/usr/bin/perl
use 5.010;

$ROM = $ARGV[0];
$MODBUS_ADDRESS = $ARGV[1];
$PORT = $ARGV[2];

open BUFF, $ROM;

my (@buff)=split('\s', <BUFF>);
my $i;
my $data;

foreach $i (2000, 2121, 2242, 2363) {
	$data = "@buff[$i-2000..$i-2000+120]";
	print "modbus_client --debug -mrtu -b9600  -pnone -s2 $PORT -a$MODBUS_ADDRESS -t0x10 -r$i $data \n";
	`modbus_client --debug -mrtu -b9600  -pnone -s2 $PORT -a$MODBUS_ADDRESS -t0x10 -r$i $data`;
}

$i = 2484;
$data = "@buff[$i-2000..$i-2000+22]";
`modbus_client --debug -mrtu -b9600 -pnone -s2 $PORT -a$MODBUS_ADDRESS -t0x10 -r$i $data`;

exit;
