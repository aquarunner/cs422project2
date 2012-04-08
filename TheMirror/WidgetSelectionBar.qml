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
            NumberAnimation { target: main; property: "y"; duration: 200 }
        },
        Transition {
            from: "EXPANDED"
            NumberAnimation { target: main; property: "y"; duration: 100 }
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
                width: 300
                height: componentDisplayArea.height
                color: "#00000000" // "red"
                scale: 0.8 // show it smaller than actual

                Loader {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: widgetSourceName
                    width: grid.cellWidth * widgetWidth
                    height:grid.cellHeight * widgetHeight

                }
            }
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

                unloadedWidgets.append({ "widgetHeight": widgetHeight,
                                           "widgetWidth": widgetWidth,
                                           "widgetSourceName": widgetSourceName,
                                           // "widgetShapshot": widgetShapshot
                                       });

            }
        }
    }
}
