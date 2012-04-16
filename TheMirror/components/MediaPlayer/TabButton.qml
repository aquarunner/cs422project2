import QtQuick 1.0

Rectangle {

    id: container

    property string label: ""
    property bool selected: false
    signal clicked

    width: 200
    height: parent.height
    anchors.top: parent.top
    anchors.topMargin: 5
    radius: 5
    border.color: "grey"
    border.width: 3
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.2; color: "lightgrey" }
        GradientStop { position: 0.98; color: selected? "darkgrey": "white" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }
    scale: mouseArea.pressed? 0.9: 1


    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: label
        font.bold: true
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: { container.clicked(); }
        onPressed: {
            tabBar.selectedButton = label
        }
    }
}
