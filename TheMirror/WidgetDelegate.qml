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

        property int currentIndex;
        property int originalIndex;

        onPressAndHold: {

            console.log("item.x: " + item.x + " item.y: " + item.y);
            console.log("mouseX: " + mouseX + " mouseY: " + mouseY);
            console.log("index: " + widgetCanvas.indexAt(item.x, item.y));

            original_x = item.x;
            original_y = item.y;
            originalIndex = widgetCanvas.indexAt(original_x, original_y)

            if(displayArea.showGrid) {

                startDrag = true;
            }
        }
        onReleased: {
            startDrag = false;
        }

        onMousePositionChanged: {

            original_x = item.x;
            original_y = item.y;

            console.log("mouseX: " + mouseX + " mouseY: " + mouseY);
            currentIndex = widgetCanvas.indexAt(original_x + mouseX, original_y + mouseY);

            console.log("currentIndex: " + currentIndex +" originalIndex:" + originalIndex);
            if(startDrag && currentIndex != originalIndex) {

                original_x = (currentIndex % number_of_grids_x) * cellWidth;
                original_y = (currentIndex - original_x) / number_of_grids_x * cellHeight;
                console.log("original_x: " + original_x + " original_y: " + original_y);

                gridModel.move(originalIndex, originalIndex = currentIndex, 1);

            }
        }
    }

}

