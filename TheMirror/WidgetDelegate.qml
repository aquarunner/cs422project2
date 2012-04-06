import QtQuick 1.0

Rectangle {
    id: item
    width: grid.cellWidth * widgetWidthInNumberOfCells;
    height: grid.cellHeight * widgetHeightInNumberOfCells

    visible: widgetVisible != null? widgetVisible: false
    // color: available? "#00000000" :"black"

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

        source: widgetSourceName != null? widgetSourceName: "EmptyWidget.qml"
    }

    function makeAreaAvailable(widgetIndex) {
        for(var i = 0; i < gridModel.get(widgetIndex).widgetHeightInNumberOfCells; i++) {
            for(var j = 0; j < gridModel.get(widgetIndex).widgetWidthInNumberOfCells; j++) {
                var idx = widgetIndex + i*number_of_grids_x + j;
                gridModel.get(idx).available = true;
            }
        }
    }

    function makeAreaUnavailable(widgetIndex) {
        for(var i = 0; i < gridModel.get(widgetIndex).widgetHeightInNumberOfCells; i++) {
            for(var j = 0; j < gridModel.get(widgetIndex).widgetWidthInNumberOfCells; j++) {
                var idx = widgetIndex + i*number_of_grids_x + j;
                gridModel.get(idx).available = false;
                // console.log("UnA: " + idx);
            }
        }

        // console.log("?"+available);
    }

    function printAllCellsStates() {
        console.log("================================================");
        var output = "";
        var padding = "";
        for(var i = 0; i < gridModel.count; i++) {
            if(i <= 9) {
                padding="  "
            } else if (i <= 99) {
                padding = " "
            } else {
                padding = "";
            }

            output += ("[" + padding + i + "]"+(gridModel.get(i).available?" ":"*") + " ");
            if(i % number_of_grids_x === number_of_grids_x-1) {
                console.log(output);
                output = "";
            }
        }
        console.log("================================================\n");
    }

    MouseArea {
        id: dragArea
        anchors.fill: dragBar

        property int original_x;    // Original position
        property int original_y;

        property bool startDrag: false;

        property int currentIndex;
        property int originalIndex;

        onPressAndHold: {
            if(displayArea.showGrid) {
                printAllCellsStates();

                original_x = item.x;
                original_y = item.y;

                originalIndex = widgetCanvas.indexAt(original_x, original_y)

                makeAreaAvailable(originalIndex);
                startDrag = true;

                printAllCellsStates();
            }
        }
        onReleased: {
            startDrag = false;
            // makeAreaUnavailable(originalIndex);
            printAllCellsStates();
        }

        function withinWidgetCanvas(currentIndex) {
            var index_x = currentIndex % number_of_grids_x;
            var index_y = Math.floor(currentIndex / number_of_grids_x);

            return (index_x + widgetWidthInNumberOfCells <= number_of_grids_x) && (index_y + widgetHeightInNumberOfCells <= number_of_grids_y)
        }

        onMousePositionChanged: {

            original_x = item.x;
            original_y = item.y;

            currentIndex = widgetCanvas.indexAt(original_x + mouseX, original_y + mouseY);

            if(startDrag && currentIndex != originalIndex && originalIndex != -1 && currentIndex != -1
                    && withinWidgetCanvas(currentIndex)) {

                makeAreaAvailable(originalIndex);

                original_x = (currentIndex % number_of_grids_x) * cellWidth;
                original_y = (currentIndex - original_x) / number_of_grids_x * cellHeight;

                if (currentIndex > originalIndex){
                    var currentElement = gridModel.get(currentIndex);
                    gridModel.remove(currentIndex);
                    gridModel.move(originalIndex, currentIndex-1, 1);
                    gridModel.insert(originalIndex, currentElement);
                } else {
                    gridModel.move(originalIndex, currentIndex, 1);
                    var originalElement = gridModel.get(currentIndex+1);
                    gridModel.remove(currentIndex+1);
                    gridModel.insert(originalIndex, originalElement);
                }

                makeAreaUnavailable(currentIndex);
                originalIndex = currentIndex;
            }
        }
    }

}

