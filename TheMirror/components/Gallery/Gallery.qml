import QtQuick 1.0
import "../../common"

Item {
    id: galleryMain
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    property string bgColor: "#00000000"
    //property string bgColor: "khaki"

    Flipable {

        front: Image {
            id: galleryFront
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            //height: parent.height
            //width: par
        }
        back: Image {
            id: galleryBack
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            //anchors.centerIn: parent
            //height: parent.height
        }

        id: galleryFlip
        anchors.top: parent.top
        anchors.bottom: galleryList.top
        //anchors.centerIn: parent
        width: parent.width
        property bool flipped: false
        property int angle: 0
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

            ListElement {
                src: "image1.jpg"
            }
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
                //anchors.centerIn: parent
                height: galleryList.height
                width: galleryList.height

                //                Rectangle {
                //                    anchors.fill: parent
                //                    color: "khaki"
                //                    //anchors.rightMargin: 50
                //                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (galleryFlip.flipped) {
                            galleryFront.source = galleryList.photoPath + src
                        } else {
                            galleryBack.source = galleryList.photoPath + src
                        }
                       galleryFlip.flipped = !galleryFlip.flipped
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
