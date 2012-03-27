import QtQuick 1.0

Rectangle {
    id: applicationCanvas

    height: 720
    width: 1280
    anchors.fill: parent
    color: "#00000000"

    property int applicationAreaHeight: 640
    property int applicationAreaWidth: 640
    property bool isApplicationAreaTransparent: false;

    property alias componentLoder: componentLoder


    Rectangle {
        id: top
        x: applicationArea.x
        width: applicationArea.width + applicationArea.border.width
        height: applicationArea.y
        anchors.top: parent.top
        anchors.topMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: bottom
        x: applicationArea.x
        width: applicationArea.width
        height: applicationCanvas.height - applicationArea.y - applicationArea.height + applicationArea.border.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: left
        width: applicationArea.x + applicationArea.border.width
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    Rectangle {
        id: right
        width: applicationCanvas.width - applicationArea.x - applicationArea.width + applicationArea.border.width
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        color: "darkgrey"
        Image { source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        opacity: 0.6
    }

    //    Rectangle {
    //        id: center
    //        x: applicationCanvas.x
    //        y: applicationCanvas.y
    //        width: applicationCanvas.width
    //        height: applicationCanvas.height

    //        color: isApplicationAreaTransparent? "#00000000" : "darkgrey"
    //        Image {
    //            source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3
    //            visible: !isApplicationAreaTransparent
    //        }
    //        opacity: 0.6
    //    }

    Rectangle {
        id: applicationArea

        width: applicationAreaWidth + border.width * 2
        height: applicationAreaHeight + border.width * 2
        radius: 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color: "white"
        border.width: 5

        color: isApplicationAreaTransparent? "#00000000" : "darkgrey"
        Image {
            source: "icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3
            visible: !isApplicationAreaTransparent
        }
        opacity: 0.6
    }

    Loader {
        id: componentLoder;
        x: applicationArea.x + applicationArea.border.width
        y: applicationArea.y + applicationArea.border.width
        width: applicationAreaWidth
        height: applicationAreaHeight

        property variant applicationColor: "#00000000" //transparent
        property variant applicationLoder: componentLoder;
    }

}
