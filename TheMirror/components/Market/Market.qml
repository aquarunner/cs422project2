import QtQuick 1.0
import "../../common"

Rectangle {
    id: marketMain
    color: bgColor
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    property string bgColor: "khaki"

    // Filter Button
    MarketButton {
        id: filterButton
        width: 300
        property string curFilter: "none"
        text: qsTr("Filter By Category: [ %1 ]").arg(curFilter)

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
                category: "none"
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
                MarketButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.fill: parent
                    text: category
                    onClicked: {
                        filterList.state = ""
                        filterButton.curFilter = category
                    }
                }

            }
        }


        // Filter List effects


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

        model: AppListModel { id: appModel }

        delegate: Component {
            id: appDelegate
            Item {
                id: appDelegateItem
                width: parent.width
                height: 200

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
                        messageArea.showMessage(qsTr("install the application successfuully %1").arg(index))
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
                            text: description
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
            anchors.right: appList.right
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
        anchors.left: parent.left
        anchors.top: appList.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 20
        opacity: 0

        Text {
            id: marketMessage
            text: qsTr("")
            font.bold: true
            anchors.fill: parent

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
            interval: 7000
            running: false
            repeat: false
            onTriggered: messageArea.opacity = 0.0
        }

    }



    Button {
        id: closeButton
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
