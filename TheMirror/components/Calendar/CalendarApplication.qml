import QtQuick 1.0
import "../../common"

Rectangle {

    id: applicationMenu

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 52

    Calendar {
        id: calendar
        clip: true

        anchors.fill: parent
        anchors.rightMargin: parent.width/2
        anchors.bottomMargin: 55

//        function printObjectInfo(modelObject) {
//            console.log(modelObject)
//            for(var prop in modelObject) {
//                console.log("name: " + prop + "; value: " + modelObject[prop])
//            }
//            console.log("==================")
//        }

        function clicked() {
            eventModel.clear();
            eventArea.clearCheckedInfo()
            // console.log(currentEvent)

            if(currentEvent!=""){
                var events = currentEvent.split("||");
                var eachEvent;

                var checkedIndicesCopy = eventArea.checkedIndices;
                for(var i = 0; i < events.length; i++) {
                    eachEvent = events[i].replace(/^\s+|\s+$/g, ""); // trim
                    if(eachEvent != "") {
                        checkedIndicesCopy[eventModel.count] = false;
                        eventModel.append({"content": eachEvent, "index": eventModel.count})
                    }
                }

                eventArea.checkedIndices = checkedIndicesCopy;
            }
        }
    }

    Rectangle {
        id: eventArea
        // anchors.fill: parent
        anchors.left: calendar.right
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 55
        // border.color: "lightgrey"
        // border.width: 3
        clip: true
        // radius: 3

        color: "#00000000"

        property int numberOfChecked: 0
        property variant checkedIndices: [];

        function clearCheckedInfo() {
            numberOfChecked = 0;
            var checkedIndicesCopy = [];
            checkedIndices = checkedIndicesCopy;
        }

        ListView {
            id: eventList
            anchors.fill: parent
            anchors.leftMargin: 1
            model: eventModel

            delegate: Rectangle {
                id: wrapper
                width: eventList.width
                height: 60
                border.color: "lightgrey"
                border.width: 2
                // color: "#00000000"

                color: "darkgrey"
                scale: checkArea.pressed? 0.9: 1

                property bool checked: false;

                Image {
                    anchors.left: wrapper.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: wrapper.verticalCenter
                    source: checked? "imgs/ICON_checkbox-d.gif": "imgs/ICON_checkbox-u.gif"
                }

                Text {
                    id: contentText
                    wrapMode: Text.Wrap
                    text: content
                    // anchors.fill: wrapper
                    anchors.left: wrapper.left
                    anchors.leftMargin: 50
                    anchors.right: wrapper.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: wrapper.verticalCenter
                    font.bold: true
                    font.pixelSize: 15
                    font.family: "Arial"
                    color: "white"
                    // color: "#444444"
                }

                MouseArea {
                    id: checkArea
                    anchors.fill: wrapper

                    onClicked: {
                        wrapper.checked = !wrapper.checked;
                        var checkedIndicesCopy = eventArea.checkedIndices;
                        if(wrapper.checked) {
                            checkedIndicesCopy[index*1] = true;
                            // console.log("T:["+index+"]"+checkedIndicesCopy[index*1])
                            eventArea.numberOfChecked++;
                        }else {
                            checkedIndicesCopy[index*1] = false;
                            // console.log("F:["+index+"]"+checkedIndicesCopy[index*1])
                            eventArea.numberOfChecked--;
                        }

                       eventArea.checkedIndices = checkedIndicesCopy
                    }
                }
            }
        }
    }

    ListModel {
        id: eventModel
    }

    Button {
        id: addEvent

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 20
        label: "Add"

        Image {
            anchors.left: addEvent.left
            anchors.leftMargin: 5
            source: "imgs/add.png"
            width: addEvent.height - 2
            height: addEvent.height - 2
        }

        onClicked: {

        }
    }

    Button {
        id: deleteEvent

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        label: i18n.delete_
        visible: eventArea.numberOfChecked != 0

        Image {
            anchors.left: deleteEvent.left
            anchors.leftMargin: 5
            source: "imgs/subtract.png"
            width: deleteEvent.height - 2
            height: deleteEvent.height - 2
        }

        onClicked: {
            var clickedDate = calendar.clickedDate;
            var eventsString = "";

            for(var i = 0; i < eventModel.count; i++) {
                if(!eventArea.checkedIndices[i]) {
                    eventsString += (eventModel.get(i).content + "||")
                }
            }

            if(eventsString != "") {
                settings.setSetting(""+clickedDate.getFullYear()+"_"+(clickedDate.getMonth()+1)+"_"+clickedDate.getDate(),
                                           eventsString, "events", "./components/Calendar/");
            }
            else {
                settings.setSetting(""+clickedDate.getFullYear()+"_"+(clickedDate.getMonth()+1)+"_"+clickedDate.getDate(),
                                           "$$NULL$$", "events", "./components/Calendar/");
            }

            calendar.currentEvent = eventsString;
            // console.log("After deletion: " + calendar.currentEvent)
            calendar.reset();
            // calendar.clicked();
            widgetCanvas.reloadWidget("calendar_widget");
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
