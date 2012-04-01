import QtQuick 1.0
import "common"

Rectangle {
    id: applicationCanvas

    height: 720
    width: 1280
    anchors.fill: parent
    color: "#00000000"

    property int __defaultHeightInNumberOfCells: 10
    property int __defaultWidthInNumberOfCells: 12

    property int applicationAreaHeightInNumberOfCells: __defaultHeightInNumberOfCells
    property int applicationAreaWidthInNumberOfCells: __defaultWidthInNumberOfCells

    property int __applicationAreaHeight: grid.cellHeight * applicationAreaHeightInNumberOfCells
    property int __applicationAreaWidth: grid.cellWidth * applicationAreaWidthInNumberOfCells
    property bool isApplicationAreaTransparent: false;
    property bool showBorder: true;

    property alias componentLoder: componentLoder


    Rectangle {
        id: top
        x: applicationArea.x
        width: applicationArea.width + applicationArea.border.width
        height: applicationArea.y
        anchors.top: parent.top
        anchors.topMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: bottom
        x: applicationArea.x
        width: applicationArea.width
        height: applicationCanvas.height - applicationArea.y - applicationArea.height + applicationArea.border.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: left
        width: applicationArea.x + applicationArea.border.width
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: right
        width: applicationCanvas.width - applicationArea.x - applicationArea.width + applicationArea.border.width
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    //    Rectangle {
    //        id: center
    //        x: applicationCanvas.x
    //        y: applicationCanvas.y
    //        width: applicationCanvas.width
    //        height: applicationCanvas.height

    //        color: isApplicationAreaTransparent? "#00000000" : "darkgrey"
    //        Image {
    //            source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3
    //            visible: !isApplicationAreaTransparent
    //        }
    //        opacity: 0.6
    //    }


    Rectangle {
        id: applicationArea

        width: __applicationAreaWidth + border.width * 2
        height: __applicationAreaHeight + border.width * 2
        radius: 8

        x: (applicationCanvas.width - applicationArea.width) / 2
        y: (applicationCanvas.height - applicationArea.height) / 2

        border.color: showBorder? "white" : "#00000000"
        border.width: showBorder? 5 : 0

        color: isApplicationAreaTransparent? "#00000000" : "darkgrey"
        Image {
            source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3
            visible: !isApplicationAreaTransparent
        }
        opacity: 0.6
    }

    Rectangle {
        id: titleArea
        x: applicationArea.x + applicationArea.border.width
        y: applicationArea.y + applicationArea.border.width
        width: applicationArea.width - applicationArea.border.width * 2
        height: button.height

        PicButton2 {
            id: button

            anchors.horizontalCenter: parent.horizontalCenter
            label: componentLoder.title;
            pictureName: componentLoder.iconName;
            buttonColor: "#00000000"
        }

        color: "grey"
        radius: 3
    }

    Loader {
        id: componentLoder;
        x: applicationArea.x + applicationArea.border.width
        y: applicationArea.y + applicationArea.border.width
        width: __applicationAreaWidth
        height: __applicationAreaHeight

        property variant applicationColor: "#00000000" //transparent
        property variant applicationLoder: componentLoder;

        property string title: "Title"
        property string iconName: "Applications.png"
    }

    MouseArea {
        id: dragBarMouseArea
        anchors.fill: titleArea

        property int original_x;    // Original position
        property int original_y;
        property int deltaX;
        property int deltaY;

        property bool startDrag: false;

        property int last_x;
        property int last_y;

        onPressAndHold: {

            original_x = applicationArea.x;
            original_y = applicationArea.y;

            deltaX = mouseX - original_x;
            deltaY = mouseY - original_y;

            last_x = original_x;
            last_y = original_y;

            startDrag = true;

        }
        onReleased: {
            startDrag = false;
        }

        onMousePositionChanged: {
            if(startDrag) {
                var currentX = mouseX - deltaX;
                var currentY = mouseY - deltaY;

                if(Math.sqrt((currentX-last_x)*(currentX-last_x) + (currentY-last_y)*(currentY-last_y)) > 30) {
                    applicationArea.x = currentX;
                    applicationArea.y = currentY;

                    last_x = currentX;
                    last_y = currentY;
                }
            }
        }
    }

}
