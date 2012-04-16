import QtQuick 1.0

Item {
    id: container
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    Flipable {
        id: trafficFlip
        anchors.fill: parent

        property int angle: 0

        transform: Rotation{
            origin.x: trafficFlip.width/2;
            origin.y: trafficFlip.height/2
            axis.x:0; axis.y:1; axis.z:0
            angle: trafficFlip.angle
        }

        states: State {
            name: "back"
            PropertyChanges {
                target: trafficFlip;
                angle: 180
            }
        }

        transitions: Transition {
            NumberAnimation{
                property: "angle";
                duration:600
            }
        }


        front: TrafficMain {}
        back: TrafficHelp {}

    }
}
