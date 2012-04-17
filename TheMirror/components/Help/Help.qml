import QtQuick 1.1
import QtWebKit 1.0
import "../../common"

Rectangle {
    id: helpArea
    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50
    clip: true

    Item {
        id: instruction
        anchors.fill: parent
        anchors.bottomMargin: 55
        anchors.leftMargin: 20
        anchors.topMargin: 20
        visible: true

        Flickable {

            id: flickable

            Image{
                id: picture; source:"Documentation.png"
            }
            contentWidth:flickable.width
            contentHeight:picture.height
            anchors.fill: parent
            clip: true

        }
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
