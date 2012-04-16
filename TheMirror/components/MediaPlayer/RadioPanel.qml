import QtQuick 1.0
import "../../common"

Rectangle {

    id: radioPlayer

    property bool playing: false

    property string radioName: "";

    radius: 5
    border.color: "grey"
    border.width: 3

    color: "lightgrey"

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.02; color: "lightgrey" }
        GradientStop { position: 0.98; color: "lightgrey" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }


    Rectangle {

        id: row_1

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right

        height: seekBack.height
        color: "#00000000"

        PlayerButton {
            id: seekBack
            icon: "icons/seek-back.png"
            anchors.left: parent.left
            anchors.leftMargin: 0
            onClicked: {
                if(listView.selectIndex!=-1) {
                    var newIndex = (listView.selectIndex - 1)%listView.count
                    listView.selectIndex = newIndex==-1? listView.count-1: newIndex
                    // console.log(listView.selectIndex)
                    listView.currentIndex = listView.selectIndex;
                    listView.currentItem.mouseArea.click();
                }
            }

        }

        PlayerButton {
            id: play
            anchors.left: seekBack.right
            icon: playing? "icons/stop.png": "icons/play.png"

            onClicked: {
                if(playing) {
                    // pause here
                    playing = false;
                }else {
                    // start
                    playing = true
                }
            }
        }

        PlayerButton {
            id: seekForward
            anchors.left: play.right
            icon: "icons/seek-forward.png"

            onClicked: {
                if(listView.selectIndex!=-1) {
                    listView.selectIndex = (listView.selectIndex + 1)%listView.count
                    listView.currentIndex = listView.selectIndex;
                    listView.currentItem.mouseArea.click();
                }
            }

        }

        Rectangle {
            id: radioInfo
            anchors.left: seekForward.right
            anchors.right: volumeArea.left
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            color: "#d8ec73"

            border.color: "white"
            border.width: 3
            radius: 5


            Text {
                id: radioNameText

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: radioInfo.left
                anchors.leftMargin: 20

                text: radioName
                font.pixelSize: 20
                font.bold: true
                wrapMode: Text.Wrap

            }
        }

        Rectangle {
            id: volumeArea
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 30
            height: volumeDown.height
            width: 200
            color: "lightgrey"
            radius: 7

            Image {
                id: volumeDown

                anchors.left: volumeArea.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                source: "icons/volume_down.png"
            }

            ProgressBar {
                id: volume
                anchors.left: volumeDown.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                width: 100

                totalTime: 10
                currentTime: 8
            }

            Image {
                id: volumeUp

                anchors.left: volume.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                source: "icons/volume_up.png"
            }
        }
    }


    ListView {
        id: listView

        property int selectIndex: -1;

        anchors.top: row_1.bottom
        // anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        model: albumModel
        clip: true

        delegate: Rectangle {

            property alias mouseArea: delegateMouseArea

            id: albumDelegate
            width: listView.width
            height: 40
            radius: 2
            color: delegateMouseArea.pressed||listView.selectIndex==index? "lightgrey": "white"
            border.width: 2

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                // anchors.horizontalCenter: parent.horizontalCenter
                text: radioName
            }

            MouseArea {
                id: delegateMouseArea
                anchors.fill: parent

                onClicked: {

                    click();
                }

                function click() {
                    radioPlayer.radioName = radioName;
                    // then start
                    // playing = true;

                    listView.selectIndex = index;
                }
            }
        }

        ScrollBar {
            scrollArea: listView; height: listView.height; width: 8
            anchors.right: listView.right
        }
    }



    XmlListModel {
        id: albumModel
        source: "radio.xml"
        query: "/radio/radioName"

        XmlRole { name: "radioName"; query: "string()" }
    }

}
