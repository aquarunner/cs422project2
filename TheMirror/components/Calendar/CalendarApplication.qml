import QtQuick 1.0
import "../../common"

Rectangle {

    id: applicationMenu

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

//    Rectangle {
//        id: eventArea
//        // anchors.fill: parent
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.top: calendar.bottom
//        anchors.topMargin: 2
//        anchors.bottomMargin: 55
//        border.color: "lightgrey"
//        border.width: 3
//        clip: true
//        radius: 3

//        color: "#00000000"

//        ListView {
//            id: eventList
//            anchors.fill: parent
//            anchors.leftMargin: 1

//            delegate: Rectangle {
//                id: wrapper
//                width: eventList.width
//                height: 30
//                border.color: "lightgrey"
//                border.width: 2
//                // color: "#00000000"

//                Text {
//                    wrapMode: Text.Wrap
//                    text: " > "+content
//                    anchors.fill: wrapper
//                    font.pixelSize: 12
//                    font.family: "Arial"
//                }
//            }

//            // highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
//        }
//    }

//    ListModel {
//        id: eventModel
//    }

    Calendar {
        id: calendar
        clip: true

        anchors.fill: parent
        anchors.rightMargin: parent.width/2
        // anchors.bottomMargin: 55

        function clicked() {
//            eventModel.clear();

//            if(currentEvent!=""){
//                var events = currentEvent.split("||");
//                var eachEvent;
//                for(var i = 0; i < events.length; i++) {
//                    eachEvent = events[i].replace(/^\s+|\s+$/g, ""); // trim
//                    if(eachEvent != "") {
//                        eventModel.append({"content": eachEvent})
//                    }
//                }

//                eventList.model = eventModel;
//            }
        }
    }

    Button {
        id: exit

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: i18n.exit

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }

}
