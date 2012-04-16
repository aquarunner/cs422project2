import QtQuick 1.0
import "../../common"
import ".."

Rectangle {
    id:   playerWidget
    color: "lightgrey"
    anchors.fill: parent
    anchors.topMargin: 5
    anchors.bottomMargin: 5
    anchors.leftMargin: 5
    anchors.rightMargin: 5

    radius: 5

    property bool playing: false

    PlayerButton {
        id: seekBack
        icon: "icons/skip-back.png"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        width: 50
        height: 50
    }

    PlayerButton {
        id: play
        anchors.left: seekBack.right
        anchors.leftMargin: -5
        anchors.verticalCenter: parent.verticalCenter
        icon: playing? "icons/pause.png": "icons/play.png"
        width: 50
        height: 50

        onClicked: {
            if(playing) {
                // pause here
                playing = false;
            }else {
                // start
                playing = true
            }
        }
    }

    PlayerButton {
        id: seekForward
        anchors.left: play.right
        anchors.leftMargin: -5
        anchors.verticalCenter: parent.verticalCenter
        icon: "icons/skip-forward.png"
        width: 50
        height: 50
    }

    XmlApplicationLoader {
        id: xmlApplicationLoader
    }

    Image {
        anchors.left: seekForward.right
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter

        source: "../../icons/Application_Multimedia_MultimediaPlayer.png"
        width: 50
        height: 50
        scale: mouseArea.pressed? 0.9: 1

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                xmlApplicationLoader.loadApplication("Media Player");
                mainScreen.showMainMenuBar = false;
                mainScreen.showApplicationArea = true;
            }
        }


    }

}
