/****************************************************************************
** Based on cellardoor (http://code.google.com/p/cellardoor/)
**
****************************************************************************/

import QtQuick 1.0
import "js/calendar.js" as CalendarFunctions

Rectangle {

    property string currentEvent: "";

    id: calendar
    color: "#dddddd"
    clip: true
    radius: 3
    border.color: "lightgrey"
    border.width: 3

    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    signal clicked()

    property variant date: new Date()
    property variant clickedDate: calendar.date
    property int _maximumDaysInCalendar: 42

    function reset() {
        CalendarFunctions.populateModel()
    }

    ListModel {
        id: weekModel
        ListElement { week: "Sun"; value: 0}
        ListElement { week: "Mon"; value: 1}
        ListElement { week: "Tue"; value: 2}
        ListElement { week: "Wed"; value: 3}
        ListElement { week: "Thu"; value: 4}
        ListElement { week: "Fri"; value: 5}
        ListElement { week: "Sat"; value: 6}
    }

    ListModel {
        id: monthModel
    }

    MonthButton {
        id: monthButton
        anchors.left: calendar.left
        anchors.right: calendar.right
        calendarString: CalendarFunctions.getMonth() + " " + date.getFullYear()
        onPreviousClicked: CalendarFunctions.previousMonth()
        onNextClicked: CalendarFunctions.nextMonth()
    }


    Row {
        id: weekElement
        anchors.top: monthButton.bottom
        anchors.left: calendar.left
        anchors.right: calendar.right
        Repeater {
            model: weekModel
            Text {
                width: (calendar.width)/7
                font { family: nsRegular.name; pixelSize: calendar.height/18 }
                color: "#5e5e5e"
                horizontalAlignment: Text.AlignHCenter
                text: week
            }
        }
    }

    GridView {
        id: wdgGrid
        anchors.left: calendar.left
        // anchors.leftMargin: 1
        anchors.right: calendar.right
        // anchors.rightMargin: 1
        model: monthModel
        property int previousClicked: -1
        cellWidth: wdgGrid.width/7; cellHeight: wdgGrid.height/7
        anchors.top: weekElement.bottom
        anchors.bottom: calendar.bottom
        anchors.bottomMargin: -20
        interactive: false

        delegate: CalendarDay {
            id: dayDelegate
            day: model.day
            currentMonth: model.currentMonth
            currentDay: model.currentDay
            onButtonClicked: {
                //First time, just save the index
                if (wdgGrid.previousClicked == -1) {
                    wdgGrid.previousClicked = index
                } else {
                    wdgGrid.currentIndex = wdgGrid.previousClicked
                    var obj = wdgGrid.currentItem
                    obj.reset()
                    wdgGrid.previousClicked = index
                    wdgGrid.currentIndex = wdgGrid.previousClicked
                }
                var modelObj = monthModel.get(index)
                clickedDate = new Date(modelObj.year, modelObj.month, modelObj.day,
                                       clickedDate.getHours(),
                                       clickedDate.getMinutes())
                calendar.currentEvent = event
                calendar.clicked()
            }
        }
    }

    Component.onCompleted: { CalendarFunctions.populateModel() }
}
