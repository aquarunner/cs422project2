import QtQuick 1.0
import "../../common"

Rectangle {

//    height: 600
//    width: 800

    id: page
    color: "grey"

    Text {
        id: mailtoText
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: "Mail to: "
        font.pixelSize: 20
        font.bold: true;
        color:"white"
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: mailtoText.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30

        height: 25
        color: "white"
        border.color: "#444444"

        TextInput {
            anchors.fill: parent
            font.pixelSize: 20
            cursorVisible: true
        }
    }

    Text {
        id: ccText
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: "CC: "
        font.pixelSize: 20
        font.bold: true;
        color:"white"
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.left: mailtoText.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30

        height: 25
        color: "white"
        border.color: "#444444"

        TextInput {
            anchors.fill: parent
            font.pixelSize: 20
            cursorVisible: true
        }
    }

    Text {
        id: bccText
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: "BCC: "
        font.pixelSize: 20
        font.bold: true;
        color:"white"
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.left: mailtoText.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30

        height: 25
        color: "white"
        border.color: "#444444"

        TextInput {
            anchors.fill: parent
            font.pixelSize: 20
            cursorVisible: true
        }
    }

    Text {
        id: subjectText
        anchors.top: parent.top
        anchors.topMargin: 110
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: "Subject: "
        font.pixelSize: 20
        font.bold: true;
        color:"white"
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 110
        anchors.left: mailtoText.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30

        height: 25
        color: "white"
        border.color: "#444444"

        TextInput {
            anchors.fill: parent
            font.pixelSize: 20
            cursorVisible: true
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10


        color: "white"
        border.color: "#444444"

        TextInput {
            anchors.fill: parent
            font.pixelSize: 20
            cursorVisible: true
        }
    }



}
