import QtQuick 1.0
import "../../common"

Rectangle {

    id: page

    ListView{
        id: listView
        anchors.fill:parent
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
        clip: true
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

    VisualItemModel {
        id: pagesModel

        ListView {
            id: mailList
            width: listView.width
            height: listView.height
            model: mailModel

            //            delegate: Rectangle {
            //                height: mailList.height
            //                width: mailList.width
            //                color: "skyblue"
            //            }

            delegate: Item {
                id: delegate
                height: column.height + 40
                width: delegate.ListView.view.width

                Column {
                    id: column
                    x: 20; y: 20
                    width: parent.width - 40

                    Text {
                        id: senderText
                        text: sender + " / " + title; width: parent.width; // wrapMode: Text.WordWrap
                        font { bold: true; family: "Helvetica"; pointSize: 10 }
                    }

                    Text {
                        id: descriptionText
                        width: parent.width; text: body.replace("\n"," ").substring(0, 80) + "..."
                        /*wrapMode: Text.WordWrap;*/ font.family: "Helvetica"
                    }
                }

                Rectangle {
                    width: parent.width; height: 1; color: "#cccccc"
                    anchors.bottom: parent.bottom
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        detailPage.sender = sender;
                        detailPage.cc = cc;
                        detailPage.body = body;

                        listView.currentIndex = 1;
                        emailWindow.pageView = listView;
                    }
                }
            }
        }

        Rectangle {
            property string sender: "";
            property string cc: "";
            property string body: "";

            id: detailPage
            width: listView.width
            height: listView.height


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
                    text:  "Sender: "+detailPage.sender+"\nCC: "+detailPage.cc+"\n\n\n"+detailPage.body
                }
            }
        }
    }
}
