import QtQuick 1.0

Item {
    id: item
    width: grid.cellWidth * widgetHeightInNumberOfCells;
    height: grid.cellHeight * widgetWidthInNumberOfCells

    visible: widgetVisible

    Rectangle {
        id: dragBar
        color: dragArea.startDrag?  Qt.darker("grey", 1.5)  : "grey"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        height: 20
        radius: 3
    }

    Loader {
        id: widgetLoader;
        height: item.height - dragBar.height
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        source: widgetSourceName
    }

    MouseArea {
        id: dragArea
        anchors.fill: dragBar

        property int original_x;    // Original position
        property int original_y;
        property int deltaX;
        property int deltaY;

        property bool startDrag: false;

        property int last_x;
        property int last_y;

        onPressAndHold: {
            if(displayArea.showGrid) {
                original_x = item.x;
                original_y = item.y;

                deltaX = mouseX - original_x;
                deltaY = mouseY - original_y;

                last_x = original_x;
                last_y = original_y;

                startDrag = true;
            }
        }
        onReleased: {
            startDrag = false;
        }

        onMousePositionChanged: {
            if(startDrag) {
                var currentX = mouseX - deltaX;
                var currentY = mouseY - deltaY;

                if(Math.sqrt((currentX-last_x)*(currentX-last_x) + (currentY-last_y)*(currentY-last_y)) > 30) {
                    item.x = currentX;
                    item.y = currentY;

                    last_x = currentX;
                    last_y = currentY;
                }
            }
        }
    }

}

