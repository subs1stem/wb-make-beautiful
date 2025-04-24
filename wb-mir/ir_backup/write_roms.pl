#!/usr/bin/perl
use 5.010;

$dir = $ARGV[0];
$ARGV[4] = '/dev/ttyRS485-1' unless defined $ARGV[4];

print "Stopping wb-mqtt-serial \n";
`systemctl stop wb-mqtt-serial`;

foreach $i (0..$ARGV[3]-1) {
    $reg = 5200 + $i;
    `modbus_client --debug -mrtu -b$ARGV[2] -pnone -o 700 -s2 $ARGV[4] -a$ARGV[1] -t0x05 -r $reg 0`;
    sleep(2);
}

foreach $i (0..$ARGV[3]-1) {
    $reg = 5200 + $i;
    `modbus_client --debug -mrtu -b$ARGV[2] -pnone -o 700 -s2 $ARGV[4] -a$ARGV[1] -t0x05 -r $reg 1`;
    $j = $i + 1;
    sleep(20); print "->$j";
    `./putbuffer.pl ./$dir/rom_$j.ir $ARGV[1]`;
    print "<-";
    `modbus_client --debug -mrtu -b$ARGV[2] -pnone -o 700 -s2 $ARGV[4] -a$ARGV[1] -t0x05 -r $reg 0`;
    sleep(2);
}

print "\nStarting wb-mqtt-serial \n";
`systemctl start wb-mqtt-serial`;

exit;
