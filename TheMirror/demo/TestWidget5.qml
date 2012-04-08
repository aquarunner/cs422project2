import QtQuick 1.0
import "../common"

Rectangle {
    id: widgetID
    color: "orange"

    Text {
        text :"Widget 5"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        label: "OK"
    }
}
