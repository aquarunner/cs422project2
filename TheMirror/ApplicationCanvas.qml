import QtQuick 1.0

Rectangle {
    id: applicationCanvas

    height: 720
    width: 1280
    anchors.fill: parent
    color: "#00000000"

    property int __defaultHeightInNumberOfCells: 10
    property int __defaultWidthInNumberOfCells: 12

    property int applicationAreaHeightInNumberOfCells: __defaultHeightInNumberOfCells
    property int applicationAreaWidthInNumberOfCells: __defaultWidthInNumberOfCells

    property int __applicationAreaHeight: grid.cellHeight * applicationAreaHeightInNumberOfCells
    property int __applicationAreaWidth: grid.cellWidth * applicationAreaWidthInNumberOfCells
    property bool isApplicationAreaTransparent: false;
    property bool showBorder: true;

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

        width: __applicationAreaWidth + border.width * 2
        height: __applicationAreaHeight + border.width * 2
        radius: 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color: showBorder? "white" : "#00000000"
        border.width: showBorder? 5 : 0

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
        width: __applicationAreaWidth
        height: __applicationAreaHeight

        property variant applicationColor: "#00000000" //transparent
        property variant applicationLoder: componentLoder;
    }

}
