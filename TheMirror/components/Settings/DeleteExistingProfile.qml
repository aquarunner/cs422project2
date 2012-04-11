import QtQuick 1.0
import "../Camera"
import "../../common"

Flipable {

    id: deleteExistingProfile

    property bool inEnterNewPasswordPage: false
    property int angle: 0

    Component.onCompleted: {
        applicationCanvas.isApplicationAreaTransparent = false;
    }

    anchors.fill: parent
    anchors.topMargin: 55

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

    back:  ListView {
        id: existingProfilesListView

        width: deleteExistingProfile.width
        height: deleteExistingProfile.height

        property string currentSelection: ""

        ListModel {
            id: existingProfilesModel;
            ListElement { identification: "Mark"; sourceName: ""; name: "Created on April 1st, 2012"; secondIconSource: "icons/profile_mark.png"}
            ListElement { identification: "Bill"; sourceName: ""; name: "Created on April 15th, 2012"; secondIconSource: "icons/profile_bill.png"}
        }

        model: existingProfilesModel

        delegate: Rectangle {

            width: deleteExistingProfile.width
            height: 70

            color: mouseArea.pressed ? "lightgrey" : "#00000000"
            border.color: "white"
            border.width: 3

            signal clicked

            property bool selected: existingProfilesListView.currentSelection == identification;

            Image {
                id: iconArea
                x: 20
                width: 20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
                source: selected? "icons/RadioButton_On.png": "icons/RadioButton_Off.png"
                smooth: true
            }

            Image {
                id: secondIcon
                anchors.verticalCenter: parent.verticalCenter
                source: secondIconSource
                anchors.left: iconArea.right
                anchors.leftMargin: 20
                width: 50
                height: 50
            }

            Text {
                id: titleArea
                anchors.left: secondIcon.right
                anchors.leftMargin: 20
                height: 20
                text: name
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                font.bold: true
                font.family: "Arial"
                color: "white"
            }


            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    parent.clicked();
                }
            }

            onClicked: {
                existingProfilesListView.currentSelection = identification;
            }
        }

        property bool confirm: false

        Text {
            visible: existingProfilesListView.confirm
            text: "Are you sure you want to delete the selected profile?"
            anchors.horizontalCenter: parent.horizontalCenter
            y: 350
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }

        Button {
            id: delete_

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            label: i18n.delete_

            onClicked: {
                if(existingProfilesListView.confirm) {

                    for(var i = 0; i < existingProfilesModel.count; i++) {
                        if(existingProfilesModel.get(i).identification == existingProfilesListView.currentSelection) {
                            existingProfilesListView.currentSelection = ""
                            existingProfilesModel.remove(i);
                            break;
                        }
                    }

                    existingProfilesListView.confirm = false;
                }
                else {
                    existingProfilesListView.confirm = true;
                }
            }

            visible: existingProfilesListView.currentSelection != ""
        }


        Button {
            id: exit

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            label: existingProfilesListView.confirm? i18n.cancel: i18n.exit

            onClicked: {
                if(existingProfilesListView.confirm) {
                    existingProfilesListView.currentSelection = ""
                    existingProfilesListView.confirm = false;
                }
                else {
                    backToSettingsMenu(false);
                }
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
        origin.x:deleteExistingProfile.width/2;
        origin.y:deleteExistingProfile.height/2
        axis.x:0; axis.y:1; axis.z:0
        angle:deleteExistingProfile.angle
    }

    states: State {
        PropertyChanges { target: deleteExistingProfile; angle: 180 }
        when: inEnterNewPasswordPage
    }

    transitions: Transition {
        NumberAnimation{ property: "angle"; duration:500 }
    }

}
