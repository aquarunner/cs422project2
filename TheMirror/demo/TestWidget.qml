import QtQuick 1.0
import "../common"

Rectangle {
    id: widgetID
    color: "lightgreen"

    Text {
        text :"Widget"
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
