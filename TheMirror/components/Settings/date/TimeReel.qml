import QtQuick 1.0

Item {
    id: container


    property int hourWidth: (width-2*spacing)*0.3
    property int hourHeight: height

    property int minuteWidth: (width-2*spacing)*0.3
    property int minuteHeight: height

    // Font properties
    property string fontName: 'Helvetica'
    property int fontSize: 22
    property color fontColor: "#666666"
    // Spacing between items
    property int spacing: 8

    property Component itemBackground: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button.png"
        }
    }
    property Component itemBackgroundPressed: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button_pressed.png"
        }
    }

    width: 240
    height:  60

    Component.onCompleted: {
        var date = new Date();
        hour.index = date.getHours();
        minute.index = date.getMinutes();
    }

    Component {
        id: hourDelegate
        Button {
            width: container.hourWidth
            height: container.hourHeight
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { hour.index = index; hour.toggle() }
            opacity: (index+1 < hour.start) ? 0.5 : 1.0
        }
    }

    Component {
        id: minuteDelegate
        Button {
            width: container.minuteWidth
            height: container.minuteHeight
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { minute.index = index; minute.toggle() }
            opacity: (index+1 < minutes.start || index+1 > minutes.end) ? 0.5 : 1.0
        }
    }
    Row {
        id: reels
        spacing: container.spacing

        Reel {
            id: hour
            width: container.hourWidth
            height: container.hourHeight
            model: hours
            delegate: hourDelegate
            // onIndexChanged: { checkIndex(); days.update() }
            autoClose: false
            //            function checkIndex() {
            //                if (index+1 < hours.start) index = (index+1 < hours.start-(index+1)) ? index = 11 : index = hours.start-1
            //            }
        }

        Reel {
            id: minute
            width: container.minuteWidth
            height: container.minuteHeight
            // onIndexChanged: checkIndex()
            model: minutes
            delegate:  minuteDelegate
            autoClose: false
            //            function checkIndex() {
            //                if (index+1 < days.start) {
            //                    index = (31-days.end+index+1 < days.start-(index+1)) ? days.end-1 : days.start-1
            //                } else if (index + 1 > days.end) {
            //                    index = (index+1-days.end < 31-(index+1)+days.start) ? days.end-1 : days.start-1
            //                }
            //            }
        }
    }

    ListModel{
        id: hours
        property int start: 1
        //        function update() {
        //            var date = new Date();
        //            hours.start = (year.index === 0) ? date.getMonth()+1 : 1;
        //            month.checkIndex();
        //            days.update();
        //        }
        ListElement { number: "00"}
        ListElement { number: "01"}
        ListElement { number: "02"}
        ListElement { number: "03"}
        ListElement { number: "04"}
        ListElement { number: "05"}
        ListElement { number: "06"}
        ListElement { number: "07"}
        ListElement { number: "08"}
        ListElement { number: "09"}
        ListElement { number: "10"}
        ListElement { number: "11" }
        ListElement { number: "12" }
        ListElement { number: "13" }
        ListElement { number: "14" }
        ListElement { number: "15" }
        ListElement { number: "16" }
        ListElement { number: "17" }
        ListElement { number: "18" }
        ListElement { number: "19" }
        ListElement { number: "20" }
        ListElement { number: "21" }
        ListElement { number: "22" }
        ListElement { number: "23" }

    }

    ListModel {
        id: minutes
        property int start: 0
        property int end: 59

        //        function update() {
        //            var date = new Date();

        //            var selectedYear = date.getFullYear();
        //            try { selectedYear = years.get(year.index).number;
        //            } catch(err) {}

        //            days.start = 1;
        //            if (selectedYear == date.getFullYear() && month.index === date.getMonth()) days.start = date.getDate();

        //            // Determine the amount of days in month
        //            days.end = 32 - new Date(selectedYear, month.index, 32).getDate();

        //            if (day.index+1 < days.start) day.index = days.start-1;
        //            else if (day.index+1 > days.end ) day.index = days.end-1;
        //        }

        ListElement { number: "0"}
        ListElement { number: "1"}
        ListElement { number: "2"}
        ListElement { number: "3"}
        ListElement { number: "4"}
        ListElement { number: "5"}
        ListElement { number: "6"}
        ListElement { number: "7"}
        ListElement { number: "8"}
        ListElement { number: "9"}
        ListElement { number: "10"}
        ListElement { number: "11"}
        ListElement { number: "12"}
        ListElement { number: "13"}
        ListElement { number: "14"}
        ListElement { number: "15"}
        ListElement { number: "16"}
        ListElement { number: "17"}
        ListElement { number: "18"}
        ListElement { number: "19"}
        ListElement { number: "20"}
        ListElement { number: "21"}
        ListElement { number: "22"}
        ListElement { number: "23"}
        ListElement { number: "24"}
        ListElement { number: "25"}
        ListElement { number: "26"}
        ListElement { number: "27"}
        ListElement { number: "28"}
        ListElement { number: "29"}
        ListElement { number: "30"}
        ListElement { number: "31"}
        ListElement { number: "32"}
        ListElement { number: "33"}
        ListElement { number: "34"}
        ListElement { number: "35"}
        ListElement { number: "36"}
        ListElement { number: "37"}
        ListElement { number: "38"}
        ListElement { number: "39"}
        ListElement { number: "40"}
        ListElement { number: "41"}
        ListElement { number: "42"}
        ListElement { number: "43"}
        ListElement { number: "44"}
        ListElement { number: "45"}
        ListElement { number: "46"}
        ListElement { number: "47"}
        ListElement { number: "48"}
        ListElement { number: "49"}
        ListElement { number: "50"}
        ListElement { number: "51"}
        ListElement { number: "52"}
        ListElement { number: "53"}
        ListElement { number: "54"}
        ListElement { number: "55"}
        ListElement { number: "56"}
        ListElement { number: "57"}
        ListElement { number: "58"}
        ListElement { number: "59"}

    }

    function getDate() {
        return "" + months.get(month.index).name + " " + days.get(day.index).number

    }
}
