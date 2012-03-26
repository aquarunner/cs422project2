import QtQuick 1.0
import "common"

Rectangle {
    id: applicationID
    color: "#00000000" //transparent

    Rectangle
    {
        id: rectangle1
        x: 120
        y: 100
        width: 320
        height: 240

        color: "skyblue"

        Text {
            x: 83
            y: 107
            text :"Transparent color application"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: "Next..."

        onClicked: {
            applicationLoder.source = "TestApp2.qml"; // load another application
        }
    }
}
