import QtQuick 1.0
import "../Camera"
import "../../common"

Flipable {

    id: changePassword

    property bool inEnterNewPasswordPage: false
    property int angle: 0

    Component.onCompleted: {
        applicationCanvas.isApplicationAreaTransparent = false;
    }

    front: Rectangle {

        anchors.fill: parent
        color: "#00000000"

        id: oldPassword

        Text {

            id: pleaseEnterCurrent
            text: "Please enter the current ROOT password of the mirror"
            y: 150
            x: 20
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }


        Text {
            text: "Password: "
            anchors.left: pleaseEnterCurrent.left
            // anchors.leftMargin: 50
            y: 200
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }

        Rectangle {
            anchors.left: pleaseEnterCurrent.left
            anchors.leftMargin: 150
            y: 200
            width: 150
            height: 30
            color: "white"
            border.color: "#444444"

            TextInput {
                anchors.fill: parent
                echoMode : TextInput.Password
                font.pixelSize: 20
                // maximumLength: 4
                cursorVisible: true
            }
        }


        Button {
            id: back

            anchors.bottom: oldPassword.bottom
            anchors.bottomMargin: 10
            anchors.left: oldPassword.left
            anchors.leftMargin: 20
            label: i18n.back

            onClicked: {
                backToSettingsMenu(true);
            }
        }

        Button {
            id: next

            anchors.bottom: oldPassword.bottom
            anchors.bottomMargin: 10
            anchors.right: oldPassword.right
            anchors.rightMargin: 20
            label: i18n.next

            onClicked: {
                inEnterNewPasswordPage = true
            }
        }

    }

    back:  Rectangle {
        id: enterPinCode
        width: changePassword.width
        height: changePassword.height
        color: "#00000000"

        Text {
            text: "Please enter a new ROOT password for the mirror"
            anchors.horizontalCenter: parent.horizontalCenter
            y: 150
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }



        Text {
            text: "New password: "
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: 200
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 20
            font.family: "Arial"
            color: "#444444"
        }

        Text {
            text: "Confirm new password: "
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: 250
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 20
            font.family: "Arial"
            color: "#444444"
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 50
            y: 200
            width: 150
            height: 30
            color: "white"
            border.color: "#444444"

            TextInput {
                anchors.fill: parent
                echoMode : TextInput.Password
                font.pixelSize: 20
                // maximumLength: 4
                cursorVisible: true
            }
        }



        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 50
            y: 250
            width: 150
            height: 30
            color: "white"
            border.color: "#444444"

            TextInput {
                anchors.fill: parent
                echoMode : TextInput.Password
                font.pixelSize: 20
                // maximumLength: 4
                cursorVisible: true
            }
        }

        Button {
            id: ok

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            label: i18n.ok

            onClicked: {
                backToSettingsMenu(false);
            }
        }

    }

    function backToSettingsMenu(backToSubMenu) {
        applicationLoder.title = i18n.manage_profiles;
        applicationLoder.iconName = "SettingsMenu_Profile.png";

        applicationCanvas.componentLoder.source = "SettingsMenu.qml"

        applicationCanvas.componentLoder.item.back.viewID =  applicationCanvas.componentLoder.item.settingsSubMenuList
        applicationCanvas.componentLoder.item.settingsSubMenuList.model =  applicationCanvas.componentLoder.item.manageProfilesSubMenuModel;
        applicationCanvas.componentLoder.item.showSubMenu = backToSubMenu;
    }


    transform: Rotation{
        origin.x:changePassword.width/2;
        origin.y:changePassword.height/2
        axis.x:0; axis.y:1; axis.z:0
        angle:changePassword.angle
    }

    states: State {
        PropertyChanges { target: changePassword; angle: 180 }
        when: inEnterNewPasswordPage
    }

    transitions: Transition {
        NumberAnimation{ property: "angle"; duration:500 }
    }

}
