import QtQuick 1.0

Rectangle {

    Rectangle {
        id: eventArea
        // anchors.fill: parent
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: calendar.bottom
        anchors.topMargin: 2
        border.color: "lightgrey"
        border.width: 3
        clip: true
        radius: 3

        color: "lightgrey"
        // Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

        ListView {
            id: eventList
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.bottomMargin: 2
            clip: true

            delegate: Rectangle {
                id: wrapper
                width: eventList.width
                height: 45
                border.color: "lightgrey"
                border.width: 2
                // color: "#00000000"

                Text {
                    wrapMode: Text.Wrap
                    text: content
                    anchors.left: wrapper.left
                    anchors.leftMargin: 10
                    anchors.right: wrapper.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: wrapper.verticalCenter
                    font.pixelSize: 12
                    font.family: "Arial"
                }
            }

            // highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        }
    }

    ListModel {
        id: eventModel
    }

    Calendar {
        id: calendar

        anchors.fill: parent
        anchors.bottomMargin: parent.height/3*1

        function clicked() {
            eventModel.clear();

            if(currentEvent!=""){
                var events = currentEvent.split("||");
                var eachEvent;
                for(var i = 0; i < events.length; i++) {
                    eachEvent = events[i].replace(/^\s+|\s+$/g, ""); // trim
                    if(eachEvent != "") {
                        eventModel.append({"content": eachEvent})
                    }
                }

                eventList.model = eventModel;
            }
        }
    }

}
