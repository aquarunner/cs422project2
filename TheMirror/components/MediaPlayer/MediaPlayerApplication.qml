import QtQuick 1.0
import "../../common"

Rectangle {
    id: playerWindow

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50

    Rectangle {
        id: tabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        color: "lightgrey"

        property string selectedButton: "MP3"

        TabButton {
            id: mp3Button
            x: parent.x
            label: "MP3"
            selected: tabBar.selectedButton == label
            onClicked: {
                pagesListView.currentIndex = 0;
            }
        }

        TabButton {
            id: radioButton
            x: parent.x + 10 + mp3Button.width
            label: "Radio"
            selected: tabBar.selectedButton == label
            onClicked: {
                pagesListView.currentIndex = 1;
            }
        }

        TabButton {
            x: parent.x + 10 + mp3Button.width + 10 + radioButton.width
            label: "Video"
            selected: tabBar.selectedButton == label
            onClicked: {
                pagesListView.currentIndex = 2;
            }
        }
    }

    ListView{
        id: pagesListView
        anchors.fill:parent
        anchors.topMargin: tabBar.height
        anchors.bottomMargin: 55

        interactive: false
        clip: true

        model: pagesModel

        //control the movement of the menu switching
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        // flickDeceleration: 5000
        highlightFollowsCurrentItem: true
        highlightMoveDuration:100
        highlightRangeMode: ListView.NoHighlightRange
    }

    VisualItemModel {
        id: pagesModel

        Rectangle {
            id: mp3Page

            width: pagesListView.width
            height: pagesListView.height

            color: "skyblue"
        }

        Rectangle {
            id: radioPage

            width: pagesListView.width
            height: pagesListView.height

            color: "lightgreen"
        }

        Rectangle {
            id: videoPage

            width: pagesListView.width
            height: pagesListView.height

            color: "pink"
        }
    }

    Button {
        id: exit

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        label: i18n.exit

        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
