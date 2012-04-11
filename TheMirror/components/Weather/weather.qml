import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    Rectangle {
        x: 0
        y: 0
        width: parent.width
        height: parent.height -55
        color: "#0f0f0f"
    }


    Rectangle {
        x: 0
        y: 55
        width: parent.width
        height: parent.height = 55
        color: "#0f0f0f"


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
