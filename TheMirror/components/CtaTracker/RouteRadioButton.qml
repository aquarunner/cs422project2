import QtQuick 1.0

Rectangle {

    property variant listView;

    width: listView.width
    height: 70

    color: mouseArea.pressed ? "lightgrey" : "#00000000"
    border.color: "white"
    border.width: 3

    signal clicked

    property bool selected: listView.currentSelection == routeNumber;

    Image {
        id: iconArea
        x: 20
        width: 20
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        source: selected? "icons/RadioButton_On.png": "icons/RadioButton_Off.png"
        smooth: true
    }

    Text {
        id: titleArea
        x: 50
        height: 20
        text: routeNumber + " - " + routeName;
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 22
        font.bold: true
        font.family: "Arial"
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            parent.clicked();
        }
    }

    onClicked: {

        listView.currentSelection = routeNumber;
    }
}
