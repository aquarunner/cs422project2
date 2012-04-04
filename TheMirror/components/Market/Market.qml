import QtQuick 1.0
import "../../common"
import "qml"

Rectangle {
    id: marketMain
    color: applicationColor
    //anchors.fill: parent
    width: 600
    height: 300
    clip: true

    property variant applicationCanvas

    onVisibleChanged: {
        if (marketMain.visible) {

            applicationCanvas.isApplicationAreaTransparent = false; // new loaded application use solid background
            applicationCanvas.showBorder = true; // show border?
            applicationCanvas.applicationAreaHeightInNumberOfCells = 12 // change the height of applicationCanvas
            applicationCanvas.applicationAreaWidthInNumberOfCells = 8 // change the width of applicationCanvas

            applicationLoder.title = "Market"
            applicationLoder.iconName = "images/Package.png"
        }
    }



    // Filter Button
    MarketButton {
        id: filterButton
        text: qsTr("Category Filter: [ none ]")

        anchors.margins: 10
        anchors.left: parent.left
        anchors.top: parent.top
        property string curFilter

        onClicked: {
            if (!filterList.visible) {
                filterList.state = "open"
            }
            else {
                filterList.state = ""
            }
        }
    }


    // Filter List including model and delegate
    ListView {
        id: filterList
        property int itemHeight: 20
        visible: false
        y: filterButton.x + filterButton.height + anchors.margins + 10
        x: filterButton.x
        z: 1
        spacing: 0
        height: 0
        width: filterButton.width

        model: ListModel {
            id: filterModel
            ListElement {
                category: "[ none ]"
            }
            ListElement {
                category: "Fun"
            }
            ListElement {
                category: "Office"
            }
            ListElement {
                category: "Productivity"
            }
            ListElement {
                category: "Social"
            }
            ListElement {
                category: "Utility"
            }
            ListElement {
                category: "Multimedia"
            }
        }

        delegate: Component {
            id: filterDelegate
            Item {
                width: filterButton.width
                height: filterList.itemHeight
                MarketButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: category
                    width: filterButton.width
                    onClicked: {
                        filterList.state = ""
                        filterButton.text = qsTr("Category Filter: " + category)
                    }
                }

            }
        }

        Behavior on height {
            NumberAnimation {
                duration: 200;
            }
        }

        states: [
            State {
                name: "open"
                PropertyChanges {
                    target: filterList
                    visible: true
                }
                PropertyChanges {
                    target: filterList
                    height: filterList.itemHeight * filterList.count
                }
            }
        ]
    }


//    ScrollIndicator {
//        id: appScroll
//        target: appList
//        scrollSide: "bottom"
//        scrollOrientation: "horizontal"
//    }

    // App List
    ListView {
        id: appList
        orientation: ListView.Horizontal
        height: parent.height * 0.6
        spacing: 40
        y: 60
        anchors {
            left: parent.left
            right: parent.right
            //verticalCenter: parent.verticalCenter
            //topMargin: 50
        }

        model: ListModel {
            id: appModel
            ListElement {
                image: "images/Package.png"
                name: "Cool App Name"
                category: ""
                author: "Joe Schmoe"
                description: "The quick brown fox jumps over the lazy dog.

The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.

The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog."
                cost: ""
                downloads: ""
            }
            ListElement {
                image: "images/Package.png"
                name: "Another Cool App"
                category: "Joe Again"
                author: ""
                description: "The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.

The quick brown fox jumps over the lazy dog.

The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog.  The quick brown fox jumps over the lazy dog."
                cost: ""
                downloads: ""
            }
            ListElement {
                image: "images/Package.png"
                name: "app"
                category: ""
                author: ""
                description: "test"
                cost: ""
                downloads: ""
            }
            ListElement {
                image: "images/Package.png"
                name: "app"
                category: ""
                author: ""
                description: ""
                cost: ""
                downloads: ""
            }
            ListElement {
                image: "images/Package.png"
                name: "app"
                category: ""
                author: ""
                description: ""
                cost: ""
                downloads: ""
            }
        }

        delegate: Component {
            id: appDelegate
            Item {
                width: 300
                height: appList.height

                Row {
                    id: appInfo
                    //spacing: 20
                    //anchors.verticalCenter: parent.verticalCenter

                    // Section 1
                    // Image, app name and author
                    Rectangle {
                        //spacing: 10
                        width: 100
                        height: appList.height
                        //anchors.verticalCenter: parent.verticalCenter
                        color: applicationColor

                        Image {
                            id: appImage
                            source: image
                            anchors.margins: 20
                            width: 64
                            height: 64
                            //anchors.bottom: appName.top
                            //anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            id: appName
                            text: name
                            font.bold: true
                            //anchors.margins: 20
                            //anchors.verticalCenter: parent.verticalCenter
                            anchors.top: appImage.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            id: appAuthor
                            text: qsTr("By: " + author)
                            anchors.top: appName.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    // Section 2
                    // App Desc, install button
                    Rectangle {
                        width: 200
                        height: appList.height
                        anchors.verticalCenter: parent.verticalCenter
                        color: applicationColor

                        // App description
                        Rectangle {
                            //anchors.verticalCenter: parent.verticalCenter
                            id: descArea
                            //color: "dark green"
                            //anchors.verticalCenter: appList.verticalCenter
                            //border.width: 1
                            //border.color: "grey"
                            color: applicationColor
                            width: 200
                            height: 100
                            anchors.left: parent.left
                            anchors.right: parent.right
                            clip: true
                            //anchors.fill: parent

                            Flickable {
                                id: descFlickable
                                anchors.fill: parent
                                contentWidth: parent.width;
                                //contentHeight: parent.height
                                contentHeight: appDescription.paintedHeight
                                flickableDirection: Flickable.VerticalFlick
                                clip: true

                                TextEdit{
                                    id: appDescription
                                    wrapMode: TextEdit.Wrap
                                    readOnly:true
                                    anchors {
                                        left: parent.left
                                        right: parent.right
                                        top: parent.top
                                        bottom: parent.bottom
                                        margins: 10
                                    }

                                    //anchors.fill: parent
                                    //anchors.margins: 10
                                    horizontalAlignment: TextEdit.AlignHCenter
                                    text: description
                                    font.italic: true
                                }
                            }
                            // App Desc Scroll Indicator
                            Rectangle {
                                id: descScroll
                                //visible: descFlickable.moving
                                anchors.top: descArea.top
                                anchors.bottom: descArea.bottom
                                anchors.right: descArea.right
                                width: 2
                                Rectangle {
                                    y: descFlickable.visibleArea.yPosition * descScroll.height
                                    width: descScroll.width
                                    height: descFlickable.visibleArea.heightRatio * descScroll.height
                                    color: "dark grey"
                                    //opacity: 0.1
                                    radius: 5
                                }
                            }
                        }

//                        Text {
//                            id: more
//                            text: qsTr("more...%1 %2").arg(appDescription.paintedHeight).arg(appDescription.height)
//                            visible: (appDescription.paintedHeight > appDescription.height) ? true : false
//                            opacity: 0.3
//                            anchors.horizontalCenter: descArea.horizontalCenter
//                            anchors.top: descArea.bottom
//                        }

                    }


                }

            }
        }

        // App List Scroll Indicator
        Rectangle {
            id: appScroll
            //visible: appList.moving
            anchors.left: appList.left
            anchors.bottom: appList.bottom
            anchors.right: appList.right
            //anchors.bottomMargin: 20
            color: "grey"
            height: 2
            Rectangle {
                x: appList.visibleArea.xPosition * appScroll.width
                height: appScroll.height
                width: appList.visibleArea.widthRatio * appScroll.width
                color: "black"
                //opacity: 0.1
                radius: 5
            }
        }

    }




    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: "Close"

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
