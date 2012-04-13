import QtQuick 1.0

Rectangle {

    property variant listView;

    width: listView.width
    height: 70

    color: mouseArea.pressed? "lightgrey": "#00000000"
    border.color: "white"
    border.width: 3

    signal clicked

    Text {
        id: titleArea
        x: 20
        height: 20
        text: routeID
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
}
