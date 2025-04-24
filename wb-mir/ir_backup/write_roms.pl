#!/usr/bin/perl
use 5.010;

$DIR = $ARGV[0];
$MODBUS_ADDRESS = $ARGV[1];
$BAUDRATE = $ARGV[2];
$ROM_COUNT = $ARGV[3];
$PORT = '/dev/ttyRS485-1' unless defined $ARGV[4];

print "Stopping wb-mqtt-serial \n";
`systemctl stop wb-mqtt-serial`;

foreach $i (0..$ROM_COUNT-1) {
    $reg = 5200 + $i;
    `modbus_client --debug -mrtu -b$BAUDRATE -pnone -o 700 -s2 $PORT -a$MODBUS_ADDRESS -t0x05 -r $reg 0`;
    sleep(2);
}

foreach $i (0..$ROM_COUNT-1) {
    $reg = 5200 + $i;
    `modbus_client --debug -mrtu -b$BAUDRATE -pnone -o 700 -s2 $PORT -a$MODBUS_ADDRESS -t0x05 -r $reg 1`;
    $j = $i + 1;
    sleep(20); print "->$j";
    `./putbuffer.pl ./$DIR/rom_$j.ir $MODBUS_ADDRESS $PORT`;
    print "<-";
    `modbus_client --debug -mrtu -b$BAUDRATE -pnone -o 700 -s2 $PORT -a$MODBUS_ADDRESS -t0x05 -r $reg 0`;
    sleep(2);
}

print "\nStarting wb-mqtt-serial \n";
`systemctl start wb-mqtt-serial`;

exit;
