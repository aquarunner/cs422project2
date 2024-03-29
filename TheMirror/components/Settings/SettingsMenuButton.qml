import QtQuick 1.0

Rectangle {

    width: applicationLoder.width
    height: 70

    color: mouseArea.pressed ? "lightgrey" : "#00000000"
    border.color: "white"
    border.width: 3

    signal clicked

    Image {
        id: iconArea
        x: 20
        width: (icon !== "")? 50: 0
        height: 50
        anchors.verticalCenter: parent.verticalCenter
        source: (icon !== "")? "../../icons/" + icon: ""
        smooth: true
    }

    Text {
        id: titleArea
        x: iconArea.x + iconArea.width + 20
        height: 20
        text: name
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 22
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
        // goes into sub-menu (for certain category)

        if(category == "PROFILE") {
            applicationLoder.title = name;
            applicationLoder.iconName = icon;

            back.viewID = settingsSubMenuList
            settingsSubMenuList.model = manageProfilesSubMenuModel;

        }else if(category == "LANGUAGE") {
            applicationLoder.title = name;
            applicationLoder.iconName = icon;

            back.viewID = settingsRadioSelectionList
            settingsRadioSelectionList.settingOption = "current_language";
            settingsRadioSelectionList.currentSelection = settings.getSetting("current_language", "settings", "./components/Settings/");
            settingsRadioSelectionList.model = selectLanguageRadioMenuModel;

        }else if(category == "WIFI") {
            applicationLoder.title = name;
            applicationLoder.iconName = icon;

            back.viewID = settingsRadioSelectionList
            settingsRadioSelectionList.settingOption = "current_wifi";
            settingsRadioSelectionList.currentSelection = settings.getSetting("current_wifi", "settings", "./components/Settings/");
            settingsRadioSelectionList.model = selectWifiRadioMenuModel;

        }else if(category == "DATE") {
            applicationLoder.title = name;
            applicationLoder.iconName = icon;

//            back.viewID = settingsSubMenuList
//            settingsSubMenuList.model = null;

            applicationCanvas.isApplicationAreaTransparent = true;
            applicationLoder.source = "ChangeDateAndTime.qml";
            applicationCanvas.applicationAreaHeightInNumberOfCells = 8
            applicationCanvas.applicationAreaWidthInNumberOfCells = 5

//        }else if(category == "HELP") {
//            applicationLoder.title = name;
//            applicationLoder.iconName = icon;

//            back.viewID = settingsSubMenuList
//            settingsSubMenuList.model = aboutAndHelpSubMenuModel;

        } else { // invoke new page
            applicationCanvas.isApplicationAreaTransparent = true;
            applicationLoder.source = source;
        }

        settingsMenu.showSubMenu = true;

    }
}
