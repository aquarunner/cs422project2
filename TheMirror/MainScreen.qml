import QtQuick 1.0
import "components/DigitalClock"


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

    property bool showApplicationArea: false;
    property bool showMainMenuBar: false
    property bool isLocked: true;

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

    ApplicationCanvas {
        id: applicationCanvas
        visible: showApplicationArea
    }


    AnimatedImage {
        id: waitingForUnlock;
        x: mouseArea.mouseX; y: mouseArea.mouseY;
        source: "icons/Waiting.gif"
        visible: mouseArea.isUnlocking
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        visible: isLocked

        property bool isUnlocking: false;

        onPressAndHold: {
            isUnlocking = true;
        }

        onReleased: {
            if(isUnlocking) {
                showMainMenuBar = true;
                isLocked = false;
            }
            isUnlocking = false;
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
