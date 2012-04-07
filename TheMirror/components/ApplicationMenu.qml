import QtQuick 1.0
import "../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55


    ListView {

        id: applicationMenuList

        anchors.fill: parent
        delegate: ApplicationMenuButton {}
        model: applicationMenuModel
        interactive: false

    }

    ListModel {

        id: applicationMenuModel

        ListElement {
            category: "DAILY"; icon: "../icons/ApplicationMenu_Daily.png"; title: "Daily Information";
            description: "News, Weather, Calender and other information feeds...";
        }
        ListElement {
            category: "MULTIMEDIA"; icon: "../icons/ApplicationMenu_Multimedia.png"; title: "Multimedia";
            description: "Radio, Music player, TV/Online streaming, Camera...";
        }
        ListElement {
            category: "HEALTH"; icon: "../icons/ApplicationMenu_Health.png"; title: "Health Information";
            description: "Height, Weight, body temperture, diet information...";
        }
        ListElement {
            category: "DRESSING"; icon: "../icons/ApplicationMenu_Dressing.png"; title: "Dressing and Makeup";
            description: "Dress fitting, makeup...";
        }
        ListElement {
            category: "MISC"; icon: "../icons/ApplicationMenu_Misc.png"; title: "Misc.";
            description: "Other applications";
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: "Back"

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
