import QtQuick 1.0
import "../Camera"
import "../../common"

Flipable {

    id: createNewProfile

    property bool inEnterPinCodePage: false
    property int angle: 0

    // color: "#00000000"

    front: Camera {

        id: camera

        showCalleryButton: false
        animated: false

        Component.onCompleted: {
            camera.exitButton.visible = false
        }

        Text {
            text: i18n.please_face_the_mirror_then_take_two_shots
            y: 10
            anchors.horizontalCenter: parent.horizontalCenter
            // font.bold: true
            font.pixelSize: 18
            visible: !camera.flashing
        }

        //        Text {
        //            text: "Two shots are required: "
        //            x: 10
        //            y: 250
        //            // font.bold: true
        //            font.pixelSize: 16
        //            visible: !camera.flashing
        //        }

        Text {
            text: " 1st"
            x: 10
            y: 280
            font.bold: true
            font.pixelSize: 20
            visible: !camera.flashing
        }

        Rectangle {

            x: 10
            y: 300

            width: 50
            height: 50

            Image {
                anchors.fill: parent
                fillMode: Image.Stretch
                smooth: true
                source: "icons/shot.png"
                visible: camera.numberOfShoot >= 1
            }

            border.color: "grey"
            border.width: 3
            visible: !camera.flashing
        }

        Text {
            text: " 2nd"
            x: 10
            y: 380
            font.bold: true
            font.pixelSize: 20
            visible: !camera.flashing
        }

        Rectangle {

            x: 10
            y: 400

            width: 50
            height: 50

            Image {
                anchors.fill: parent
                fillMode: Image.Stretch
                smooth: true
                source: "icons/shot.png"
                visible: camera.numberOfShoot >= 2
            }

            border.color: "grey"
            border.width: 3
            visible: !camera.flashing
        }

        Button {
            id: next

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            label: i18n.next
            visible: camera.numberOfShoot >= 2

            onClicked: {
                inEnterPinCodePage = true
                componentLoder.title = i18n.enter_a_pin_code
                componentLoder.iconName = "../components/Settings/icons/pin.png"
                applicationCanvas.isApplicationAreaTransparent = false;
            }
        }

    }

    back:  Rectangle {
        id: enterPinCode
        width: createNewProfile.width
        height: createNewProfile.height
        color: "#00000000"

        Text {
            text: "Please enter a 4 digital pin code for your profile. "
            anchors.horizontalCenter: parent.horizontalCenter
            y: 150
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }

        Text {
            text: "You may use this pin code to unlock the mirror while the mirror can't recognize your face."
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 20
            y: 200
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 18
            font.family: "Arial"
            color: "#444444"
        }

        Text {
            text: "Pin code: "
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: 350
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 20
            font.family: "Arial"
            color: "#444444"
        }

        Text {
            text: "Confirm pin code: "
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: 400
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: 20
            font.family: "Arial"
            color: "#444444"
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 150
            y: 350
            width: 100
            height: 30
            color: "white"
            border.color: "#444444"

            TextInput {
                anchors.fill: parent
                echoMode : TextInput.Password
                font.pixelSize: 20
                maximumLength: 4
                cursorVisible: true
            }
        }



        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 150
            y: 400
            width: 100
            height: 30
            color: "white"
            border.color: "#444444"

            TextInput {
                anchors.fill: parent
                echoMode : TextInput.Password
                font.pixelSize: 20
                maximumLength: 4
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
                applicationLoder.title = i18n.manage_profiles;
                applicationLoder.iconName = "SettingsMenu_Profile.png";

                applicationCanvas.componentLoder.source = "SettingsMenu.qml"

                applicationCanvas.componentLoder.item.back.viewID =  applicationCanvas.componentLoder.item.settingsSubMenuList
                applicationCanvas.componentLoder.item.settingsSubMenuList.model =  applicationCanvas.componentLoder.item.manageProfilesSubMenuModel;
                // applicationCanvas.componentLoder.item.showSubMenu = true;
            }
        }

    }


    transform: Rotation{
        origin.x:createNewProfile.width/2;
        origin.y:createNewProfile.height/2
        axis.x:0; axis.y:1; axis.z:0
        angle:createNewProfile.angle
    }

    states: State {
        PropertyChanges { target: createNewProfile; angle: 180 }
        when: inEnterPinCodePage
    }

    transitions: Transition {
        NumberAnimation{ property: "angle"; duration:500 }
    }

}
