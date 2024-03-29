import QtQuick 1.0
//import MirrorPlugin 1.0

GridView {

    id: widgetCanvas
    property alias gridModel: gridModel
    property variant widgetsSettings;

    //    Settings {
    //        id: widgetsSettings
    //    }

    Component.onCompleted: {
        for(var index = 0; index < number_of_grids_x * number_of_grids_y; index++)
        {
            gridModel.append({"gridId": index,
                                 "widgetId": "",
                                 "widgetVisible": false,
                                 "widgetHeightInNumberOfCells": 1,
                                 "widgetWidthInNumberOfCells": 1,
                                 "widgetSourceName" : "EmptyWidget.qml",
                                 "available" : true,
                                 "type": "",
                                 "gridModel" : gridModel
                             });
        }

        loadWidgets();
        loadShortcuts();

    }

    function reloadWidget(widgetID) {
        for(var i = 0; i < gridModel.count; i++) {
            if(gridModel.get(i).widgetId == widgetID) {
                gridModel.get(i).widgetSourceName = "";
                gridModel.get(i).widgetSourceName = widgetsSettings.getSetting(widgetID + "__source", "widgets", "./settings/")
                break;
            }
        }
    }

    function loadWidgets() {

        var str = widgetsSettings.getSetting("widget_ids", "widgets", "./settings/");
        var widgetIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < widgetIds.length; i++) {
            id = widgetIds[i].replace(/^\s+|\s+$/g, ""); // trim
            var onScreen = (widgetsSettings.getSetting(id + "__onScreen", "widgets", "./settings/") === 'true');
            if(id.length !== 0 && onScreen){

                widgetIndex = widgetsSettings.getSetting(id + "__index", "widgets", "./settings/")*1;
                gridModel.get(widgetIndex).widgetId = id;
                gridModel.get(widgetIndex).widgetVisible = true;
                var widgetHeight = widgetsSettings.getSetting(id + "__height", "widgets", "./settings/")*1;
                var widgetWidth = widgetsSettings.getSetting(id + "__width", "widgets", "./settings/")*1;
                gridModel.get(widgetIndex).widgetHeightInNumberOfCells = widgetHeight;
                gridModel.get(widgetIndex).widgetWidthInNumberOfCells = widgetWidth;
                gridModel.get(widgetIndex).widgetSourceName = widgetsSettings.getSetting(id + "__source", "widgets", "./settings/")
                gridModel.get(widgetIndex).type = "WIDGET"

                setWidgetAreaUnavailabe(widgetIndex, widgetHeight, widgetWidth);
                console.log("["+id+"] has been loaded. ");
            }
        }
    }

    function loadShortcuts() {

        var str = widgetsSettings.getSetting("shortcut_ids", "shortcuts", "./settings/");
        var widgetIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < widgetIds.length; i++) {
            id = widgetIds[i].replace(/^\s+|\s+$/g, ""); // trim
            var onScreen = (widgetsSettings.getSetting(id + "__onScreen", "shortcuts", "./settings/") === 'true');
            if(id.length !== 0 && onScreen){

                widgetIndex = widgetsSettings.getSetting(id + "__index", "shortcuts", "./settings/")*1;
                gridModel.get(widgetIndex).widgetId = id;
                gridModel.get(widgetIndex).widgetVisible = true;
                gridModel.get(widgetIndex).widgetHeightInNumberOfCells = 1;
                gridModel.get(widgetIndex).widgetWidthInNumberOfCells = 1;
                gridModel.get(widgetIndex).widgetSourceName = widgetsSettings.getSetting(id + "__source", "shortcuts", "./settings/")
                gridModel.get(widgetIndex).type = "SHORTCUT"

                setWidgetAreaUnavailabe(widgetIndex, 1, 1);
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
