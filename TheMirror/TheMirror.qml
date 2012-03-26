import QtQuick 1.0
import "components/Calender"
import "components/Clock"
import "components/MenuLock"

Rectangle {
    id: rectangle1
    width: 1280
    height: 600/*720*/

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.2; color: "lightgrey" }
        GradientStop { position: 0.4; color: "white" }
        GradientStop { position: 0.6; color: "white" }
        GradientStop { position: 0.8; color: "lightgrey" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }

    Calendar{
        opacity: 0.500
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

    Clock {

    }

    MenuLock {
        x: 296
        y: 251
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.500
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

    }

    Text {
        x: 541
        y: 548
        width: 223
        height: 18
        color: "#ffffff"
        text: qsTr("Slide this bar to set the mirror")
        opacity: 0.800
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 12
    }

}
