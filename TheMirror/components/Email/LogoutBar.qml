import QtQuick 1.0

Rectangle {
    id: logoutBar
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.left: parent.left
    height: 30
    color: "#efefef"

    Rectangle {

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: 26
        width: logoutText.width + logoutImage.width + 20
        border.color: "grey"
        border.width: 1
        radius: 3
        color: "#efefef"
        scale: logoutButtonArea.pressed? 0.9: 1

        MouseArea {
            id: logoutButtonArea
            anchors.fill: parent
            onClicked: {
                settings.setSetting("logined", "false", "email", "./components/Email/")
                widgetCanvas.reloadWidget("email_widget");
                emailWindow.logined = false;
            }
        }

        Text {
            id: logoutText
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: logoutImage.left
            anchors.rightMargin: 10
            text: "Logout"
            font.family: "Helvetica"
            font.pixelSize: 15
            font.bold: true
        }

        Image {
            id: logoutImage
            source: "../../icons/logout.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
        }
    }
}
