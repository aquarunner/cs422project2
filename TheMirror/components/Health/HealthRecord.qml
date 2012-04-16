import QtQuick 1.0

Rectangle {
    width: 945
    height: 410
    color: "#00000000"
    Image {
        source: "pictures/healthRecord.png"
    }

    Rectangle {
        x: healthPanel.width - 110
        y: 20
        width: 80
        height: 80
        color: "#00000000"
        Image {
            source: "pictures/monitorIcon.png"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                healthM.visible = true
                healthR.visible = false
            }
        }

    }
}
