import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50

    Rectangle {
        id: healthPanel
        x: 0
        y: 0
        width: parent.width
        height: parent.height - 50
        color: "#00000000"

        Rectangle {
            x: 0
            y: 0
            width: healthPanel.width;
            height: healthPanel.height;
            color: "#00000000"
            Image {
                source: "pictures/health_bg.png";
            }

            Rectangle {
                id: healthM
                x:0
                y:0
                width: healthPanel.width;
                height: healthPanel.height;
                color: "#00000000"
                visible: true


                HealthMonitor{}


            }

            Rectangle {
                id: healthR
                x:0
                y:0
                width: healthPanel.width;
                height: healthPanel.height;
                color: "#00000000"
                visible: false


                HealthRecord{}

            }







        }



    }




    Button {
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

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 200
        label: i18n.report

        onClicked: {
            healthM.visible = false
            healthR.visible = true
        }

    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 380
        label: i18n.monitor

        onClicked: {
            healthM.visible = true
            healthR.visible = false
        }

    }




}
