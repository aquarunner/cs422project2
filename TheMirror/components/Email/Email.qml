import QtQuick 1.0
import "../../common"

Rectangle {
    id: emailWindow

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55


    Button {
        id: exit

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
