import QtQuick 1.0
import MirrorPlugin 1.0


Rectangle {

    property string appName;

    anchors.fill: parent
    color: /*mouseArea.pressed? "grey":*/"#00000000"
    radius: 3

    Settings {
        id: settings
    }

    Image {
        width: 32
        height: 32
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        source: "../../icons/"+ settings.getSetting(appName + "__icon", "shortcut_to_application")
        smooth: true
    }

    Text {
        text: appName
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        // font.bold: true
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            mainScreen.showMainMenuBar = false;
            mainScreen.showApplicationArea = true;

            applicationCanvas.isApplicationAreaTransparent = (settings.getSetting(appName + "__transparent", "shortcut_to_application") === 'true');
            applicationCanvas.showBorder = (settings.getSetting(appName + "__border", "shortcut_to_application") === 'true');
            applicationCanvas.applicationAreaHeightInNumberOfCells = settings.getSetting(appName + "__height", "shortcut_to_application")*1;
            applicationCanvas.applicationAreaWidthInNumberOfCells = settings.getSetting(appName + "__width", "shortcut_to_application")*1;

            applicationCanvas.componentLoder.title = appName;
            applicationCanvas.componentLoder.iconName = settings.getSetting(appName + "__icon", "shortcut_to_application");
            applicationCanvas.componentLoder.source = settings.getSetting(appName + "__source", "shortcut_to_application");
        }
    }
}
