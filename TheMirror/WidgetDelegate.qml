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
            if(gridModel.get(i).gridId <= 9) {
                padding="  "
            } else if (gridModel.get(i).gridId<=99) {
                padding = " "
            } else {
                padding = "";
            }

            output += ("["+padding+gridModel.get(i).gridId+"]"+(gridModel.get(i).widgetSourceName == "EmptyWidget.qml"?" ":"*") + " ");
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

            //printAllCellsStates();

            original_x = item.x;
            original_y = item.y;

            originalIndex = widgetCanvas.indexAt(original_x, original_y)

            if(displayArea.showGrid) {
                // makeAreaAvailable(originalIndex);
                startDrag = true;
            }
        }
        onReleased: {
            startDrag = false;
            // makeAreaUnavailable(originalIndex);
            // printAllCellsStates();
        }

        onMousePositionChanged: {

            original_x = item.x;
            original_y = item.y;

            currentIndex = widgetCanvas.indexAt(original_x + mouseX, original_y + mouseY);

            if(startDrag && currentIndex != originalIndex && originalIndex != -1 && currentIndex != -1) {

                original_x = (currentIndex % number_of_grids_x) * cellWidth;
                original_y = (currentIndex - original_x) / number_of_grids_x * cellHeight;

                if (currentIndex > originalIndex){
                    var currentElement = gridModel.get(currentIndex);
                    gridModel.remove(currentIndex);
                    gridModel.move(originalIndex, currentIndex -1, 1);
                    gridModel.insert(originalIndex, currentElement);
                } else {
                    gridModel.move(originalIndex, currentIndex, 1);
                    var currentNextElement = gridModel.get(currentIndex+1);
                    gridModel.remove(currentIndex+1);
                    gridModel.insert(originalIndex, currentNextElement);
                }

                originalIndex = currentIndex;
            }
        }


        //        onMousePositionChanged: {

        //            original_x = item.x;
        //            original_y = item.y;

        //            currentIndex = widgetCanvas.indexAt(original_x + mouseX, original_y + mouseY);

        //            if(startDrag && currentIndex != originalIndex && currentIndex != -1 && gridModel.get(currentIndex).widgetSourceName == "EmptyWidget.qml") {

        //                original_x = (currentIndex % number_of_grids_x) * cellWidth;
        //                original_y = (currentIndex - original_x) / number_of_grids_x * cellHeight;

        //                console.log("~~~~~~~~~~~~~~~~~");
        //                console.log("original[" + originalIndex + "], current[" + currentIndex + "]");
        //                console.log("original[" + originalIndex + "]: "+ gridModel.get(originalIndex).gridId + ", current[" + currentIndex + "]: " + gridModel.get(currentIndex).gridId);
        //                printAllCellsStates();

        //                if(originalIndex < currentIndex) {
        //                    gridModel.move(originalIndex, currentIndex, 1);

        //                    console.log("original[" + originalIndex + "]: "+ gridModel.get(originalIndex).gridId + ", current[" + currentIndex + "]: " + gridModel.get(currentIndex).gridId);
        //                    printAllCellsStates();

        //                    gridModel.move(originalIndex, originalIndex+1, currentIndex-originalIndex-1);
        //                }
        //                else {
        //                    gridModel.move(originalIndex, currentIndex, 1);
        //                    console.log("original[" + originalIndex + "]: "+ gridModel.get(originalIndex).gridId + ", current[" + currentIndex + "]: " + gridModel.get(currentIndex).gridId);
        //                    printAllCellsStates();
        //                    gridModel.move(currentIndex+1, originalIndex, 1);
        //                }

        //                console.log("original[" + originalIndex + "]: "+ gridModel.get(originalIndex).gridId + ", current[" + currentIndex + "]: " + gridModel.get(currentIndex).gridId);
        //                printAllCellsStates();
        //                console.log("~~~~~~~~~~~~~~~~~");

        //                originalIndex = currentIndex;
        //            }
        //        }
    }

}

