import QtQuick 1.0
import "../../common"
import ".."

Rectangle {

    id: camera

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property bool flashing: false;
    property bool showPicture: false;

    property bool showCalleryButton: true
    property bool animated: true

    property int numberOfShoot: 0;

    property alias exitButton: exit;

    XmlApplicationLoader {
        id: xmlApplicationLoader
    }

    function help() {

    }

    Image {
        id: focusFrame
        source: "icons/focus.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width: 150
        height: 150
        y: 50

        smooth: true
        visible: !showPicture
    }

    ParallelAnimation {
        id: moveToGallery

        NumberAnimation { target: picJustTook; property: "x"; to: galleryArea.x; duration: 1000 }
        NumberAnimation { target: picJustTook; property: "y"; to: galleryArea.y - picJustTook.height/2; duration: 1000 }
    }

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
        visible: !showPicture

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
        visible: !showPicture

        MouseArea {
            id: shutterButton
            anchors.fill: parent
            onClicked: {
                flashing = true;
                shutterTimer.start();

            }
        }
    }

    Timer {
        id: shutterTimer
        interval: 250
        onTriggered: {
            flashing = false;
            showPic.start();
            showPicture = true;
            numberOfShoot++;
        }
    }

    Timer {
        id: showPic
        interval: 2000
        onTriggered: {
            if(animated) {
                moveToGallery.running = true;
            }
            animation.start();
        }
    }

    Timer {
        id: animation
        interval: animated? 1100: 0
        onTriggered: {
            showPicture = false
            picJustTook.x = camera.width/2 - picJustTook.width/2
            picJustTook.y = 50
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
        visible: !showPicture

        MouseArea {
            id: timerButton
            anchors.fill: parent

            onClicked: {
                countDown.visible = true;
                timerForTimer.start();
            }
        }
    }

    FontLoader {
        id: font
        source: "digital-7.ttf"
    }

    Text {
        id: countDown
        anchors.centerIn: focusFrame
        text: timerForTimer.seconds-1
        color: "#444444"
        font.pixelSize: 40
        font.family: font.name

        visible: false;
    }

    Timer {
        id: timerForTimer

        property int seconds: 10;

        interval: 1000
        repeat: true
        onTriggered: {
            seconds--;
            if(seconds == 0) {
                stop();
                countDown.visible = false;
                seconds = 10;

                flashing = true;
                shutterTimer.start();
            }
        }
    }


    Item {

        id: galleryArea

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 60
        height: 50

        visible: showCalleryButton

        PicButton2 {
            id: gallery
            label: "Gallery..."
            buttonColor: "#444444"
            pictureName: "../icons/Application_Multimedia_Gallery.png";

            onButtonClick: {
                xmlApplicationLoader.loadApplication("Gallery");
            }
        }
    }

    Image {
        id: picJustTook
        source: "pictures/sample.png"
        x: camera.width/2 - picJustTook.width/2
        y: 50

        smooth: true
        visible: showPicture
    }


    Button {
        id: exit

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
