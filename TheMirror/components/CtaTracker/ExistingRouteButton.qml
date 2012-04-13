import QtQuick 1.0

Rectangle {

    property variant listView;
    property int fontSize: 22

    width: listView.width
    height: 70

    color: mouseArea.pressed? "lightgrey": "#00000000"
    border.color: "white"
    border.width: 3

    signal clicked

    Text {
        id: titleArea
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        x: listView.width/25
        height: 20
        width: parent.width - 2
        text: routeID
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: fontSize
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
