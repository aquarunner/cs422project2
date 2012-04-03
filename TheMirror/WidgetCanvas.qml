import QtQuick 1.0

GridView {

    id: widgetCanvas
    property alias gridModel: gridModel

    Component.onCompleted: {
        for(var index = 0; index < number_of_grids_x * number_of_grids_y; index++)
        {
            gridModel.append({"gridId": index,
                                 "widgetVisible": false,
                                 "widgetHeightInNumberOfCells": 3,
                                 "widgetWidthInNumberOfCells": 5,
                                 "widgetSourceName" : "EmptyWidget.qml"
                             });
        }

        gridModel.get(0).widgetVisible = true;
        gridModel.get(0).widgetSourceName = "demo/TestWidget.qml"

        gridModel.get(4).widgetVisible = true;
        gridModel.get(4).widgetSourceName = "demo/TestWidget2.qml"
        gridModel.get(4).widgetHeightInNumberOfCells = 5
        gridModel.get(4).widgetWidthInNumberOfCells = 3

    }

    model: ListModel { id: gridModel }
    delegate:  WidgetDelegate {}

    cellWidth: grid.width/number_of_grids_x;
    cellHeight: grid.height/number_of_grids_y;

    opacity: (isLocked || showApplicationArea)? 0.500 : 1
    interactive: false
}
