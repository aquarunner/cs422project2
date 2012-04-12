import QtQuick 1.0

Rectangle {
    id: button
    property bool isCurrentDay: false
    property string day: "ouch!"
    property bool currentMonth: true
    property bool currentDay: false
    property alias current: background.source

    property string background: button.currentDay ? "imgs/calendar_day_current.png" : "imgs/calendar_day_unset.png"
    property string pressed: "imgs/calendar_day_to_set.png"

    signal buttonClicked(int index)

    property string event: "";

    width: wdgGrid.cellWidth; height: wdgGrid.cellHeight
    border.color: "lightgrey"
    border.width: 2

    Component.onCompleted: {
        event = widgetsSettings.getSetting(year+"_"+(month+1)+"_"+day, "events", "./components/Calender/")
    }

    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    //FIXME: fails to execute
    function reset() {
        label.reset()
        button.current = button.background
    }

    Image {
        id: background
        source: button.background
        property bool visited: false
        signal buttonClicked
        width: wdgGrid.cellWidth; height: wdgGrid.cellHeight

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                if (!background.visited) {
                    background.source = button.pressed
                    label.selected()
                } else {
                    background.source = button.background
                    label.reset()
                }

                background.visited = !background.visited;

                button.buttonClicked(index)
            }

            onCanceled: background.current = button.background
        }
    }

    Text {
        id: label
        text: button.day
        font { family: nsRegular.name; pixelSize: 15 }
        color: currentMonth ? "#697e85" : "#9bb6bf"
        anchors.verticalCenter: background.verticalCenter
        anchors.horizontalCenter: background.horizontalCenter

        function reset() {
            label.color = currentMonth ? "#697e85" : "#9bb6bf"
        }

        function selected() {
            label.color = "#FFFFFF"
        }
    }

    Image {
        id: eventIndicator
        visible: event != ""
        source: "imgs/event_indicator.png"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    }
}
