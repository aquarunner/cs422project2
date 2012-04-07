import QtQuick 1.0
import "./common"

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
}
