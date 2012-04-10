import Qt 4.7


Item {

    id: clock
    width : columnLayout.width
    height : columnLayout.height

    property color textColor : "#d2f523"
    property int fontSize : 42
    property int fontSizeDate: 25
    property string hours : "00"
    property string minutes : "00"
    property string seconds : "00"
    property string date: ""
    property variant shift : 0
    property bool showSeconds : false
    property bool showDate : true

    function timeChanged() {

        // To be fixed to fit locale
        var Month = new Array("January", "February", "March", "April", "May", "June",
                              "July", "August", "September", "October", "November", "December");
        var d = new Date;


        // hours
        var tmp = checkTime(shift ? d.getUTCHours() + Math.floor(clock.shift) : d.getHours())
        if (tmp != hours) {
            hours = tmp
        }

        // minutes
        tmp = checkTime(shift ? d.getUTCMinutes() + ((clock.shift % 1) * 60) : d.getMinutes())
        if (tmp != minutes) {
            minutes = tmp
        }

        // seconds
        seconds = checkTime(d.getUTCSeconds())


        // get Date
        date = Month[d.getMonth()] +" " + d.getDate()+ ", " + d.getFullYear();
    }


    function checkTime(i) {
        return (i<10) ? "0"+ i : i;
    }

    FontLoader {
        id: font
        source: "digital-7.ttf"
    }

    Timer {
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: clock.timeChanged()
    }


    Column {

        id: columnLayout

        Row {
            id : rowLayout
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: hoursText
                color: clock.textColor
                text: clock.hours
                font.pixelSize: clock.fontSize
                font.family: font.name
            }


            Text {
                id: colon
                width: 30
                text: blink? " : " : "   "
                color: clock.textColor
                font.pixelSize: clock.fontSize
                font.family: font.name

                property bool blink: false;
                Timer {
                    interval: 500; running: true; repeat: true; triggeredOnStart: true
                    onTriggered: colon.blink = !colon.blink
                }
            }

            Text {
                id : minutesText
                text: clock.minutes
                color: clock.textColor
                font.pixelSize: clock.fontSize
                font.family: font.name
            }


            Text {
                text: " : "
                color: clock.textColor
                font.pixelSize: clock.fontSize
                visible : clock.showSeconds
                font.family: font.name
            }


            Text {
                id : secondsText
                text: clock.seconds
                color: clock.textColor
                font.pixelSize: clock.fontSize
                visible : clock.showSeconds
                font.family: font.name
            }

        }


        Text {
            id : dateText
            text: clock.date
            font.family: "Calibri"
            color: parent.parent.textColor
            font.pixelSize: clock.fontSizeDate
            visible : clock.showDate
        }

    }

}
