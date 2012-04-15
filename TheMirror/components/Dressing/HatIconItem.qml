
import QtQuick 1.0


Component {

    Item {

        id: main
        width: hatGrid.cellWidth; height: hatGrid.cellHeight


        Image {
            id: item; parent: loc
            x: main.x; y: main.y
            //width: main.width; height: main.height;
            //fillMode: Image.PreserveAspectFit; smooth: true
            source: icon


            Rectangle {
            anchors.fill: parent;
                border.color: "#ffffff"; border.width: 3
                color: "transparent"; radius: 5
                visible: item.state == "active"
            }

            Behavior on x { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
            Behavior on y { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }

            SequentialAnimation on rotation {
                NumberAnimation { to:  2; duration: 41 }
                NumberAnimation { to: -2; duration: 82 }
                NumberAnimation { to:  0; duration: 41 }
                running: loc.currentId != -1 && item.state != "active"
                loops: Animation.Infinite; alwaysRunToEnd: true
            }


            states: State {
                name: "active"; when: loc.currentId == gridId
                PropertyChanges { target: item; x: loc.mouseX - width/2; y: loc.mouseY - height/2; scale: 1; z: 10 }
            }

            transitions: Transition { NumberAnimation { property: "scale"; duration: 100} }
        }
    }
}
