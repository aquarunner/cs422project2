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
            } else if (gridModel.get(i).gridId <= 99) {
                padding = " "
            } else {
                padding = "";
            }

            output += ("[" + padding + gridModel.get(i).gridId + "]"+(gridModel.get(i).available?" ":"*") + " ");
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
                // printAllCellsStates();

                original_x = item.x;
                original_y = item.y;

                originalIndex = widgetCanvas.indexAt(original_x, original_y)

                makeAreaAvailable(originalIndex);
                startDrag = true;

                // printAllCellsStates();
            }
        }
        onReleased: {
            startDrag = false;
            // makeAreaUnavailable(originalIndex); // no necessary
            // printAllCellsStates();
        }

        function withinWidgetCanvas(currentIndex) {
            var index_x = currentIndex % number_of_grids_x;
            var index_y = Math.floor(currentIndex / number_of_grids_x);

            return (index_x + widgetWidthInNumberOfCells <= number_of_grids_x) && (index_y + widgetHeightInNumberOfCells <= number_of_grids_y)
        }

        function printObjectInfo(modelObject) {
            for(var prop in modelObject) {
                console.debug("name: " + prop + "; value: " + modelObject[prop])
            }
        }

        function clone(modelElement) {
            return {
                gridId: modelElement.gridId,
                available: modelElement.available,
                widgetSourceName: modelElement.widgetSourceName,
                widgetVisible: modelElement.widgetVisible,
                widgetHeightInNumberOfCells: modelElement.widgetHeightInNumberOfCells,
                widgetWidthInNumberOfCells: modelElement.widgetWidthInNumberOfCells,
                gridModel: modelElement.gridModel
            }
        }

        function isAvailable(currentIndex) {
            return (gridModel.get(currentIndex).available
                    && gridModel.get(currentIndex + widgetWidthInNumberOfCells-1).available
                    && gridModel.get(currentIndex + (widgetWidthInNumberOfCells-1) * number_of_grids_x).available
                    && gridModel.get(currentIndex + widgetWidthInNumberOfCells-1 + (widgetWidthInNumberOfCells-1) * number_of_grids_x).available)
        }

        onMousePositionChanged: {

            original_x = item.x;
            original_y = item.y;

            currentIndex = widgetCanvas.indexAt(original_x + mouseX, original_y + mouseY);

            if(startDrag && currentIndex != originalIndex && originalIndex != -1 && currentIndex != -1
                    && withinWidgetCanvas(currentIndex) /*&& isAvailable(currentIndex)*/) {

                makeAreaAvailable(originalIndex);
                // console.log("originalIndex: " + originalIndex);
                // printAllCellsStates();

                original_x = (currentIndex % number_of_grids_x) * cellWidth;
                original_y = (currentIndex - original_x) / number_of_grids_x * cellHeight;

                if (currentIndex > originalIndex){
                    var currentElement = gridModel.get(currentIndex);
                    currentElement = clone(currentElement);
                    // console.debug(currentElement)
                    // printObjectInfo(currentElement)
                    gridModel.remove(currentIndex);
                    gridModel.move(originalIndex, currentIndex-1, 1);
                    // console.debug(currentElement)
                    gridModel.insert(originalIndex, currentElement);
                } else {
                    gridModel.move(originalIndex, currentIndex, 1);
                    var originalElement = gridModel.get(currentIndex+1);
                    originalElement = clone(originalElement);
                    gridModel.remove(currentIndex+1);
                    gridModel.insert(originalIndex, originalElement);
                }

                // console.log("before makeAreaUnavailable: " + currentIndex);
                // printAllCellsStates();
                makeAreaUnavailable(currentIndex);
                // console.log("currentIndex: " + currentIndex);
                // printAllCellsStates();
                originalIndex = currentIndex;
            }
        }
    }

}

