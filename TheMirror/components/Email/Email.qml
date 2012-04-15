import QtQuick 1.0
import "../../common"

Rectangle {
    id: emailWindow

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property string currentMenu: "Inbox"
    property bool logined: false;

    Component.onCompleted: {
        logined = (settings.getSetting("logined", "email", "./components/Email/") == "true");
    }

    Rectangle {
        id: leftArea
        anchors.fill: parent
        anchors.rightMargin: parent.width/4*3
        anchors.bottomMargin: 55
        color: "#efefef"

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 2
            color: "grey"
        }

        ListView {
            id: menuList
            anchors.fill: parent
            delegate: CategoryDelegate {}
            model: menuModel
            highlight: Rectangle { color: "steelblue" }
            highlightMoveSpeed: 9999999
            clip: true
            interactive: false
        }

        ListModel {
            id: menuModel

            ListElement {name: "Inbox" }
            ListElement {name: "+ Compose" }
            ListElement {name: "Sent" }
            ListElement {name: "Draft" }
        }
    }

    Rectangle {
        id: rightArea
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: leftArea.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 55

        LogoutBar {id: logoutBar}

        MailArea {
            id: mailArea
            anchors.fill: parent
            anchors.topMargin: logoutBar.height
            pagesListView.currentIndex: menuList.currentIndex
        }
    }

    Button {
        id: send

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: leftArea.right
        anchors.leftMargin: 20
        label: "Send"
        visible: menuList.currentIndex == 1

        onClicked: {
            menuList.currentIndex = 0
        }
    }


    property variant pageView;

    Button {
        id: exit

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: (pageView === undefined || pageView === null || pageView.currentIndex == 0)? i18n.exit: i18n.back

        onClicked: {
            if(pageView === undefined || pageView === null || pageView.currentIndex == 0) {
                mainScreen.showMainMenuBar = true;
                mainScreen.showApplicationArea = false;
            } else {
                pageView.currentIndex = pageView.currentIndex - 1
            }
        }
    }

    Rectangle {
        id: cover
        color: "darkgrey"
        anchors.fill: parent
        anchors.bottomMargin: 55
        visible: !logined

        // opacity: 0.98


        Text {
            id: emailAdressText
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 30
            text: "Email address: "
            font.pixelSize: 20
            font.bold: true;
            color:"white"
        }

        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: emailAdressText.right
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
            id: passwordText
            anchors.top: parent.top
            anchors.topMargin: 150
            anchors.left: parent.left
            anchors.leftMargin: 30
            text: "Password: "
            font.pixelSize: 20
            font.bold: true;
            color:"white"
        }

        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 150
            anchors.left: emailAdressText.right
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
                echoMode: TextInput.Password
            }
        }

        Button {
            id: login

            anchors.bottom: parent.bottom
            anchors.bottomMargin: -42
            anchors.left: parent.left
            anchors.leftMargin: 20
            label: "Login"

            onClicked: {
                emailAdressText.text = "";
                passwordText.text = "";
                logined = true;
                settings.setSetting("logined", "true", "email", "./components/Email/")
                widgetCanvas.reloadWidget("email_widget");
            }
        }
    }
}
