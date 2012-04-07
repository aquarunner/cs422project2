import QtQuick 1.0

Rectangle {

    width: applicationLoder.width
    height: 70

    property string iconPath: icon;
    property string titleString: title;
    property string descriptionString: description;


    color: mouseArea.pressed ? "lightgrey" : "#00000000"
    border.color: "white"
    border.width: 3
    // radius: 3

    signal clicked

    Image {
        id: iconArea
        x: 20
        width: 50
        height: 50
        anchors.verticalCenter: parent.verticalCenter
        source: iconPath
        smooth: true
    }

    Text {
        id: titleArea
        x: iconArea.x + iconArea.width + 20
        height: 20
        text: titleString
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 22
        font.bold: true
        font.family: "Arial"
        color: "white"
    }

    Text {
        id: descriptionArea
        x: iconArea.x + iconArea.width + 20
        y: titleArea.y + titleArea.height + 8
        width: 169
        height: 8
        color: "#3a3737"
        text: descriptionString
        font.pixelSize: 12
        font.italic: true
        font.family: "Arial"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
        }
    }

    onClicked: {
        parent.clicked();
    }
}
