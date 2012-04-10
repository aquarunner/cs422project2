import QtQuick 1.0
import "common"

Rectangle {
    id: rectangle1

    gradient: Gradient {
        GradientStop { position: 0.0; color: "black" }
        GradientStop { position: 0.05; color: "grey" }
        GradientStop { position: 0.98;color: "grey" }
        GradientStop { position: 1.0; color: "black" }
    }

    property int numberOfButtons: 4
    property int spaceBetweenTwoButtons: 100
    property int x_base: (width - (numberOfButtons - 1) * spaceBetweenTwoButtons - homeScreenButton.width * 4) / 2;

    PicButton{
        id: homeScreenButton
        x: x_base + 0 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: i18n.applications
        pictureName: "Applications.png"
        onButtonClick: {
            mainScreen.showMainMenuBar = false;
            mainScreen.showApplicationArea = true;
            // the application you want to load in the ApplicationCanvas
            applicationCanvas.componentLoder.source = "components/ApplicationMenu/ApplicationMenu.qml"
            // is the background transparent?
            applicationCanvas.isApplicationAreaTransparent = false;
            // show border?
            applicationCanvas.showBorder = true;
            // set default height
            applicationCanvas.applicationAreaHeightInNumberOfCells = applicationCanvas.__defaultHeightInNumberOfCells
            // set default width
            applicationCanvas.applicationAreaWidthInNumberOfCells = 8

            applicationCanvas.componentLoder.title = i18n.applications
            applicationCanvas.componentLoder.iconName = "Applications.png"
        }

    }

    PicButton{
        id: arrangeWidgetsButton
        x: x_base + 1 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: i18n.arrange_widgets
        pictureName: "Arrange_Widgets.png"
        onButtonClick: {
            mainScreen.displayArea.showGrid = true;
            mainScreen.notificationBarText = i18n.drag_the_widget_to_arrange_or_click_x_to_remove
        }
    }

    PicButton{
        id: settingsButton
        x: x_base + 2 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: i18n.settings
        pictureName: "Settings.png"
        onButtonClick: {
            mainScreen.showMainMenuBar = false;
            mainScreen.showApplicationArea = true;

            applicationCanvas.componentLoder.source = "components/Settings/SettingsMenu.qml"
            applicationCanvas.isApplicationAreaTransparent = false;
            applicationCanvas.showBorder = true;
            applicationCanvas.applicationAreaHeightInNumberOfCells = applicationCanvas.__defaultHeightInNumberOfCells
            applicationCanvas.applicationAreaWidthInNumberOfCells = 8

            applicationCanvas.componentLoder.title = i18n.settings
            applicationCanvas.componentLoder.iconName = "Settings.png"
        }
    }

    PicButton{
        id: exitButton
        x: x_base + 2.8 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: i18n.exit
        pictureName: "Exit.png"
        onButtonClick: {
            mainScreen.showMainMenuBar = false;
            mainScreen.isLocked = true;
        }
    }
}
