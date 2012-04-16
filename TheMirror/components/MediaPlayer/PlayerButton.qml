import QtQuick 1.0

Image {

    property string icon: ""

    id: button

    signal clicked

    smooth: true
    source: icon
    scale: mouseArea.pressed? 0.9: 1

    width: 80
    height: 80

    MouseArea {
        id: mouseArea
        anchors.fill: button
        onClicked: { button.clicked();}
    }
}
