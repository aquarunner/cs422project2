import QtQuick 1.0
import "../../common"

Rectangle {

    id: applicationMenu

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property bool showSubMenu: false;

    Flipable {
        id: flipable
        anchors.fill: parent

        property int angle: 0
        // property bool flipped: false

        front: ListView {

            id: applicationMenuList

            anchors.fill: parent
            delegate: ApplicationMenuButton {}
            model: applicationMainMenuModel
            interactive: false
            // visible: !showSubMenu;
        }

        back: GridView {
            id: applicationSubMenuGrid
            anchors.fill: parent
            delegate: ApplicationSubMenuButton { id: subMenuButton}
            cellWidth: applicationLoder.width/2;
            // model: applicationSubMenuModel
            // visible: showSubMenu;
            interactive: false
        }

        transform: Rotation{
            origin.x:flipable.width/2;
            origin.y:flipable.height/2
            axis.x:0; axis.y:1; axis.z:0
            angle:flipable.angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: flipable; angle: 180 }
            when: showSubMenu
        }

        transitions: Transition {
            NumberAnimation{ property: "angle"; duration:600 }
        }
    }



    ListModel {

        id: applicationMainMenuModel

        Component.onCompleted: {
            applicationMainMenuModel.append({"category": "DAILY", "icon": "../../icons/ApplicationMenu_Daily.png",
                                                "name": i18n.daily_information,
                                                "description": i18n.news_weather_calender_and_other_information_feeds});
            applicationMainMenuModel.append({"category": "MULTIMEDIA", "icon": "../../icons/ApplicationMenu_Multimedia.png",
                                                "name": i18n.multimedia,
                                                "description": i18n.radio_music_player_tv_online_streaming_camera});
            applicationMainMenuModel.append({"category": "HEALTH", "icon": "../../icons/ApplicationMenu_Health.png",
                                                "name": i18n.health_information,
                                                "description": i18n.height_weight_body_temperture_diet_information});
            applicationMainMenuModel.append({"category": "DRESSING", "icon": "../../icons/ApplicationMenu_Dressing.png",
                                                "name": i18n.dressing_and_makeup,
                                                "description": i18n.dress_fitting_makeup});
            applicationMainMenuModel.append({"category": "MISC", "icon": "../../icons/ApplicationMenu_Misc.png",
                                                "name": i18n.misc,
                                                "description": i18n.other_applications});
        }

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
        label: i18n.back

        onClicked: {
            if(!showSubMenu) {
                mainScreen.showMainMenuBar = true;
                mainScreen.showApplicationArea = false;
            } else {
                componentLoder.title = i18n.applications
                componentLoder.iconName = "Applications.png"
                showSubMenu = !showSubMenu;
            }
        }
    }
}
