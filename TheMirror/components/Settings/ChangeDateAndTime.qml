import QtQuick 1.0
import "../../common" as Common
import "date"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50


    Text {
        id: changeDateText
        text: "Please set the date: "
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 50

//        anchors.left: parent.left
//        anchors.leftMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
//        anchors.left: changeDateText.left
//        anchors.leftMargin: 130
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: changeDateText.bottom
        anchors.topMargin: 50

        Column {
                id: datePicker
                width: 260
                anchors.centerIn: parent

                Row {
                    width: parent.width

                    Text {
                        id: yearText
                        width: (parent.width-2*parent.spacing)*0.4
                        text: "Year"
                        color: "#666666"
                        font.pixelSize: 12
                    }
                    Text {
                        id: monthText
                        width: (parent.width-2*parent.spacing)*0.3
                        text: "Month"
                        color: "#666666"
                        font.pixelSize: 12
                    }
                    Text {
                        id: dayText
                        width: (parent.width-2*parent.spacing)*0.3
                        text: "Day"
                        color: "#666666"
                        font.pixelSize: 12
                    }
                }
                DateReel {
                    id: dateReel
                    width: parent.width
                }
            }
    }

    Text {
        id: changeTimeText
        text: "And the time: "
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 200

//        anchors.left: parent.left
//        anchors.leftMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Rectangle {
        anchors.left: changeDateText.left
        anchors.leftMargin: 150
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: changeDateText.bottom
        anchors.topMargin: 200

        Column {
                id: timePicker
                width: 260
                anchors.centerIn: parent

                Row {
                    width: parent.width

                    Text {
                        id: hourText
                        width: (parent.width-2*parent.spacing)*0.3
                        text: "Hour"
                        color: "#666666"
                        font.pixelSize: 12
                    }
                    Text {
                        id: minuteText
                        width: (parent.width-2*parent.spacing)*0.3
                        text: "Minute"
                        color: "#666666"
                        font.pixelSize: 12
                    }
                }
                TimeReel {
                    id: timeReel
                    width: parent.width
                }
            }
    }



    Common.Button {
        id: exit

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: i18n.ok

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }

}
