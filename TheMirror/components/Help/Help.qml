import QtQuick 1.1
import QtWebKit 1.0
import "../../common"

Rectangle {
    id: helpArea
    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    WebView {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: closeButton.top
        anchors.bottomMargin: 10
    }

    Button {
        id: closeButton
        label: i18n.close
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
