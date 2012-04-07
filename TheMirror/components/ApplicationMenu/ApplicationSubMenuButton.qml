import QtQuick 1.0

Rectangle {

    width: applicationLoder.width/2.1
    height: 70

    property string iconPath: "../../icons/"+appIcon;
    property string titleString: appName;

    color: mouseArea.pressed ? "lightgrey" : "#00000000"
    border.color: "white"
    border.width: 3
    radius: 3

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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            parent.clicked();
        }
    }

    onClicked: {
        // invoke another application

        applicationCanvas.isApplicationAreaTransparent = (appIsTransparent === 'true'); // new loaded application use solid background
        applicationCanvas.showBorder = (appShowBorder === 'true'); // show border?
        applicationCanvas.applicationAreaHeightInNumberOfCells = appHeight*1; // change the height of applicationCanvas
        applicationCanvas.applicationAreaWidthInNumberOfCells = appWidth*1; // change the width of applicationCanvas

        applicationLoder.title = appName;
        applicationLoder.iconName = appIcon;
        applicationLoder.source = appSource; // load another application
    }
}
