import QtQuick 1.0
import "components/DigitalClock"


Rectangle {
    width: 1280
    height: 720

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.2; color: "lightgrey" }
        GradientStop { position: 0.4; color: "white" }
        GradientStop { position: 0.6; color: "white" }
        GradientStop { position: 0.8; color: "lightgrey" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }

//    Button {
//        label: "Change profile"
//        onClicked: {
//            loder.source = "MainScreen.qml"
//        }
//    }

    DigitalClock {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

    }

    Text {
        id: selectProfileText
        text: "Slect the profile you want to login"
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        color: "black"
        opacity: 0.8
        font.bold: true
        font.pixelSize: 16
    }

    Rectangle {
//        anchors.left: parent.left
//        anchors.leftMargin: 50

        anchors.horizontalCenter: selectProfileText.horizontalCenter

        anchors.bottom: selectProfileText.top
        anchors.bottomMargin: 10

        border.color: "grey"
        border.width: 3

        width: bill.width + mark.width + guest.width
        height: mark.height

        Rectangle {
            id: bill
            width: billImage.width
            height: billImage.height
            anchors.left: parent.left

            Image {
                id: billImage
                width: 60
                height: 60
                source: "icons/profile_bill.png"
                smooth: true
            }

            //border.color: billMa.pressed? "skyblue": "grey"
            scale: billMa.pressed? 0.9: 1
            border.color: "grey"
            border.width: 3

            MouseArea {
                id: billMa
                anchors.fill: parent
                onClicked: {
                    loder.source = "MainScreen.qml"
                }
            }
        }

        Rectangle {
            id: mark
            width: markImage.width
            height: markImage.height
            anchors.left: bill.right

            Image {
                id: markImage
                width: 60
                height: 60
                source: "icons/profile_mark.png"
                smooth: true
            }

           // border.color: markMa.pressed? "skyblue": "grey"
            border.color: "grey"
            scale: markMa.pressed? 0.9: 1
            border.width: 3

            MouseArea {
                id: markMa
                anchors.fill: parent
                onClicked: {
                    loder.source = "MainScreen.qml"
                }
            }
        }

        Rectangle {
            id: guest
            width: guestImage.width
            height: guestImage.height
            anchors.left: mark.right

            Image {
                id: guestImage
                width: 60
                height: 60
                source: "icons/guest.png"
                smooth: true
            }

            //border.color: guestMa.pressed? "skyblue": "grey"
            border.color: "grey"
            scale: guestMa.pressed? 0.9: 1
            border.width: 3

            MouseArea {
                id: guestMa
                anchors.fill: parent
                onClicked: {
                    loder.source = "MainScreen.qml"
                }
            }
        }
    }

    Loader {
        id: loder;
        x: 0
        y: 0
        width: parent.width
        height: parent.height


    }

}
