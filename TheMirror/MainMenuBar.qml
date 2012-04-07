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
        label: "Applications"
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

            applicationCanvas.componentLoder.title = "Applications"
            applicationCanvas.componentLoder.iconName = "Applications.png"
        }

    }

    PicButton{
        id: arrangeWidgetsButton
        x: x_base + 1 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: "Arrange Widgets"
        pictureName: "Arrange_Widgets.png"
        onButtonClick: {
            mainScreen.displayArea.showGrid = true;
        }
    }

    Button {
        id: arrangeWidgetsDoneButton;
        anchors.verticalCenterOffset: 0
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        label: "Done";
        visible: mainScreen.displayArea.showGrid
        onClicked: {
            mainScreen.displayArea.showGrid = false;
        }
    }

    PicButton{
        id: settingsButton
        x: x_base + 2 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: "Settings"
        pictureName: "Settings.png"
    }

    PicButton{
        id: exitButton
        x: x_base + 2.8 * (spaceBetweenTwoButtons + homeScreenButton.width)
        label: "Exit"
        pictureName: "Exit.png"
        onButtonClick: {
            mainScreen.showMainMenuBar = false;
            mainScreen.isLocked = true;
        }
    }
}
