#!/usr/bin/perl
use 5.010;

$MODBUS_ADDRESS = $ARGV[0];
$PORT = $ARGV[1];

foreach $i (2000, 2125, 2250, 2375) {
    $command = qq (echo `modbus_client --debug -mrtu -b9600 -pnone -s2 $PORT -a$MODBUS_ADDRESS -t0x03 -r$i -c 125 | grep Data | sed -e 's/Data://' -e 's/s//g'`);
    $a.=`$command`;
}

$command2 = qq (echo `modbus_client --debug -mrtu -b9600 -pnone -s2 $PORT -a$MODBUS_ADDRESS -t0x03 -r2500 -c 9 | grep Data | sed -e 's/Data://' -e 's/s//g'`);
$a.=`$command2`;

$a = ~s/\n/ /g;
@a = split(' ',$a);
@dec = map hex, @a;
$b = join (' ',@dec);

say $b;
