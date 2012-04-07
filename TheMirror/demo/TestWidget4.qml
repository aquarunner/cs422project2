import QtQuick 1.0
import "../common"

Rectangle {
    id: widgetID
    color: "brown"

    Text {
        text :"Widget 4"
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
