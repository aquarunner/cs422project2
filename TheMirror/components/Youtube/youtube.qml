import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50

    Rectangle {
        id: healthPanel
        x: 0
        y: 0
        width: parent.width
        height: parent.height - 50
        color: "#00000000"

        Image {
            source: "pictures/Youtube.png"
        }

    }


    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: i18n.exit

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
