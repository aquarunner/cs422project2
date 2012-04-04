// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: rectangle1
    width: 640
    height: 200
    radius: 0

    Text {
        id: text1
        x: 197
        y: 145
        text: qsTr("this is some bs!!!!")
        style: Text.Sunken
        font.family: "MS Shell Dlg 2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
    }
}
