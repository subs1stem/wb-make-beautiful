# ir-backup

Набор скриптов для чтения и загрузки содержимого ПЗУ WB-MIR, WB-MSW v.3

Автор первоначальных версий скриптов [pivcheg](https://support.wirenboard.com/u/pivcheg/summary). [Тема](https://support.wirenboard.com/t/wb-mir-wb-msw-skript-dlya-sohraneniya-i-zapisi-komand-ik-ir/7918/16) на форуме.

## Скрипты

```read_roms.pl``` - чтение содержимого ПЗУ. Каждый банк складывается в отдельный файл (```rom_1.ir```, ```rom_2.ir```, ...). Содержимое файла - набор десятичных чисел.

Команда для запуска:

```bash
./read_roms.pl <directory> <modbus-address> <baudrate> <number-of-ROMs> <port>
```
* ```directory``` - имя директории (создаётся, если нет), в которую загружаются банки памяти;
* ```modbus-address``` - Modbus адрес устройства, с которого загружаются банки памяти;
* ```baudrate``` - скорость передачи данных;
* ```number-of-ROMs``` - количество ячеек ROM, которые требуется прочитать;
* ```port``` - RS-485 порт;

Пример:

```bash
./read_roms.pl ./testroms 21 9600 3 /dev/ttyRS485-1
```

---

```write_roms.pl``` - запись дампов ПЗУ из файлов.

Команда для запуска:

```bash
./write_roms.pl <directory> <modbus-address> <baudrate> <number-of-ROMs> <port>
```

* ```directory``` - имя директории, в которой хранятся считанные банки памяти;
* ```modbus-address``` - Modbus адрес устройства, на которое загружаются банки памяти;
* ```baudrate``` - скорость передачи данных;
* ```number-of-ROMs``` - количество ячеек ROM, которые требуется записать;
* ```port``` - RS-485 порт;

Пример:

```bash
./write_roms.pl ./dumps/kentatsu-v1 21 9600 11 /dev/ttyRS485-2
```
