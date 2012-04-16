import QtQuick 1.0

Rectangle {
    id: progressBar

    height: 15
    color: "#00000000"

    property int totalTime: 0;
    property int currentTime: 0;

    Rectangle {
        id: totalLength

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right

        border.color: "lightgrey"
        border.width: 1
        height: 4
        color: "grey"

        MouseArea {
            anchors.fill: parent
            anchors.topMargin: -10
            anchors.bottomMargin: -10
            onClicked: {
                currentTime = mouseX/progressBar.width * totalTime
            }
        }
    }

    Rectangle {
        anchors.verticalCenter: totalLength.verticalCenter
        anchors.left: totalLength.left
        anchors.right: positionIndicator.left

        border.color: "lightgrey"
        border.width: 1
        height: 4
        color: "skyblue"
    }

    Rectangle {
        id: positionIndicator
        width: totalLength.width/10
        height: 12
        radius: 2
        anchors.verticalCenter: parent.verticalCenter
        color: "grey"
        x: (progressBar.width-positionIndicator.width)/totalTime * currentTime

        MouseArea {
            anchors.fill: parent
            onMouseXChanged: {
                if(positionIndicator.x+mouseX >= 0
                        && positionIndicator.x+mouseX <= progressBar.width) {
                    currentTime = (positionIndicator.x+mouseX)/progressBar.width * totalTime
                }
            }
        }
    }
}
