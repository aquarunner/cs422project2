import QtQuick 1.0
import "./common"
// import MirrorPlugin 1.0

Rectangle {
    id: main
    width: mainScreen.width
    height: mainScreen.height/5*3
    x: 0
    y: mainMenuBar.y
    color: "grey"
    Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

    property int delta_widgetContainer_widgetGrid_x: mainScreen.delta_widgetSelectionBar_widgetGrid_x + componentDisplayBox.x + componentDisplayArea.x;
    property int delta_widgetContainer_widgetGrid_y: mainScreen.delta_widgetSelectionBar_widgetGrid_y + componentDisplayBox.y + componentDisplayArea.y;

    property bool expanded: false;

    property variant widgetsSettings: widgetCanvas.widgetsSettings

    states: State {
        name: "EXPANDED"
        when: expanded
        PropertyChanges {
            target: main
            y: mainScreen.height/5*2
        }
    }

    transitions: [
        Transition {
            to: "EXPANDED"
            NumberAnimation { target: main; property: "y"; duration: 300 }
        },
        Transition {
            from: "EXPANDED"
            NumberAnimation { target: main; property: "y"; duration: 200 }
        }
    ]


    Rectangle {
        id: expandBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 40
        color: expandBarMouseArea.pressed? Qt.darker("lightgrey", 1.1): "lightgrey"
        border.color: "white"
        border.width: 5

        Image {
            id: expandArrow
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: expanded? "./icons/ExpandArrow_Down.png": "./icons/ExpandArrow_Up.png"
        }

        MouseArea {
            id: expandBarMouseArea
            anchors.fill: parent
            onPressed: {
                expandArrow.scale = 0.9;
            }
            onReleased: {
                expandArrow.scale = 1;
            }
            onCanceled: {
                expandArrow.scale = 1;
            }
            onClicked: {
                expanded = !expanded;
                if(expanded) {
                    mainScreen.notificationBarText = i18n.drag_the_widget_to_the_blank_space_on_screen_and_release
                    caregoryWidgetsButton.clicked();
                }
                else {
                    mainScreen.notificationBarText = i18n.drag_the_widget_to_arrange_or_click_x_to_remove
                }
            }
        }
    }

    Button {
        id: arrangeWidgetsDoneButton;
        anchors.left: parent.left
        anchors.leftMargin: 10
        y: expandBar.height + 15
        label: i18n.done;
        visible: !expanded
        onClicked: {
            mainScreen.displayArea.showGrid = false;
            mainScreen.notificationBarText = "";
        }
    }

    //    Image {
    //        id: trashCan
    //        source: "./icons/TrashCan.png"
    //        anchors.right: parent.right
    //        anchors.rightMargin: 10
    //        y: 10
    //        visible: !expanded
    //    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: expandBar.height + 15
        text: i18n.click_the_arrow_above_to_select_widgets
        color: "white"
        font.bold: true
        font.pointSize: 18
        font.family: "Arial"
        visible: !expanded
    }

    property string selectedCategory;

    VisualItemModel {
        id: categoryButtonModel
        // FIXME
        Button {id: caregoryWidgetsButton; label: i18n.widgets; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        }
        Button {label: i18n.applications; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        }
        //        Button {label: "Both"; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
        //            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        //        }
    }

    ListView {
        id: categoryList
        model: categoryButtonModel
        visible: expanded
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 200
        anchors.top: parent.top
        anchors.topMargin: expandBar.height + 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        spacing: 20
        interactive: false

    }

    ///////////////////////////////////////////////////////////////////////

//    Settings {
//        id: widgetsSettings
//    }

    ListModel { id: unloadedWidgets }
    ListModel { id: unloadedShortcuts }
    ListModel { id: unloadedBoth }

    Image {

        id: leftArrow

        x: categoryList.x + categoryList.width + 50
        anchors.verticalCenter: componentDisplayBox.verticalCenter
        source: "./icons/ExpandArrow_Left.png"
        visible: expanded

        MouseArea {
            anchors.fill: parent
            onClicked: {
                //console.debug("currentIndex: " + componentDisplayArea.currentIndex )
                if(componentDisplayArea.currentIndex > componentDisplayArea.count-3) {
                    componentDisplayArea.decrementCurrentIndex();
                    componentDisplayArea.decrementCurrentIndex();
                }
                componentDisplayArea.decrementCurrentIndex();
                //console.debug("currentIndex: " + componentDisplayArea.currentIndex )

            }
            onPressed: {
                leftArrow.scale = 0.9;
            }
            onReleased: {
                leftArrow.scale = 1;
            }
            onCanceled: {
                leftArrow.scale = 1;
            }
        }
    }

    Image {

        id: rightArrow

        x: componentDisplayBox.x + componentDisplayBox.width + 7
        anchors.verticalCenter: componentDisplayBox.verticalCenter
        source: "./icons/ExpandArrow_Right.png"
        visible: expanded
        MouseArea {
            anchors.fill: parent
            onClicked: {
                //console.debug("currentIndex: " + componentDisplayArea.currentIndex )
                if(componentDisplayArea.currentIndex < 3) {
                    componentDisplayArea.incrementCurrentIndex();
                    componentDisplayArea.incrementCurrentIndex();
                }
                componentDisplayArea.incrementCurrentIndex();
                //console.debug("currentIndex: " + componentDisplayArea.currentIndex )
            }
            onPressed: {
                rightArrow.scale = 0.9;
            }
            onReleased: {
                rightArrow.scale = 1;
            }
            onCanceled: {
                rightArrow.scale = 1;
            }
        }
    }

    Rectangle {
        id: componentDisplayBox

        anchors.left: categoryList.right
        anchors.leftMargin: 80
        anchors.top: parent.top
        anchors.topMargin: expandBar.height + 30
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: selectedCategory == i18n.widgets? 30: 200
        visible: expanded
        color: "#00000000"
        border.color: "darkgrey"
        border.width: 3
        radius: 5

        ListView {
            id: componentDisplayArea

            anchors.fill: parent
            anchors.rightMargin: parent.border.width
            anchors.leftMargin: parent.border.width
            anchors.topMargin: parent.border.width
            anchors.bottomMargin: parent.border.width

            orientation: ListView.Horizontal
            spacing: 30
            clip: true

            delegate: Rectangle {
                id: widgetContainer

                width: type=="WIDGET"? 300: 100
                height: componentDisplayArea.height
                color: "#00000000" // "red"
                scale: type=="WIDGET"? 0.8: 1.5 // show it smaller than actual

                Loader {
                    id: widgetLoader;
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: widgetSourceName
                    width: grid.cellWidth * widgetWidth
                    height:grid.cellHeight * widgetHeight

                }

                function getIndexInList() {
                    var model =  componentDisplayArea.model
                    for(var i = 0; i < model.count; i++) {
                        if(model.get(i).widgetId == widgetId) {
                            return i;
                        }
                    }

                    return -1;
                }

                MouseArea {

                    property int original_x: -1;    // Original position
                    property int original_y: -1;
                    property int deltaX;
                    property int deltaY;

                    property bool startDrag: false;
                    property bool removeOut: false;

                    property int last_x;
                    property int last_y;

                    property int componentIndex: -1;

                    anchors.fill: parent
                    onPressAndHold: {
                        if(type=="WIDGET") {
                            widgetContainer.scale = 1
                        }
                        else {
                            widgetContainer.scale = 1.8
                        }

                        componentDisplayArea.interactive = false;

                        original_x = widgetContainer.x;
                        original_y = widgetContainer.y;

                        deltaX = mouseX - original_x;
                        deltaY = mouseY - original_y;

                        last_x = original_x;
                        last_y = original_y;

                        componentIndex = getIndexInList();
                        console.log("Component index [" + componentIndex + "] is underway... ")

                        startDrag = true;

                    }
                    onReleased: {
                        startDrag = false;
                        if(type=="WIDGET") {
                            widgetContainer.scale = 0.8
                        }
                        else {
                            widgetContainer.scale = 1.5
                        }
                        componentDisplayArea.interactive = true;
                        if(!removeOut && original_x!=-1 &&original_y!=-1) {
                            widgetContainer.x = original_x;
                            widgetContainer.y = original_y;
                        }

                        componentIndex = -1;
                    }
                    onCanceled: {
                        startDrag = false;
                        if(type=="WIDGET") {
                            widgetContainer.scale = 0.8
                        }
                        else {
                            widgetContainer.scale = 1.5
                        }

                        componentDisplayArea.interactive = true;
                        if(!removeOut && original_x!=-1 &&original_y!=-1) {
                            widgetContainer.x = original_x;
                            widgetContainer.y = original_y;
                        }

                        componentIndex = -1;
                    }
                    onPositionChanged: {
                        if(startDrag) {
                            var currentX = mouseX - deltaX;
                            var currentY = mouseY - deltaY;

                            if(Math.sqrt((currentX-last_x)*(currentX-last_x) + (currentY-last_y)*(currentY-last_y)) > 20) {
                                widgetContainer.x = currentX;
                                widgetContainer.y = currentY;

                                last_x = currentX;
                                last_y = currentY;
                            }

                            var offset = (type == "SHORTCUT")? 100: 200;
                            if(Math.sqrt((currentX-original_x)*(currentX-original_x) + (currentY-original_y)*(currentY-original_y)) > offset
                                    && componentIndex != -1) {
                                console.log("Index["+componentIndex+"], let's go! ")
                                // console.log((widgetContainer.x + delta_widgetContainer_widgetGrid_x) + "/" + (widgetContainer.y + delta_widgetContainer_widgetGrid_y));
                                var indexInGrid = grid.indexAt(widgetContainer.x + delta_widgetContainer_widgetGrid_x, widgetContainer.y + delta_widgetContainer_widgetGrid_y);
                                // console.log("indexInGrid: " +indexInGrid)
                                // printObjectInfo(widgetCanvas.gridModel.get(0))
                                // printObjectInfo(widgetCanvas.gridModel.get(indexInGrid))
                                var sourceInGridName = widgetCanvas.gridModel.get(indexInGrid).widgetSourceName;
                                // console.debug(sourceInGridName);

                                if(indexInGrid!=-1 && sourceInGridName == "EmptyWidget.qml") {
                                    widgetCanvas.gridModel.get(indexInGrid).widgetId = widgetId;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetVisible = true;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetHeightInNumberOfCells = widgetHeight;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetWidthInNumberOfCells = widgetWidth;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetSourceName = widgetSourceName;
                                    widgetCanvas.gridModel.get(indexInGrid).type = type;

                                    widgetCanvas.setWidgetAreaUnavailabe(indexInGrid, widgetHeight, widgetWidth);

                                    updateWidgetInfoIntoFile(indexInGrid, widgetSourceName);

                                    expanded = false;
                                }
                            }
                        }
                    }

                    function updateWidgetInfoIntoFile(indexInGrid, widgetSourceName)
                    {
                        if(type == "WIDGET") {
                            widgetsSettings.setSetting(widgetId+"__index", ""+indexInGrid, "widgets", "./settings/");
                            widgetsSettings.setSetting(widgetId+"__source", widgetSourceName, "widgets", "./settings/");
                            widgetsSettings.setSetting(widgetId+"__onScreen", "true", "widgets", "./settings/");
                        }
                        else if (type == "SHORTCUT") {
                            // console.log(widgetId+"__index");
                            widgetsSettings.setSetting(widgetId+"__index", ""+indexInGrid, "shortcuts", "./settings/");
                            widgetsSettings.setSetting(widgetId+"__source", widgetSourceName, "shortcuts", "./settings/");
                            widgetsSettings.setSetting(widgetId+"__onScreen", "true", "shortcuts", "./settings/");
                        }
                    }
                }

            }
        }

    }


    function printObjectInfo(modelObject) {
        console.debug(modelObject);
        for(var prop in modelObject) {
            console.debug("name: " + prop + "; value: " + modelObject[prop])
        }
    }


    function loadUnloadedComponents() {

        if(selectedCategory == i18n.widgets) {
            loadUnloadedWidgets();
            componentDisplayArea.model = unloadedWidgets;
        } else if (selectedCategory == i18n.applications) {
            loadUnloadedShortcuts();
            componentDisplayArea.model = unloadedShortcuts;
        } /*else if (selectedCategory == "Both") {
            componentDisplayArea.model = unloadedBoth;
        }*/
    }

    function loadUnloadedShortcuts() {

        unloadedShortcuts.clear();

        var str = widgetsSettings.getSetting("shortcut_ids", "shortcuts", "./settings/");
        var shortcutIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < shortcutIds.length; i++) {
            id = shortcutIds[i].replace(/^\s+|\s+$/g, ""); // trim

            var onScreen = (widgetsSettings.getSetting(id + "__onScreen", "shortcuts", "./settings/") === 'true');
            if(id.length !== 0 && !onScreen){

                var widgetSourceName = widgetsSettings.getSetting(id + "__source", "shortcuts", "./settings/");

                unloadedShortcuts.append({ "widgetId": id,
                                             "widgetHeight": 1,
                                             "widgetWidth": 1,
                                             "widgetSourceName": widgetSourceName,
                                             "type": "SHORTCUT"
                                         });

            }
        }
    }

    function loadUnloadedWidgets() {

        unloadedWidgets.clear();

        var str = widgetsSettings.getSetting("widget_ids", "widgets", "./settings/");
        var widgetIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < widgetIds.length; i++) {
            id = widgetIds[i].replace(/^\s+|\s+$/g, ""); // trim
            var onScreen = (widgetsSettings.getSetting(id + "__onScreen", "widgets", "./settings/") === 'true');
            if(id.length !== 0 && !onScreen){

                var widgetHeight = widgetsSettings.getSetting(id + "__height", "widgets", "./settings/")*1;
                var widgetWidth = widgetsSettings.getSetting(id + "__width", "widgets", "./settings/")*1;
                var widgetSourceName = widgetsSettings.getSetting(id + "__source", "widgets", "./settings/")
                // var widgetShapshot = widgetsSettings.getSetting(id + "__snapshot", "widgets", "./settings/")

                unloadedWidgets.append({ "widgetId": id,
                                           "widgetHeight": widgetHeight,
                                           "widgetWidth": widgetWidth,
                                           "widgetSourceName": widgetSourceName,
                                           "type": "WIDGET",
                                           // "widgetShapshot": widgetShapshot
                                       });

            }
        }
    }
}
