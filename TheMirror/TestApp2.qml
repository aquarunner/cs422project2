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

        color: "brown"

        Text {
            x: 83
            y: 107
            text :"Solid color application"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        AnimatedImage { id: animation_1; x: 91; y: 247; source: "images/widget2.gif" }
        AnimatedImage { id: animation_2; x: -52; y: 394; width: 207; height: 135; source: "images/1.gif" }
        AnimatedImage { id: animation_3; x: 177; y: 394; source: "images/2.gif" }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: "Close"

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
