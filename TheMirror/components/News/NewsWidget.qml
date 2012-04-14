import QtQuick 1.0
import "../../common"
import "content"

Rectangle {

    id: window

    color: "#00000000"
    anchors.fill: parent
    clip: true

    border.color: "grey"
    border.width: 4
    radius: 3

    XmlListModel {
        id: feedModel
        source: "http://rss.news.yahoo.com/rss/topstories"
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "description"; query: "description/string()" }
    }


    Rectangle {
        anchors.top: window.top
        anchors.left: window.left
        anchors.right: window.right
        height: 30
        color: "lightgrey"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "News"
            font.pixelSize: 18
            font.bold: true
            font.family: "Arial"
            color: "black"

        }
    }



    ListView{
        id: pagesListView
        anchors.fill:parent
        anchors.topMargin: 30

        interactive: false

        //the model contains the data
        model: pagesModel

        //control the movement of the menu switching
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 5000
        highlightFollowsCurrentItem: true
        highlightMoveDuration:240
        highlightRangeMode: ListView.NoHighlightRange
    }


    VisualItemModel {
        id: pagesModel

        ListView {
            id: list
            width: window.width; height: window.height -10
            model: feedModel
            clip: true

            delegate: Item {
                id: delegate

                height: column.height + 13
                width: delegate.ListView.view.width

                Column {
                    id: column
                    x: 10; y: 7
                    width: parent.width -10

                    Text {
                        id: titleText
                        text: title; width: parent.width; wrapMode: Text.WordWrap
                        font { bold: true; family: "Helvetica"; pointSize: 12 }
                    }
                }

                Rectangle {
                    width: parent.width; height: 1; color: "grey"
                    anchors.bottom: parent.bottom
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        descriptionPage.descriptionText = description;
                        pagesListView.currentIndex = 1;
                    }
                }

            }

            ScrollBar { scrollArea: list; height: list.height; width: 8; anchors.right: list.right }
        }



        Rectangle {
            id: descriptionPage

            width: pagesListView.width
            height: pagesListView.height - 40

            color: "#00000000"

            property string descriptionText: ""

            Text {
                anchors.fill: parent
                anchors.topMargin: 15
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                text: descriptionPage.descriptionText
                wrapMode: Text.WordWrap; font.family: "Helvetica"
                font.pixelSize: 12
            }


            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 3
                anchors.horizontalCenter: parent.horizontalCenter
                label: i18n.back

                onClicked: {
                    pagesListView.currentIndex = 0
                }
            }

        }
    }


}
