import QtQuick 1.0

Rectangle {
    id: container

    property variant text
    signal clicked

    //height: text.height + 2;
    height: 54
    width: text.width + 10
    border.width: 1
    radius: 4
    smooth: true

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: !mouseArea.pressed ? palette.light : palette.button
        }
        GradientStop {
            position: 1.0
            color: !mouseArea.pressed ? palette.button : palette.dark
        }
    }

    SystemPalette { id: palette }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked()
    }

    Text {
        id: text
        anchors.centerIn:parent
        font.pointSize: 10
        text: parent.text
        color: palette.buttonText
    }
}
