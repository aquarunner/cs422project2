import QtQuick 1.0
import "../../common"
import MirrorPlugin 1.0


Rectangle {

    id: settingsMenu

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    property bool showSubMenu: false;

    Settings {
        id: settings
    }

    Flipable {
        id: flipable
        anchors.fill: parent
        anchors.bottomMargin: 55

        property int angle: 0

        front: ListView {
            id: settingsMenuList

            anchors.fill: parent
            delegate: SettingsMenuButton {}
            interactive: false

            model: settingsMainMenuModel
        }

        back: Item {
            id: back
            anchors.fill: parent
            anchors.bottomMargin: 55

            property variant viewID: settingsSubMenuList

            ListView {
                id: settingsSubMenuList

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width
                x: back.viewID == settingsSubMenuList? 0: parent.width
                delegate: SettingsMenuButton {}
                interactive: false
                visible: back.viewID == settingsSubMenuList
            }

            ListView {
                id: settingsRadioSelectionList

                property string settingOption: "";
                property string currentSelection: settings.getSetting(settingOption);
                property variant sourceName;

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width
                x: back.viewID == settingsRadioSelectionList? 0: parent.width
                delegate: SettingsRadioButton {}
                // interactive: false
                clip: true
                visible: back.viewID == settingsRadioSelectionList
            }
        }

        transform: Rotation{
            origin.x:flipable.width/2;
            origin.y:flipable.height/2
            axis.x:0; axis.y:1; axis.z:0
            angle:flipable.angle
        }

        states: State {
            PropertyChanges { target: flipable; angle: 180 }
            when: showSubMenu
        }

        transitions: Transition {
            NumberAnimation{ property: "angle"; duration:600 }
        }
    }



    ListModel {
        id: settingsMainMenuModel

        ListElement { category: "PROFILE"; icon: "SettingsMenu_Profile.png"; name: "Manage profiles"; }
        ListElement { category: "LANGUAGE"; icon: "SettingsMenu_Language.png"; name: "Select language"; }
        ListElement { category: "WIFI"; icon: "SettingsMenu_Wifi.png"; name: "Wi-fi settings"; }
        ListElement { category: "DATE"; icon: "SettingsMenu_Date.png"; name: "Date and time"; }
        ListElement { category: "HELP"; icon: "SettingsMenu_Help.png"; name: "About and help"; }
    }

    ListModel {
        id: manageProfilesSubMenuModel;
        ListElement { category: "PROFILE_CREATE"; name: "Create a new profile"; icon: ""; source: ""}
        ListElement { category: "PROFILE_PASSWORD"; name: "Change password"; icon: ""; source: ""}
        ListElement { category: "PROFILE_DELETE"; name: "Delete an existing profile"; icon: ""; source: ""}
    }

    ListModel {
        id: aboutAndHelpSubMenuModel;
        ListElement { category: "HELP_ABOUT"; name: "About..."; icon: ""; source: ""}
        ListElement { category: "HELP_HELP"; name: "Help..."; icon: ""; source: ""}
    }

    ListModel {
        id: selectLanguageRadioMenuModel;
        ListElement { identification: "en"; sourceName: "English"; name: "English"; }
        ListElement { identification: "zh"; sourceName: "Chinese"; name: "中文"; }
        ListElement { identification: "jp"; sourceName: "Japanese"; name: "日本語"; }
        ListElement { identification: "es"; sourceName: "Spanish"; name: "Español"; }
        // faked
        ListElement { identification: "cs"; sourceName: "English"; name: "Czech"; }
        ListElement { identification: "nl"; sourceName: "English"; name: "Dutch"; }
        ListElement { identification: "fi"; sourceName: "English"; name: "Suomi"; }
        ListElement { identification: "fr"; sourceName: "English"; name: "Française"; }
        ListElement { identification: "de"; sourceName: "English"; name: "Deutsch"; }
        ListElement { identification: "ko"; sourceName: "English"; name: "한국어"; }
    }

    Button {
        id: okButton

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 20
        label: i18n.ok
        visible: back.viewID == settingsRadioSelectionList && showSubMenu

        onClicked: {
            if(settingsRadioSelectionList.settingOption == "current_language"
                    && settingsRadioSelectionList.sourceName !== undefined) { // set language
                settings.setSetting("current_language", settingsRadioSelectionList.currentSelection);
                settings.setSetting("current_language_source", settingsRadioSelectionList.sourceName);
                settingsRadioSelectionList.settingOption = "";
                mainScreen.language = settingsRadioSelectionList.sourceName;
            }

            backButton.clicked();
        }
    }

    Button {
        id: backButton
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
                componentLoder.title = "Settings"
                componentLoder.iconName = "Settings.png"
                showSubMenu = !showSubMenu;
            }
        }
    }
}
