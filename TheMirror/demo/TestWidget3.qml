import QtQuick 1.0
import "../common"

Rectangle {
    id: widgetID
    color: "yellow"

    Text {
        text :"Widget 3"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        label: "Select"
    }
}
