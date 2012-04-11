import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property bool flashing: false;

    Image {
        id: voiceControl
        source: "icons/voiceControl.png"
        width: voiceControlButton.pressed? 45: 50
        height: voiceControlButton.pressed? 45: 50
        smooth: true

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 100

        MouseArea {
            id: voiceControlButton
            anchors.fill: parent
        }
    }

    Image {
        id: shutter
        source: "icons/shutter.png"
        width: shutterButton.pressed? 45: 50
        height: shutterButton.pressed? 45: 50
        smooth: true

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            id: shutterButton
            anchors.fill: parent
            onClicked: {
                flashing = true;
                shutterTimer.start();

            }
        }

        Timer {
            id: shutterTimer
            interval: 250
            onTriggered: {
                flashing = false;
            }
        }
    }

    Image {
        id: timer
        source: "icons/timer.png"
        width: timerButton.pressed? 45: 50
        height: timerButton.pressed? 45: 50
        smooth: true

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.right: parent.right
        anchors.rightMargin: 100

        MouseArea {
            id: timerButton
            anchors.fill: parent
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: i18n.exit

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }

    Rectangle {
        id: flash
        color: "white"
        width: mainScreen.width
        height: mainScreen.height + 40
        x: -applicationLoder.x
        y: -applicationLoder.y - mainScreen.notificationBarHeight

        visible: flashing
    }

}
