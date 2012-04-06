import QtQuick 1.0
import MirrorPlugin 1.0

GridView {

    id: widgetCanvas
    property alias gridModel: gridModel

    Settings {
        id: widgetsSettings
    }

    Component.onCompleted: {
        for(var index = 0; index < number_of_grids_x * number_of_grids_y; index++)
        {
            gridModel.append({"gridId": index,
                                 "widgetVisible": false,
                                 "widgetHeightInNumberOfCells": 5,
                                 "widgetWidthInNumberOfCells": 3,
                                 "widgetSourceName" : "EmptyWidget.qml",
                                 "available" : true,
                                 "gridModel" : gridModel
                             });
        }

        loadWidgets();

        /////////////////////////////////////////////
        //        var widgetIndex = 0;
        //        gridModel.get(widgetIndex).widgetVisible = true;
        //        gridModel.get(widgetIndex).widgetSourceName = "demo/TestWidget.qml"
        //        for(var i = 0; i < gridModel.get(widgetIndex).widgetHeightInNumberOfCells; i++) {
        //            for(var j = 0; j < gridModel.get(widgetIndex).widgetWidthInNumberOfCells; j++) {
        //                var idx = widgetIndex + i*number_of_grids_x + j;
        //                // console.log(idx + " unavailable");
        //                gridModel.get(idx).available = false;
        //            }
        //        }
        // console.log("---------\n");

        /////////////////////////////////////////////
        //        widgetIndex = 65;
        //        gridModel.get(widgetIndex).widgetVisible = true;
        //        gridModel.get(widgetIndex).widgetSourceName = "demo/TestWidget2.qml"
        //        gridModel.get(widgetIndex).widgetHeightInNumberOfCells = 3
        //        gridModel.get(widgetIndex).widgetWidthInNumberOfCells = 5
        //        for(i = 0; i < gridModel.get(widgetIndex).widgetHeightInNumberOfCells; i++) {
        //            for(j = 0; j < gridModel.get(widgetIndex).widgetWidthInNumberOfCells; j++) {
        //                idx = widgetIndex + i*number_of_grids_x + j;
        //                // console.log(idx + " unavailable");
        //                gridModel.get(idx).available = false;
        //            }
        //        }
        // console.log("---------\n");

        /////////////////////////////////////////////
    }

    function loadWidgets() {

        var str = widgetsSettings.getSetting("widget_ids", "widgets");
        var widgetIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < widgetIds.length; i++) {
            id = widgetIds[i].replace(/^\s+|\s+$/g, ""); // trim
            if(id.length !== 0){

                widgetIndex = widgetsSettings.getSetting(id + "__index", "widgets")*1;
                gridModel.get(widgetIndex).widgetVisible = true;
                var widgetHeight = widgetsSettings.getSetting(id + "__height", "widgets")*1;
                var widgetWidth = widgetsSettings.getSetting(id + "__width", "widgets")*1;
                gridModel.get(widgetIndex).widgetHeightInNumberOfCells = widgetHeight;
                gridModel.get(widgetIndex).widgetWidthInNumberOfCells = widgetWidth;
                gridModel.get(widgetIndex).widgetSourceName = widgetsSettings.getSetting(id + "__source", "widgets")

                setWidgetAreaUnavailabe(widgetIndex, widgetHeight, widgetWidth);
                console.log("["+id+"] has been loaded. ");
            }
        }
    }

    function setWidgetAreaUnavailabe(widgetIndex, widgetHeight, widgetWidth) {
        var idx;
        // console.log("widgetHeight: " + widgetHeight + ", widgetWidth: " + widgetWidth);
        for(var i = 0; i < widgetHeight; i++) {
            for(var j = 0; j < widgetWidth; j++) {
                idx = widgetIndex + (i*number_of_grids_x) + j;
                // console.log(idx);
                gridModel.get(idx).available = false;
            }
        }
    }

    model: ListModel { id: gridModel }
    delegate:  WidgetDelegate {}

    cellWidth: grid.width/number_of_grids_x;
    cellHeight: grid.height/number_of_grids_y;

    opacity: (isLocked || showApplicationArea)? 0.500 : 1
    interactive: false
}
