import QtQuick 1.0
import MirrorPlugin 1.0


Rectangle {

    property string appName;

    anchors.fill: parent
    color: mouseArea.pressed? "grey": "#00000000"
    radius: 3

    Settings {
        id: settings
    }

    Image {
        width: 50
        height: 50
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
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        // font.bold: true
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            applicationCanvas.isApplicationAreaTransparent = (settings.getSetting(appName + "__transparent", "shortcut_to_application") === 'true');
            applicationCanvas.showBorder = (settings.getSetting(appName + "__border", "shortcut_to_application") === 'true');
            applicationCanvas.applicationAreaHeightInNumberOfCells = settings.getSetting(appName + "__height", "shortcut_to_application")*1;
            applicationCanvas.applicationAreaWidthInNumberOfCells = settings.getSetting(appName + "__width", "shortcut_to_application")*1;

            applicationLoder.title = appName;
            applicationLoder.iconName = settings.getSetting(appName + "__icon", "shortcut_to_application");
            applicationLoder.source = settings.getSetting(appName + "__source", "shortcut_to_application");
        }
    }
}
