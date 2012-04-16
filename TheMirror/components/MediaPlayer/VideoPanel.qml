import QtQuick 1.0
import "../../common"

Rectangle {

    id: videoPlayer

    property bool playing: false

    property string videoName: "";
    property string videoLocation: "";
    property int videoLength: 0;

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

    Timer {
        id: playTimer
        property int totalTime: progressBar.totalTime

        interval: 1000;
        repeat: true
        onTriggered: {
            if(progressBar.currentTime > totalTime - 1){
                playTimer.stop();
                playing = false;
                progressBar.currentTime = 0;
                displayArea.source = "";
            }else{
                progressBar.currentTime += 1
            }
        }
    }

    Rectangle {

        id: row_1

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right

        height: play.height
        color: "#00000000"


        PlayerButton {
            id: play
            anchors.left: parent.left
            icon: playing? "icons/pause.png": "icons/play.png"
            width: 40
            height: 40

            onClicked: {
                if(playing) {
                    // pause here
                    playTimer.stop();
                    playing = false;
                    progressBar.currentTime = 0;
                    displayArea.source = "";
                }else {
                    // start
                    playTimer.start();
                    playing = true
                    displayArea.source = videoLocation;
                }
            }
        }

        PlayerButton {
            id: stop
            anchors.left: play.right
            icon: "icons/stop.png"
            width: 40
            height: 40

            onClicked: {
                // stop here
                playTimer.stop();
                playing = false;
                progressBar.currentTime = 0;
                displayArea.source = "";
                videoLocation = "";
                videoName = "";
                videoLength=0;
            }
        }


        Rectangle {
            id: videoInfo
            anchors.left: stop.right
            anchors.right: selectVideoButton.left
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "#d8ec73"

            border.color: "white"
            border.width: 3
            radius: 5

            Text {
                id: currentTimeText

                anchors.left: videoInfo.left
                anchors.leftMargin: 10
                anchors.top: videoInfo.top
                anchors.topMargin: 5
                text: videoName
                font.pixelSize: 12
                font.bold: true
                wrapMode: Text.Wrap
            }

            Text {
                id: totalTimeText
                text: converSecondsIntoTime(progressBar.currentTime)+" / "+converSecondsIntoTime(videoLength)
                font.pixelSize: 12
                font.bold: true
                anchors.right: videoInfo.right
                anchors.rightMargin: 10
                anchors.bottom: progressBar.top
            }

            ProgressBar {
                id: progressBar
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.bottom : parent.bottom
                anchors.bottomMargin: 10

                totalTime: videoLength
                currentTime: 0
            }
        }

        Rectangle {
            id: selectVideoButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            // anchors.bottomMargin: 10
            height: videoInfo.height
            width: selectVideoButtonText.width +10
            scale: selectVideoButtonMouseArea.pressed? 0.9: 1

            color: "grey"
            radius: 5

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#8C8F8C" }
                GradientStop { position: 0.05; color: "#6A6D6A" }
                GradientStop { position: 0.95;color: "#3F3F3F" }
                GradientStop { position: 1.0; color: "#0e1B20" }
            }

            MouseArea {
                id: selectVideoButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    listView.model = videoModel;
                    // stop
                    playTimer.stop();
                    playing = false;
                    progressBar.currentTime = 0;
                    videoLocation = "";
                    displayArea.source = "";
                    videoName = "";
                }
            }

            Text {
                id: selectVideoButtonText
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Select video"
                color: "white"
            }
        }

    }

    AnimatedImage {
        id: displayArea

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.bottom: row_1.top
        anchors.bottomMargin: 10

        source: videoLocation;
    }

    ListView {
        id: listView

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.bottom: row_1.top
        anchors.bottomMargin: 10
        clip: true
        // model: videoModel
        visible: true;

        delegate: Rectangle {

            property alias mouseArea: delegateMouseArea

            id: videoDelegate
            width: listView.width
            height: 40
            radius: 2
            color: delegateMouseArea.pressed? "lightgrey": "white"
            border.width: 2

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                // anchors.horizontalCenter: parent.horizontalCenter
                text: videoName + "    [" + converSecondsIntoTime(videoLength*1) +"]"
            }

            MouseArea {
                id: delegateMouseArea
                anchors.fill: parent

                onClicked: {
                    click();
                    listView.model = null;
                }

                function click() {
                    videoPlayer.videoName = videoName;
                    videoPlayer.videoLocation = videoLocation;
                    videoPlayer.videoLength = videoLength;

                    // stop
                    playTimer.stop();
                    playing = false;
                    progressBar.currentTime = 0;

                    // then start
                    playTimer.start();
                    playing = true;
                    displayArea.source = videoLocation;
                }
            }
        }

        ScrollBar {
            scrollArea: listView; height: listView.height; width: 8
            anchors.right: listView.right
        }
    }


    XmlListModel {
        id: videoModel

        source: "video.xml"
        query: "/videos/video"

        XmlRole { name: "videoName"; query: "videoName/string()" }
        XmlRole { name: "videoLocation"; query: "videoLocation/string()" }
        XmlRole { name: "videoLength"; query: "videoLength/string()" }
    }

    function converSecondsIntoTime(seconds) {
        var hours = Math.floor(seconds / 3600)
        var minutes = Math.floor((seconds % 3600) / 60)
        seconds = Math.floor(seconds % 3600 % 60)

        var hoursString = hours<=9? ("0"+hours): hours
        var minutesString = minutes<=9? ("0"+minutes): minutes
        var secondsString = seconds<=9? ("0"+seconds): seconds

        return hoursString+":"+minutesString+":"+secondsString

    }

}
