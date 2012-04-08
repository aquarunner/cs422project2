import QtQuick 1.0
import "./common"
import MirrorPlugin 1.0

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
                    mainScreen.notificationBarText = "Drag the widget to the blank space on screen, and release"
                    caregoryWidgetsButton.clicked();
                }
                else {
                    mainScreen.notificationBarText = "Drag the widget to arrange or remove"
                }
            }
        }
    }

    Button {
        id: arrangeWidgetsDoneButton;
        anchors.left: parent.left
        anchors.leftMargin: 10
        y: expandBar.height + 15
        label: "Done";
        visible: !expanded
        onClicked: {
            mainScreen.displayArea.showGrid = false;
            mainScreen.notificationBarText = "";
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: expandBar.height + 15
        text: "Click the arrow above to select widgets"
        color: "white"
        font.bold: true
        font.pointSize: 18
        font.family: "Arial"
        visible: !expanded
    }

    property string selectedCategory;

    VisualItemModel {
        id: categoryButtonModel
        Button {id: caregoryWidgetsButton; label: "Widgets"; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        }
        Button {label: "Applications"; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        }
        Button {label: "Both"; border.color: "skyblue"; border.width: selectedCategory==label?3:0; height: 50; width: 200
            onClicked: { selectedCategory = label; loadUnloadedComponents(); }
        }
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

    Settings {
        id: widgetsSettings
    }

    ListModel { id: unloadedWidgets }
    ListModel { id: unloadedApplications }
    ListModel { id: unloadedBoth }

    Image {

        id: leftArrow

        x: categoryList.x + categoryList.width + 50
        anchors.verticalCenter: parent.verticalCenter
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
        anchors.verticalCenter: parent.verticalCenter
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
        anchors.bottomMargin: 30
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

                width: 300
                height: componentDisplayArea.height
                color: "#00000000" // "red"
                scale: 0.8 // show it smaller than actual

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

                    property int original_x;    // Original position
                    property int original_y;
                    property int deltaX;
                    property int deltaY;

                    property bool startDrag: false;
                    property bool removeOut: false;

                    property int last_x;
                    property int last_y;

                    property int componentIndex: -1;

                    anchors.fill: parent
                    onPressAndHold: {
                        widgetContainer.scale = 1
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
                        widgetContainer.scale = 0.8
                        componentDisplayArea.interactive = true;
                        if(!removeOut) {
                            widgetContainer.x = original_x;
                            widgetContainer.y = original_y;
                        }

                        componentIndex = -1;
                    }
                    onCanceled: {
                        startDrag = false;
                        widgetContainer.scale = 0.8
                        componentDisplayArea.interactive = true;
                        if(!removeOut) {
                            widgetContainer.x = original_x;
                            widgetContainer.y = original_y;
                        }

                        componentIndex = -1;
                    }
                    onPositionChanged: {
                        if(startDrag) {
                            var currentX = mouseX - deltaX;
                            var currentY = mouseY - deltaY;

                            if(Math.sqrt((currentX-last_x)*(currentX-last_x) + (currentY-last_y)*(currentY-last_y)) > 30) {
                                widgetContainer.x = currentX;
                                widgetContainer.y = currentY;

                                last_x = currentX;
                                last_y = currentY;
                            }

                            if(Math.sqrt((currentX-original_x)*(currentX-original_x) + (currentY-original_y)*(currentY-original_y)) > 200
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
                                    widgetCanvas.gridModel.get(indexInGrid).widgetVisible = true;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetHeightInNumberOfCells = widgetHeight;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetWidthInNumberOfCells = widgetWidth;
                                    widgetCanvas.gridModel.get(indexInGrid).widgetSourceName = widgetSourceName;

                                    widgetCanvas.setWidgetAreaUnavailabe(indexInGrid, widgetHeight, widgetWidth);

                                    updateWidgetInfoIntoFile(indexInGrid, widgetSourceName);

                                    expanded = false;
                                }
                            }
                        }
                    }

                    function updateWidgetInfoIntoFile(indexInGrid, widgetSourceName)
                    {
                        widgetsSettings.setSetting(widgetId+"__index", ""+indexInGrid, "widgets");
                        widgetsSettings.setSetting(widgetId+"__source", widgetSourceName, "widgets");
                        widgetsSettings.setSetting(widgetId+"__onScreen", "true", "widgets");
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
        if(selectedCategory == "Widgets") {
            loadUnloadedWidgets();
            componentDisplayArea.model = unloadedWidgets;
        } else if (selectedCategory == "Applications") {
            componentDisplayArea.model = unloadedApplications;
        } else if (selectedCategory == "Both") {
            componentDisplayArea.model = unloadedBoth;
        }
    }

    function loadUnloadedWidgets() {

        unloadedWidgets.clear();

        var str = widgetsSettings.getSetting("widget_ids", "widgets");
        var widgetIds = str.split(";");
        var id;
        var widgetIndex;
        for(var i = 0; i < widgetIds.length; i++) {
            id = widgetIds[i].replace(/^\s+|\s+$/g, ""); // trim
            var onScreen = (widgetsSettings.getSetting(id + "__onScreen", "widgets") === 'true');
            if(id.length !== 0 && !onScreen){

                var widgetHeight = widgetsSettings.getSetting(id + "__height", "widgets")*1;
                var widgetWidth = widgetsSettings.getSetting(id + "__width", "widgets")*1;
                var widgetSourceName = widgetsSettings.getSetting(id + "__source", "widgets")
                // var widgetShapshot = widgetsSettings.getSetting(id + "__snapshot", "widgets")

                unloadedWidgets.append({ "widgetId": id,
                                           "widgetHeight": widgetHeight,
                                           "widgetWidth": widgetWidth,
                                           "widgetSourceName": widgetSourceName,
                                           // "widgetShapshot": widgetShapshot
                                       });

            }
        }
    }
}
