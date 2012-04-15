import QtQuick 1.0
import "../../common"
import ".."

Item {
    id: galleryMain
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    property string bgColor: "#00000000"

    XmlApplicationLoader {
        id: xmlApplicationLoader
    }


    Item {
        id: controlArea
        anchors.right: parent.right
        anchors.rightMargin: rightMouseArea.width
        anchors.bottom: galleryList.top
        height: 300
        z: 1
        width: 20 + helpButton.width + cameraButton.width + quitButton.width

        Row {
            id: controls
            visible: (!popUp.visible && !messageArea.visible)
            opacity: controls.visible ? 1 : 0
            spacing: 5
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            Behavior on opacity {
                NumberAnimation {
                    duration: 250;
                }
            }

            Button {
                id: helpButton
                label: "?"
                width: 40
                onClicked: helpText.visible = true
            }


            Button {
                id: cameraButton
                width: helpButton.width
                height: helpButton.height
                onClicked: {
                    xmlApplicationLoader.loadApplication("Camera");
                }

                Image {
                    source: "../../icons/Application_Multimedia_Camera.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }


            Button {
                id: quitButton
                width: helpButton.width
                height: helpButton.height
                onClicked: {
                    mainScreen.showMainMenuBar = true;
                    mainScreen.showApplicationArea = false;
                }

                Image {
                    source: "../../icons/Exit.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Item {
            id: messageArea
            anchors.fill: parent
            visible: false
            opacity: visible ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                }
            }

            function show(msg) {
                message.text = msg
                //controls.visible = false
                messageArea.visible = true
                messageAreaTimer.start();
            }

            Text {
                id: message
                text: ""
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                font.bold: true
            }

            Timer {
                id: messageAreaTimer
                running: false
                repeat: false
                interval: 3000
                onTriggered: {
                    messageArea.visible = false;
                    //controls.visible = true;
                }
            }
        }

        Item {
            id: popUp

            property string target
            property int targetIndex

            function show(t, i) {
                target = t;
                targetIndex = i;
                popUp.visible = true
            }

            function hide() {
                popUp.visible = false;
            }

            //x: 0
            //y: -100
            //z: 2
            //anchors.right: parent.right
            //anchors.bottom: parent.bottom
            anchors.fill: parent
            //width: renameButton.width
            visible: false
            opacity: popUp.visible ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 250;
                }
            }

//            MouseArea {
//                id: catcher
//                width: 2560
//                height: 1000
//                x: -1280
//                y: -720
//                z: 2
//                onReleased: popUp.hide();
//                enabled: popUp.visible;
//            }


            Column {
                spacing: 2
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                Button {
                    id: deleteButton
                    label: i18n.galleryDeleteButtonText + " " + popUp.target
                    width: 250
                    onClicked: {
                        //galleryList.model.remove(popUp.targetIndex);
                        popUp.hide();
                        messageArea.show(popUp.target + " removal...");
                        //controls.visible = true;
                    }
                }
                Button {
                    id: renameButton
                    label: i18n.galleryRenameButtonText + " " + popUp.target
                    width: 250
                    onClicked: {
                        popUp.hide();
                        messageArea.show(popUp.target + " rename...");
                        //controls.visible = true;
                    }
                }
            }
        }
    }


    Item {
        id: playArea
        anchors.top: parent.top
        anchors.bottom: galleryList.top
        width: parent.width


        Text {
            id: helpText
            text: i18n.galleryHelpText
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 20
        }

        Flipable {
            id: galleryFlip
            visible: !helpText.visible
            anchors.fill: parent
            property bool flipped: false
            property int angle: 0

            front: Image {
                id: galleryFront
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }

            back: Image {
                id: galleryBack
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }

            transform: Rotation{
                origin.x: galleryFlip.width/2
                origin.y: galleryFlip.height/2
                axis.x:0; axis.y:1; axis.z:0
                angle: galleryFlip.angle
            }

            states: State {
                name: "back"
                when: galleryFlip.flipped
                PropertyChanges { target: galleryFlip; angle: 180 }
            }

            transitions: Transition {
                NumberAnimation{ property: "angle"; duration:600 }
            }
        }

    }  //  playArea

    Item {
        id: scrollLeft
        //anchors.verticalCenter: galleryList.verticalCenter
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: galleryList.height
        width: 40

        Text {
            id: left
            text: qsTr("<")
            anchors.centerIn: parent
            font.bold: true
            color: leftMouseArea.pressed ? "grey" : "black"
        }

        MouseArea {
            id: leftMouseArea
            anchors.fill: parent
            onClicked: {
                galleryList.decrementCurrentIndex();
                galleryList.positionViewAtIndex(galleryList.currentIndex, ListView.Center);
            }
        }
    }

    Item {
        id: scrollRight
        //anchors.verticalCenter: galleryList.verticalCenter
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: galleryList.height
        width: 40

        Text {
            id: right
            text: qsTr(">")
            anchors.centerIn: parent
            font.bold: true
            color: rightMouseArea.pressed ? "grey" : "black"
        }

        MouseArea {
            id: rightMouseArea
            anchors.fill: parent
            onClicked: {
                galleryList.incrementCurrentIndex();
                galleryList.positionViewAtIndex(galleryList.currentIndex, ListView.Beginning);
            }
        }
    }

    ListView {
        id: galleryList
        orientation: ListView.Horizontal
        anchors.left: scrollLeft.right
        anchors.right: scrollRight.left
        anchors.bottom: parent.bottom
        height: 100
        spacing: 20
        clip: true

        //anchors.bottomMargin: 10
        //anchors.topMargin: 10

        property string photoPath: "photos/"

        model: GalleryModel { id: galleryModel }

        //Component.onCompleted: loadPics()

        function loadPics() {
            var srcFile = ''
            var i
            for (i = 1; i < 49; ++i) {
                srcFile = qsTr("image%1.jpg").arg(i)
                galleryModel.append({src: srcFile})
            }

        }



        delegate: Component {
            Item {
                id: galleryDelegate
                height: galleryList.height
                width: galleryList.height


//                Rectangle {
//                    id: hilighter
//                    width: 30
//                    height: 5
//                    color: "grey"
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.bottom: parent.bottom
//                    visible: galleryDelegate.ListView.isCurrentItem
//                }


                MouseArea {
                    id: galleryDelegateMouseArea
                    anchors.fill: parent
                    onClicked: {

                        if (popUp.visible) {
                            popUp.hide();
                            controls.visible = true;
                        }

                        if (helpText.visible)
                            helpText.visible = false;

                        if (galleryFlip.flipped) {
                            galleryFront.source = src//galleryList.photoPath + src
                        } else {
                            galleryBack.source = src//galleryList.photoPath + src
                        }
                        galleryFlip.flipped = !galleryFlip.flipped
                    }

                    onPressAndHold: {

                        if (popUp.visible)
                            popUp.hide();

                        //controls.visible = false;
                        popUp.show(qsTr("filename %1").arg(index), index);
                    }
                }

                Item {
                    id: imgContainer
                    width: parent.width
                    height: parent.height / 2
                    anchors.centerIn: parent
                    clip: true
                    Image {
                        id: galleryImage
                        source: src//galleryList.photoPath + src
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    id: galleryImageText
                    text: qsTr("filename " + index)//src
                    anchors.top: imgContainer.bottom
                    anchors.horizontalCenter: imgContainer.horizontalCenter
                }
            }
        }
    }
}
