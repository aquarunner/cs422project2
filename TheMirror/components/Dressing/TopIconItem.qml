
import QtQuick 1.0


Component {

    Item {

        id: main
        width: topGrid.cellWidth; height: topGrid.cellHeight


        Image {
            id: item; parent: locTop
            x: main.x; y: main.y
            //width: main.width; height: main.height;
            //fillMode: Image.PreserveAspectFit; smooth: true
            source: icon


            Rectangle {
            anchors.fill: parent;
                border.color: "#0f0f0f"; border.width: 6
                color: "transparent"; radius: 5
                visible: item.state == "active"
            }

            Behavior on x { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
            Behavior on y { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }

            SequentialAnimation on rotation {
                NumberAnimation { to:  2; duration: 41 }
                NumberAnimation { to: -2; duration: 82 }
                NumberAnimation { to:  0; duration: 41 }
                running: locTop.currentId != -1 && item.state != "active"
                loops: Animation.Infinite; alwaysRunToEnd: true
            }


            states: State {
                name: "active"; when: locTop.currentId == gridId
                PropertyChanges { target: item; x: locTop.mouseX - width/2; y: locTop.mouseY - height/2; scale: 1; z: 10 }
            }

            transitions: Transition { NumberAnimation { property: "scale"; duration: 100} }
        }
    }
}
