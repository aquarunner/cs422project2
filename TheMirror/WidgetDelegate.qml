import QtQuick 1.0
// import MirrorPlugin 1.0

Rectangle {
    id: item
    width: grid.cellWidth * widgetWidthInNumberOfCells;
    height: grid.cellHeight * widgetHeightInNumberOfCells

    visible: widgetVisible != null? widgetVisible: false
    // color: available? "#00000000" :"black"
    color: "#00000000"


    Loader {
        id: widgetLoader;
        height: item.height /*- dragBar.height*/
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        source: widgetSourceName != null? widgetSourceName: "EmptyWidget.qml"
        scale: dragArea.startDrag? 1.2 : 1
    }

    //    Rectangle {
    //        id: dragBar
    //        color: dragArea.startDrag?  Qt.darker("grey", 1.5)  : "grey"
    //        anchors.right: parent.right
    //        anchors.rightMargin: 0
    //        anchors.left: parent.left
    //        anchors.leftMargin: 0
    //        anchors.top: parent.top
    //        anchors.topMargin: 0
    //        height: type=="SHORTCUT"? 0: 20
    //        radius: 3
    //        visible: mainScreen.displayArea.showGrid
    //    }

    function makeAreaAvailable(widgetIndex) {
        for(var i = 0; i < gridModel.get(widgetIndex).widgetHeightInNumberOfCells; i++) {
            for(var j = 0; j < gridModel.get(widgetIndex).widgetWidthInNumberOfCells; j++) {
                var idx = widgetIndex + i*number_of_grids_x + j;
                gridModel.get(idx).available = true;
                if(widgetIndex != idx) {
                    gridModel.get(idx).type=""
                }
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

//    Settings {
//        id: settings
//    }

    MouseArea {
        id: dragArea
        anchors.fill: widgetLoader /*type=="SHORTCUT"? widgetLoader: dragBar*/

        property int original_x;    // Original position
        property int original_y;

        property bool startDrag: false;

        property int currentIndex;
        property int originalIndex;
        visible: displayArea.showGrid

//        onClicked: {
//            if(type=="SHORTCUT" && !startDrag) {
//                mainScreen.showMainMenuBar = false;
//                mainScreen.showApplicationArea = true;

//                applicationCanvas.isApplicationAreaTransparent = (settings.getSetting(widgetId + "__transparent", "shortcut_to_application") === 'true');
//                applicationCanvas.showBorder = (settings.getSetting(widgetId + "__border", "shortcut_to_application") === 'true');
//                applicationCanvas.applicationAreaHeightInNumberOfCells = settings.getSetting(widgetId + "__height", "shortcut_to_application")*1;
//                applicationCanvas.applicationAreaWidthInNumberOfCells = settings.getSetting(widgetId + "__width", "shortcut_to_application")*1;

//                applicationCanvas.componentLoder.title = widgetId;
//                applicationCanvas.componentLoder.iconName = settings.getSetting(widgetId + "__icon", "shortcut_to_application");
//                applicationCanvas.componentLoder.source = settings.getSetting(widgetId + "__source", "shortcut_to_application");
//            }
//        }

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
                widgetId: modelElement.gridId,
                available: modelElement.available,
                widgetSourceName: modelElement.widgetSourceName,
                widgetVisible: modelElement.widgetVisible,
                widgetHeightInNumberOfCells: modelElement.widgetHeightInNumberOfCells,
                widgetWidthInNumberOfCells: modelElement.widgetWidthInNumberOfCells,
                gridModel: modelElement.gridModel,
                type: modelElement.type
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
                updateWidgetInfoIntoFile(currentIndex);

                originalIndex = currentIndex;
            }
        }

        function updateWidgetInfoIntoFile(currentIndex)
        {
            if(type == "WIDGET") {
                widgetsSettings.setSetting(widgetId+"__index", ""+currentIndex, "widgets");
                widgetsSettings.setSetting(widgetId+"__onScreen", ""+true, "widgets");
            }
            else if (type == "SHORTCUT") {

                // console.log(widgetId+"__index")
                widgetsSettings.setSetting(widgetId+"__index", ""+currentIndex, "shortcuts");
                widgetsSettings.setSetting(widgetId+"__onScreen", ""+true, "shortcuts");
            }
        }
    }

    function deleteWidget(currentIndex) {
        if(type == "WIDGET") {
            widgetsSettings.setSetting(widgetId+"__index", "0", "widgets");
            widgetsSettings.setSetting(widgetId+"__onScreen", "false", "widgets");
        }
        else if (type == "SHORTCUT") {
            widgetsSettings.setSetting(widgetId+"__index", "0", "shortcuts");
            widgetsSettings.setSetting(widgetId+"__onScreen", "false", "shortcuts");
        }

        makeAreaAvailable(currentIndex);
        var currentElement = gridModel.get(currentIndex);
        var gridId = currentElement.gridId;
        gridModel.remove(currentIndex);
        gridModel.insert(currentIndex, {
                             widgetId: gridId,
                             available: true,
                             widgetSourceName: "EmptyWidget.qml",
                             widgetVisible: false,
                             widgetHeightInNumberOfCells: 1,
                             widgetWidthInNumberOfCells: 1,
                             gridModel: gridModel,
                             type: ""
                         });
    }

    Image {
        id: deleteIcon
        source: "icons/Delete.png"
        anchors.right: parent.right
        anchors.rightMargin: -10
        anchors.top: parent.top
        anchors.topMargin: -10
        width: 25
        height: 25
        smooth: true
        visible: displayArea.showGrid && !mainScreen.widgetSelectionBar.expanded

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var currentIndex = widgetCanvas.indexAt(item.x, item.y);
               //  console.log(currentIndex);
                deleteWidget(currentIndex);
            }
        }
    }

}

