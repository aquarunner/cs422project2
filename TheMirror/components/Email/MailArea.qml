import QtQuick 1.0

Rectangle {

    property alias pagesListView: pagesListView

    ListView{
        id: pagesListView
        anchors.fill:parent
        interactive: false

        //the model contains the data
        model: pagesModel

        //control the movement of the menu switching
        snapMode: ListView.SnapOneItem
        orientation: ListView.Vertical
        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 5000
        highlightFollowsCurrentItem: true
        highlightMoveDuration:240
        highlightRangeMode: ListView.NoHighlightRange
        clip: true
    }

    VisualItemModel {
        id: pagesModel


        Page {
            id: inboxPage
            width: pagesListView.width
            height: pagesListView.height
        }

        NewEmailPage {
            id: newEmailPage
            width: pagesListView.width
            height: pagesListView.height
        }

        /*Page*/Rectangle {
            id: sentPage
            width: pagesListView.width
            height: pagesListView.height
        }

        /*Page*/Rectangle {
            id: draftPage
            width: pagesListView.width
            height: pagesListView.height
        }
    }

}
