import QtQuick 1.0

Item {
    id: button
    property string current: "../imgs/textbutton.png"
    property string background: "../imgs/textbutton.png"
    property string pressed: "../imgs/textbutton_pressed.png"
    property string focused: "../imgs/textbutton_focused.png"
    signal buttonClicked
    // width: background.width; height: background.height
    height: monthHandler.height
    width: (monthHandler.width - calendarStringImg.width)/2

    Image {
        id: background
        anchors.fill: parent
        source: button.current
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        signal buttonClicked

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: button.current = button.pressed
            onClicked: {
                button.current = button.background
                button.buttonClicked()
            }
            onEntered: button.current = button.focused
            onExited: button.current = button.background
        }

    }
}
