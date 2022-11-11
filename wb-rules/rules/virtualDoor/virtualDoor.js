var PATH_TO_CONFIG = '/etc/wb-rules/virtualDoor/config.conf'

var config = readConfig(PATH_TO_CONFIG)

var door1RealTopic = config['door1']
var door2RealTopic = config['door2']
var doorAlarmTopic = 'virtualDoor/Door'
var door1VirtualTopic = 'virtualDoor/Door_1'
var door2VirtualTopic = 'virtualDoor/Door_2'
var doorPresentTopic = 'virtualDoor/Door_present'

defineVirtualDevice('virtualDoor', {
    title: 'Virtual door',
    cells: {
        Door_present: {
            type: 'switch',
            value: false,
            readonly: false,
            order: 1,
        },
        Door: {
            type: 'alarm',
            value: false,
            readonly: false,
            order: 2,
        },
        Door_1: {
            type: 'alarm',
            value: dev[door1RealTopic],
            readonly: false,
            order: 3,
        },
        Door_2: {
            type: 'alarm',
            value: dev[door2RealTopic],
            readonly: false,
            order: 4,
        },
    }
})

function checkDoorsAlarm() {
    dev[doorAlarmTopic] = (dev[door1VirtualTopic] || dev[door2VirtualTopic]) && dev[doorPresentTopic]
}

if (door1RealTopic) {
    defineRule('virtualDoor1', {
        whenChanged: door1RealTopic,
        then: function (newValue) {
            dev[door1VirtualTopic] = newValue
            checkDoorsAlarm()
        }
    })
}

if (door2RealTopic) {
    defineRule('virtualDoor2', {
        whenChanged: door2RealTopic,
        then: function (newValue) {
            dev[door2VirtualTopic] = newValue
            checkDoorsAlarm()
        }
    })
}

defineRule('checkTrigger', {
    whenChanged: doorPresentTopic,
    then: checkDoorsAlarm
})
