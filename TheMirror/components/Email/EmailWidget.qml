import QtQuick 1.0
import "../../common"

Rectangle {

    id: window

    color: "#00000000"
    anchors.fill: parent
    clip: true

    border.color: "grey"
    border.width: 4
    radius: 3

    property bool logined: false;

    Component.onCompleted: {
        logined = (settings.getSetting("logined", "email", "./components/Email/") == "true");
    }

    XmlListModel {
        id: mailModel
        source: "mails.xml"
        query: "/mails/mail"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "sender"; query: "sender/string()" }
        XmlRole { name: "cc"; query: "cc/string()" }
        XmlRole { name: "body"; query: "body/string()" }
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
            text: "Inbox Email"
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

        visible: logined
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 18
        font.bold: true
        font.family: "Arial"
        color: "black"
        text: "You must login in [Email] first"
        visible: !logined
    }


    VisualItemModel {
        id: pagesModel

        ListView {
            id: list
            width: window.width; height: window.height -10
            model: mailModel
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
                        text: sender+" / "+title; width: parent.width; wrapMode: Text.WordWrap
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
                        descriptionPage.descriptionText = body;
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

            Flickable {
                id: flickArea
                anchors.fill: parent
                anchors.topMargin: 15
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                contentWidth: helpText.width; contentHeight: helpText.height
                flickableDirection: Flickable.VerticalFlick
                clip: true

                Text{
                    id: helpText
                    wrapMode: TextEdit.Wrap
                    width:pagesListView.width;
                    // readOnly:true
                    font.family: "Helvetica"
                    font.pixelSize: 12
                    text:  descriptionPage.descriptionText
                }


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
