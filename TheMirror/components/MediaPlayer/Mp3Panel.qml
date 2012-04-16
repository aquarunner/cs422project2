import QtQuick 1.0
import "../../common"

Rectangle {

    id: mp3Player

    property bool playing: false

    property string songName: "";
    property string artist: "";
    property string album: "";
    property string albumCover: "";
    property int songLenght: 0;

    radius: 5
    border.color: "grey"
    border.width: 3

    color: "lightgrey"
    // Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#8C8F8C" }
        GradientStop { position: 0.02; color: "lightgrey" }
        GradientStop { position: 0.98; color: "lightgrey" }
        GradientStop { position: 1.0; color: "#8C8F8C" }
    }

    Timer {
        id: playTimer
        property int totalTime: progreebar.totalTime

        interval: 1000;
        repeat: true
        onTriggered: {
            if(progreebar.currentTime > totalTime - 1){
                playTimer.stop();
                playing = false;
                progreebar.currentTime = 0;
            }else{
                progreebar.currentTime += 1
            }
        }
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
                var step = Math.floor(progreebar.totalTime/10 && playing)
                if(progreebar.currentTime - step > 0)
                {
                    playTimer.stop();
                    progreebar.currentTime -= step
                    playTimer.start();
                }
            }
        }

        PlayerButton {
            id: play
            anchors.left: seekBack.right
            icon: playing? "icons/pause.png": "icons/play.png"

            onClicked: {
                if(playing) {
                    // pause here
                    playTimer.stop();
                    playing = false;
                }else {
                    // start
                    playTimer.start();
                    playing = true
                }
            }
        }

        PlayerButton {
            id: seekForward
            anchors.left: play.right
            icon: "icons/seek-forward.png"

            onClicked: {
                var step = Math.floor(progreebar.totalTime/10)
                if(progreebar.currentTime + step < progreebar.totalTime && playing)
                {
                    playTimer.stop();
                    progreebar.currentTime += step
                    playTimer.start();
                }
            }
        }

        Rectangle {
            id: musicInfo
            anchors.left: seekForward.right
            anchors.right: albumCoverImage.left
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "#d8ec73"

            border.color: "white"
            border.width: 3
            radius: 5

            Text {
                id: currentTimeText

                anchors.left: musicInfo.left
                anchors.leftMargin: 10
                anchors.top: musicInfo.top
                anchors.topMargin: 5
                text: converSecondsIntoTime(progreebar.currentTime)
                font.pixelSize: 40
                font.bold: true
            }

            Text {
                id: songNameText

                anchors.right: musicInfo.right
                anchors.rightMargin: 10
                anchors.top: musicInfo.top
                anchors.topMargin: 10
                anchors.left: currentTimeText.right
                anchors.leftMargin: 20

                text: artist + ((artist!="")?" - ":"") + songName
                font.pixelSize: 12
                font.bold: true
                wrapMode: Text.Wrap

            }

            Text {
                id: totalTimeText
                text: converSecondsIntoTime(songLenght)
                font.pixelSize: 12
                font.bold: true
                anchors.right: musicInfo.right
                anchors.rightMargin: 10
                anchors.bottom: progreebar.top
            }

            ProgressBar {
                id: progreebar
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.bottom : parent.bottom
                anchors.bottomMargin: 10

                totalTime: songLenght
                currentTime: 0
            }
        }

        Image {
            id: albumCoverImage
            source: albumCover
            anchors.right: parent.right
            anchors.rightMargin: 10
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
            width: 80
            height: 80
            fillMode: Image.PreserveAspectCrop
            smooth: true


        }
    }

    Rectangle {

        id: row_2

        anchors.top: row_1.bottom
        anchors.topMargin: -5
        anchors.left: parent.left
        anchors.right: parent.right

        height: seekBack.height
        color: "#00000000"

        PlayerButton {
            id: skipBack
            icon: "icons/skip-back.png"
            anchors.left: parent.left
            anchors.leftMargin: 45
            width: 50
            height: 50

            onClicked: {
                if(listView.selectIndex!=-1 && !listView.showAlbum) {
                    var newIndex = (listView.selectIndex - 1)%listView.count
                    listView.selectIndex = newIndex==-1? listView.count-1: newIndex
                    // console.log(listView.selectIndex)
                    listView.currentIndex = listView.selectIndex;
                    listView.currentItem.mouseArea.click();
                }
            }

        }

        PlayerButton {
            id: stop
            anchors.left: skipBack.right
            icon: "icons/stop.png"
            width: 50
            height: 50

            onClicked: {
                // stop here
                playTimer.stop();
                playing = false;
                progreebar.currentTime = 0;
            }
        }

        PlayerButton {
            id: skipForward
            anchors.left: stop.right
            icon: "icons/skip-forward.png"
            width: 50
            height: 50

            function printObjectInfo(modelObject) {
                for(var prop in modelObject) {
                    console.debug("name: " + prop + "; value: " + modelObject[prop])
                }
            }

            onClicked: {
                if(listView.selectIndex!=-1 && !listView.showAlbum) {
                    listView.selectIndex = (listView.selectIndex + 1)%listView.count
                    listView.currentIndex = listView.selectIndex;
                    listView.currentItem.mouseArea.click();
                }
            }
        }

        Rectangle {
            id: volumeArea
            anchors.left: skipForward.right
            anchors.leftMargin: 46
            anchors.top: parent.top
            anchors.topMargin: 10
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

        Rectangle {
            id: selectAlbumButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            height: 30
            width: selectAlbumButtonText.width +10
            scale: selectAlbumButtonMouseArea.pressed? 0.9: 1

            color: "grey"
            radius: 5

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#8C8F8C" }
                GradientStop { position: 0.05; color: "#6A6D6A" }
                GradientStop { position: 0.95;color: "#3F3F3F" }
                GradientStop { position: 1.0; color: "#0e1B20" }
            }

            MouseArea {
                id: selectAlbumButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    listView.model = albumModel
                    listView.showAlbum = true;
                }
            }

            Text {
                id: selectAlbumButtonText
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Select album"
                color: "white"
            }
        }
    }

    ListView {
        id: listView

        property bool showAlbum: true
        property int selectIndex: -1;

        anchors.top: row_2.bottom
        // anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        clip: true

        delegate: Rectangle {

            property alias mouseArea: albumDelegateMouseArea

            id: albumDelegate
            width: listView.width
            height: 40
            radius: 2
            color: albumDelegateMouseArea.pressed|| (listView.selectIndex==index && !listView.showAlbum)? "lightgrey": "white"
            border.width: 2

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                // anchors.horizontalCenter: parent.horizontalCenter
                text: listView.showAlbum? albumName: songName + " - " + artist
            }

            MouseArea {
                id: albumDelegateMouseArea
                anchors.fill: parent

//                onClicked: {
//                    if(listView.showAlbum) {
//                        listView.showAlbum = false
//                        songModel.albumName = albumName;

//                        mp3Player.album = albumName;
//                        mp3Player.albumCover = albumCover;

//                        listView.model = songModel

//                        // stop
//                        playTimer.stop();
//                        playing = false;
//                        progreebar.currentTime = 0;

//                        mp3Player.songName = "";
//                        mp3Player.artist = "";
//                        mp3Player.songLenght = 0;

//                        listView.selectIndex =-1;
//                    }
//                }

                onClicked:/*onDoubleClicked*/ {

                    if(listView.showAlbum) {
                        listView.showAlbum = false
                        songModel.albumName = albumName;

                        mp3Player.album = albumName;
                        mp3Player.albumCover = albumCover;

                        listView.model = songModel

                        // stop
                        playTimer.stop();
                        playing = false;
                        progreebar.currentTime = 0;

                        mp3Player.songName = "";
                        mp3Player.artist = "";
                        mp3Player.songLenght = 0;

                        listView.selectIndex =-1;
                    }
                    else
                    {
                        click();
                    }
                }

                function click() {
                    mp3Player.songName = songName;
                    mp3Player.artist = artist;
                    mp3Player.songLenght = length;

                    // stop
                    playTimer.stop();
                    playing = false;
                    progreebar.currentTime = 0;

                    // then start
                    playTimer.start();
                    playing = true;

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
        source: "mp3.xml"
        query: "/music/album"

        XmlRole { name: "albumName"; query: "albumName/string()" }
        XmlRole { name: "albumCover"; query: "albumCover/string()" }
    }

    XmlListModel {
        id: songModel
        property string albumName;

        source: "mp3.xml"
        query: "/music/album[albumName=\"" +albumName + "\"]/song"

        XmlRole { name: "songName"; query: "name/string()" }
        XmlRole { name: "artist"; query: "artist/string()" }
        XmlRole { name: "length"; query: "length/string()" }
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
