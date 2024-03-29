import QtQuick 1.0
import "../../common"

Rectangle {
    id: marketMain
    color: bgColor
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    property string bgColor: "#00000000"

    function help() {
        marketFlip.state = 'back';
    }

    Flipable {
        id: marketFlip
        anchors.fill: parent

        property int angle: 0

        front: Item {
            anchors.fill: parent

            // Filter Button
            Button {
                id: filterButton
                width: 300
                property string curFilter: "All"
                //property string buttonLabel: i18n.marketCategoryButtonText
                //text: appList.count + i18n.marketCategoryButtonText + curFilter
                label: appList.count + i18n.marketCategoryButtonText + curFilter
                pixelSize: 12

                anchors.margins: 10
                anchors.left: parent.left
                anchors.top: parent.top

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
                spacing: 5
                height: 0
                width: filterButton.width


                // Filter Model
                model: ListModel {
                    id: filterModel
                    ListElement {
                        category: "All"
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

                // Filter Delegate
                delegate: Component {
                    id: filterDelegate
                    Item {
                        width: filterButton.width
                        height: filterList.itemHeight
                        Button {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.fill: parent
                            pixelSize: filterButton.pixelSize
                            //text: category
                            label: category
                            onClicked: {
                                filterList.state = ""
                                filterButton.curFilter = category

                                switch(index) {
                                case 0:
                                    appList.model = appModel.all
                                    break
                                case 1:
                                    appList.model = appModel.fun
                                    break
                                case 2:
                                    appList.model = appModel.office
                                    break
                                case 3:
                                    appList.model = appModel.productivity
                                    break
                                case 4:
                                    appList.model = appModel.social
                                    break
                                case 5:
                                    appList.model = appModel.utility
                                    break
                                case 6:
                                    appList.model = appModel.multimedia
                                    break
                                }
                            }
                        }

                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 100;
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
                            height: (filterList.itemHeight + filterList.spacing) * filterList.count
                        }
                    }
                ]
            }


            // App List and Delegate
            ListView {
                id: appList
                anchors.fill: parent
                anchors.topMargin: filterButton.height + 20
                anchors.bottomMargin: closeButton.height + 20
                spacing: 20
                clip: true

                AppListModels { id: appModel }

                model: appModel.all

                delegate: Component {
                    id: appDelegate
                    Item {
                        id: appDelegateItem
                        width: parent.width
                        height: 200

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 200;
                            }
                        }

                        // image, app name and author layout
                        Column {
                            id: appImageCol
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.leftMargin: 50

                            Image {
                                id: appImage
                                source: image
                                width: 100
                                height: 100
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                id: appName
                                text: name
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                id: appAuthor
                                text: qsTr("By: " + author)
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        MarketButton {
                            id: installButton
                            text: qsTr("Install")
                            anchors.top: descArea.bottom
                            width: 200
                            anchors.topMargin: 20
                            anchors.horizontalCenter: descArea.horizontalCenter

                            onClicked: {
                                messageArea.showMessage(qsTr("%1 application installed successfuully").arg(name))
                                appDelegateItem.opacity = 0
                                installButtonTimer.start()
                            }

                            Timer {
                                id: installButtonTimer
                                interval: 250
                                running: false
                                repeat: false
                                onTriggered: {
                                    appList.model.remove(index)
                                }
                            }


                        }


                        // App description
                        Rectangle {
                            id: descArea
                            color: bgColor
                            width: 200
                            height: 100
                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            clip: true

                            Flickable {
                                id: descFlickable
                                anchors.fill: parent
                                contentWidth: parent.width;
                                contentHeight: appDescription.paintedHeight
                                flickableDirection: Flickable.VerticalFlick
                                clip: true

                                TextEdit{
                                    id: appDescription
                                    horizontalAlignment: TextEdit.AlignHCenter
                                    text: appModel.blurbs
                                    font.italic: true
                                    wrapMode: TextEdit.Wrap
                                    readOnly: true
                                    anchors {
                                        left: parent.left
                                        right: parent.right
                                        top: parent.top
                                        bottom: parent.bottom
                                        margins: 10
                                    }

                                }

                            }

                            Image {
                                anchors { right: parent.right; top: parent.top }
                                source: "images/up.png"
                                opacity: descFlickable.atYBeginning ? 0 : 1
                            }

                            Image {
                                anchors { right: parent.right; bottom: parent.bottom }
                                source: "images/down.png"
                                opacity: descFlickable.atYEnd ? 0 : 1
                            }
                        }
                    }  //  delegate
                }

                // App List Scroll Indicator
                Rectangle {
                    id: appScroll
                    anchors.top: appList.top
                    anchors.bottom: appList.bottom
                    anchors.left: appList.left
                    color: "grey"
                    width: 2
                    Rectangle {
                        y: appList.visibleArea.yPosition * appScroll.height
                        width: appScroll.width
                        height: appList.visibleArea.heightRatio * appScroll.height
                        color: "black"
                        radius: 5
                    }
                }

            }



            // Message Area
            Item {
                id: messageArea
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.left: filterButton.right
                anchors.bottom: appList.top
                opacity: 0

                Text {
                    id: marketMessage
                    text: qsTr("")
                    font.bold: true
                    anchors.fill: parent
                    anchors.margins: 30
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }


                Behavior on opacity {
                    NumberAnimation {
                        duration: 200;
                    }
                }

                function showMessage(message)
                {
                    if (messageTimer.running)
                        messageTimer.stop()

                    marketMessage.text = message
                    messageArea.opacity = 1.0
                    messageTimer.start()
                }

                Timer {
                    id: messageTimer
                    interval: 5000
                    running: false
                    repeat: false
                    onTriggered: messageArea.opacity = 0.0
                }

            }



            // Search Area
            Rectangle {
                id: searchArea
                color: "white"
                width: 250
                height: 30
                anchors.left: parent.left
                //anchors.bottom: parent.bottom
                anchors.verticalCenter: closeButton.verticalCenter
                anchors.margins: 20
                radius: 5
                TextEdit {
                    id: searchEdit
                    text: i18n.search
                    font.italic: true
                    anchors.right: parent.right
                    width: parent.width - 10
                    anchors.verticalCenter: parent.verticalCenter


                    onActiveFocusChanged: {
                        if (searchEdit.activeFocus) {
                            text = ""
                        } else
                            text = i18n.search
                    }
                }
            }


            // Help Button
            Button {
                visible: false
                id: helpButton
                anchors.right: closeButton.left
                anchors.verticalCenter: closeButton.verticalCenter
                anchors.rightMargin: 20
                label: "?"
                width: 40

                onClicked: marketFlip.state = 'back'
            }


            Button {
                id: closeButton
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.close

                onClicked: {
                    mainScreen.showMainMenuBar = true;
                    mainScreen.showApplicationArea = false;
                }
            }

        }

        back: Item {
            anchors.fill: parent

            Text {
                id: helpText
                font.bold: true
                anchors.centerIn: parent
                width: parent.width / 2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft

                text: i18n.marketHelpText
            }

            Button {
                id: backButton
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.done

                onClicked: {
                    marketFlip.state = ''
                }
            }


        }

        transform: Rotation{
            origin.x: marketFlip.width/2;
            origin.y: marketFlip.height/2
            axis.x:0; axis.y:1; axis.z:0
            angle: marketFlip.angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: marketFlip; angle: 180 }
        }

        transitions: Transition {
            NumberAnimation{ property: "angle"; duration:600 }
        }


    }
}
