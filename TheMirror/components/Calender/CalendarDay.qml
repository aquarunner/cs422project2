import QtQuick 1.0

Item {
    id: button
    property bool isCurrentDay: false
    property string day: "ouch!"
    property bool currentMonth: true
    property bool currentDay: false
    property alias current: background.source

    property string background: button.currentDay ? "imgs/calendar_day_current.png" : "imgs/calendar_day_unset.png"
    property string pressed: "imgs/calendar_day_to_set.png"
    signal buttonClicked(int index)
    width: background.width; height: background.height

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
        font { family: nsRegular.name; pixelSize: 22 }
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
}
