import QtQuick 1.0
import "common"

Rectangle {
    id: applicationID
    color: applicationColor //DO NOT modify this, unless you want background other than system's

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
            applicationCanvas.isApplicationAreaTransparent = false; // new loaded application use solid background
            applicationCanvas.showBorder = true; // show border?
            applicationCanvas.applicationAreaHeightInNumberOfCells = 12 // change the height of applicationCanvas
            applicationCanvas.applicationAreaWidthInNumberOfCells = 8 // change the width of applicationCanvas

            applicationLoder.title = "Test App 2"
            applicationLoder.iconName = "Settings.png"
        }
    }
}
