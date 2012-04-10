import QtQuick 1.0
import "components/DigitalClock"
import MirrorPlugin 1.0


Rectangle {
    id: mainScreen

    width: 1280
    height: 720

    property int number_of_grids_x: 20;
    property int number_of_grids_y: 10;

    property int sideMargin: 10
    property int notificationBarHeight: 80
    property int menuBarHeight: 100

    property alias gridCellWidth: grid.width;
    property alias gridCellHeight: grid.cellHeight;

    property alias displayArea: displayArea
    property alias widgetSelectionBar: widgetSelectionBar

    property bool showApplicationArea: false;
    property bool showMainMenuBar: false
    property bool isLocked: true;

    property string notificationBarText: ""

    property int delta_widgetSelectionBar_widgetGrid_x: widgetSelectionBar.x - (displayArea.x + grid.x)
    property int delta_widgetSelectionBar_widgetGrid_y: widgetSelectionBar.y - (displayArea.y + grid.y)

    property string language: settings.getSetting("current_language_source");
    property alias i18n: languageLoader.item

    Settings {
        id: settings;
    }

    Loader {
        id: languageLoader
        source: "./languages/"+language+".qml"
    }

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.2; color: "lightgrey" }
        GradientStop { position: 0.4; color: "white" }
        GradientStop { position: 0.6; color: "white" }
        GradientStop { position: 0.8; color: "lightgrey" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }

    DigitalClock {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

    }

    Rectangle {
        id: notificationBar
        height: mainScreen.notificationBarHeight;
        width: mainScreen.width/2
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#00000000"

        Text {
            text: notificationBarText
            font.underline: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "grey"
            font.bold: true
            font.pointSize: 18
            font.family: "Arial"
        }
    }

    MainMenuBar {
        id: mainMenuBar
        width: mainScreen.width;
        height: mainScreen.menuBarHeight;
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        visible: showMainMenuBar
    }

    Item {

        id: displayArea

        property bool showGrid: false

        anchors {
            topMargin: notificationBarHeight;
            bottomMargin: menuBarHeight

            fill: parent
        }

        GridView {
            id: grid

            visible: displayArea.showGrid;
            interactive: false
            anchors.fill: displayArea
            anchors.topMargin: sideMargin;
            anchors.bottomMargin: sideMargin;
            anchors.leftMargin: sideMargin;
            anchors.rightMargin: sideMargin
            opacity: 0.1

            // initialize the grids
            Component.onCompleted: {
                for(var index = 0; index < number_of_grids_x * number_of_grids_y; index++)
                {
                    gridModel.append({"gridId": index});
                }
            }

            model: ListModel { id: gridModel }
            delegate:  Rectangle {
                width: grid.cellWidth; height: grid.cellHeight
                border.color: "black"
                border.width: 1
                color: "#00000000"
            }

            cellWidth: grid.width/number_of_grids_x;
            cellHeight: grid.height/number_of_grids_y;
        }

        WidgetCanvas {
            id: widgetCanvas
            x: grid.x
            y: grid.y
            height: grid.height
            width: grid.width
        }
    }

    WidgetSelectionBar {
        id: widgetSelectionBar
        visible: displayArea.showGrid
    }

    ApplicationCanvas {
        id: applicationCanvas
        visible: showApplicationArea
    }


    Image {
        id: waitingIcon
        x: mouseArea.mouseX; y: mouseArea.mouseY;
        source: "icons/Waiting_background.png";
        visible: mouseArea.isUnlocking
        width: 80
        height: 80
        smooth: true

        AnimatedImage {
            id: waitingForUnlock;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "icons/Waiting.gif"
            width: 40
            height: 40
            smooth: true
        }

    }



    MouseArea {
        id: mouseArea
        anchors.fill: parent
        visible: isLocked

        property bool isUnlocking: false;

        Timer {
            id: timer
            interval: 1000 // 1 second to unlock screen
            onTriggered: {
                showMainMenuBar = true;
                isLocked = false;
                mouseArea.isUnlocking = false;
            }
        }

        onPressAndHold: {
            isUnlocking = true;
            timer.start();
        }

        onReleased: {
            if(isUnlocking) {
                timer.stop();
                isUnlocking = false;
            }
        }
    }

    Text {
        id: unlockNote
        text: "Press anywhere to display menu"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        visible: isLocked

        color: "black"
        opacity: 0.8
        font.bold: true
        font.pixelSize: 20

    }


}
