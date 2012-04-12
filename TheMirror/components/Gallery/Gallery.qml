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
        id: popUp

        property int popX
        property int popY
        property string target: ""
        property int targetIndex: -1

        function show(pX, pY, pT, pI) {
            popX = pX;
            popY = pY;
            target = pT;
            targetIndex = pI

            popUp.y = pY

            popUp.state = 'show'
        }

        function hide() {
            popUp.state = ''
        }

        x: parent.width
        y: 0
        z: 2
        width: deleteButton.width
        visible: false
        //opacity: popUp.visible ? 1 : 0

        Column {
            spacing: 2
            Button {
                id: deleteButton
                label: i18n.galleryDeleteButtonText + " " + popUp.target
                width: 210
                onClicked: {
                    popUp.hide();
                    galleryList.model.remove(popUp.targetIndex);
                }
            }
            Button {
                id: renameButton
                label: i18n.galleryRenameButtonText + " " + popUp.target
                width: 210
                onClicked: {
                    popUp.hide();
                }
            }
        }

        states: [
            State {
                name: "show"
                PropertyChanges {
                    target: popUp
                    y: popUp.popY
                    x: popUp.popX
                    visible: true
                    //opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "show"
                ParallelAnimation {
                    PropertyAnimation {
                        properties: "x";
                        duration: 400;
                        easing.type: Easing.OutBounce;
                    }
                    PropertyAnimation {
                        properties: "opacity";
                        duration: 400;
                    }

                }
            }
        ]

    }
    Item {
        id: controlArea
        anchors.right: parent.right
        anchors.bottom: galleryList.top
        height: helpButton.height
        z: 1
        width: 20 + helpButton.width + cameraButton.width + quitButton.width

        Row {
            spacing: 5

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

    ListView {
        id: galleryList
        orientation: ListView.Horizontal
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 100
        spacing: 20

        //anchors.bottomMargin: 10
        //anchors.topMargin: 10

        property string photoPath: "photos/"

        model: ListModel {
            id: galleryModel

        }

        Component.onCompleted: loadPics()

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

                MouseArea {
                    id: galleryDelegateMouseArea
                    anchors.fill: parent
                    onClicked: {

                        if (popUp.visible)
                            popUp.hide();

                        if (helpText.visible)
                            helpText.visible = false;

                        if (galleryFlip.flipped) {
                            galleryFront.source = galleryList.photoPath + src
                        } else {
                            galleryBack.source = galleryList.photoPath + src
                        }
                        galleryFlip.flipped = !galleryFlip.flipped
                    }

                    onPressAndHold: {

                        if (popUp.visible)
                            popUp.hide();

                        var pX = mouseX
                        //var pX = galleryDelegate.x - (galleryList.visibleArea.xPosition * galleryList.visibleArea.widthRatio)
                        //var pX = (galleryDelegate.x > (galleryMain.width / 2)) ? galleryDelegate.x - (popUp.width / 2 ) : galleryDelegate.x + (galleryDelegate.width / 2)
                        var pY = galleryMain.height - galleryList.height - popUp.height - 60

                        popUp.show(pX, pY, src, index);
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
                        source: galleryList.photoPath + src
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    id: galleryImageText
                    text: src
                    anchors.top: imgContainer.bottom
                    anchors.horizontalCenter: imgContainer.horizontalCenter
                }
            }
        }
    }
}
