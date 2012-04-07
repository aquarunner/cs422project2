import QtQuick 1.0
import "../../common"

Rectangle {

    id: applicationMenu

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property bool showSubMenu: false;

    ListView {

        id: applicationMenuList

        anchors.fill: parent
        delegate: ApplicationMenuButton {}
        model: applicationMainMenuModel
        interactive: false
        visible: !showSubMenu;
    }

    ListModel {

        id: applicationMainMenuModel

        ListElement {
            category: "DAILY"; icon: "../../icons/ApplicationMenu_Daily.png"; name: "Daily Information";
            description: "News, Weather, Calender and other information feeds...";
        }
        ListElement {
            category: "MULTIMEDIA"; icon: "../../icons/ApplicationMenu_Multimedia.png"; name: "Multimedia";
            description: "Radio, Music player, TV/Online streaming, Camera...";
        }
        ListElement {
            category: "HEALTH"; icon: "../../icons/ApplicationMenu_Health.png"; name: "Health Information";
            description: "Height, Weight, body temperture, diet information...";
        }
        ListElement {
            category: "DRESSING"; icon: "../../icons/ApplicationMenu_Dressing.png"; name: "Dressing and Makeup";
            description: "Dress fitting, makeup...";
        }
        ListElement {
            category: "MISC"; icon: "../../icons/ApplicationMenu_Misc.png"; name: "Misc.";
            description: "Other applications";
        }
    }

    GridView {
        id: applicationSubMenuGrid
        anchors.fill: parent
        delegate: ApplicationSubMenuButton { id: subMenuButton}
        cellWidth: applicationLoder.width/2;
        // model: applicationSubMenuModel
        visible: showSubMenu;
        interactive: false
    }

    ApplicationModel { id: applicationDailyModel; query: "/applications/application[category=\"DAILY\"]" }
    ApplicationModel { id: applicationMultimediaModel; query: "/applications/application[category=\"MULTIMEDIA\"]" }
    ApplicationModel { id: applicationHealthModel; query: "/applications/application[category=\"HEALTH\"]" }
    ApplicationModel { id: applicationDressingModel; query: "/applications/application[category=\"DRESSING\"]" }
    ApplicationModel { id: applicationMiscModel; query: "/applications/application[category=\"MISC\"]" }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: "Back"

        onClicked: {
            if(!showSubMenu) {
                mainScreen.showMainMenuBar = true;
                mainScreen.showApplicationArea = false;
            } else {
                componentLoder.title = "Applications"
                componentLoder.iconName = "Applications.png"
                showSubMenu = !showSubMenu;
            }
        }
    }
}
