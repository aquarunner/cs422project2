import QtQuick 1.0
import "../../common"

Item {
    id: trafficHelp
    anchors.fill: parent

    Text {
        id: helpText
        text: i18n.trafficHelpText
        anchors.centerIn: parent
        width: 300
        wrapMode: Text.Wrap
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
    }


    Button {
        label: i18n.done
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10

        onClicked: {
            trafficFlip.state = "";
        }
    }
}
