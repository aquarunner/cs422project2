import QtQuick 1.0
import "../../common"

Item {
    id: trafficMain
    anchors.fill: parent
    clip: true

    Item {
        id: searchArea
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: mapArea.left
        anchors.margins: 5
        height: 30

        Rectangle {
            radius: 4
            anchors.fill: parent
        }

        TextEdit {
            id: searchText
            text: i18n.trafficSearchText
            color: "lightsteelblue"
            font.italic: true
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            onActiveFocusChanged: {
                if (searchText.activeFocus) {
                    searchText.text = "";
                } else {
                    searchText.text = i18n.search;
                }
            }

            Keys.onReturnPressed: {
                search();
            }

            Keys.onEnterPressed: {
                search();
            }


            function search() {
                map.address = searchText.text;
                recentModel.insert(0, {recentAddress: searchText.text})
                searchText.text = "";
            }
        }
    }



    ListView {
        id: recentList
        anchors.left: parent.left
        anchors.right: mapArea.left
        anchors.top: searchArea.bottom
        anchors.bottom: clearButton.top
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 5
        clip: true

        model: ListModel {
            id: recentModel

            ListElement {
                recentAddress: "City Hall, New York City"
            }
            ListElement {
                recentAddress: "Cambridge, MA"
            }
            ListElement {
                recentAddress: "850 S Morgan Street, Chicago, IL"
            }
        }

        delegate: Item {
            id: recentDelegate
            width: 180
            height: 60

            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: recentBg
                source: "bubble.png"
                anchors.fill: parent
                opacity: recentMouseArea.pressed ? 1 : 0.5
            }

            Text {
                id: recentText
                text: recentAddress
                anchors.centerIn: parent
                anchors.margins: 10
                width: parent.width * 0.7
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                font.bold: true
            }

            MouseArea {
                id: recentMouseArea
                anchors.fill: parent

                onClicked: {
                    map.address = recentAddress;
                }
            }
        }
    }

    Item {
        id: mapArea
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 5
        width: 500
        height: 350

        Map {
            id: map
            address: "Chicago"
        }
    }

    Button {
        id: clearButton
        label: i18n.trafficClearRecent
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        pixelSize: 12
        width: searchArea.width
        height: 40

        onClicked: {
            recentModel.clear();
        }
    }

    Button {
        visible: false;
        id: helpButton
        label: (helpButton.width < 50 )?"?":i18n.help
        anchors.right: closeButton.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        //width: 40

        onClicked: {
            trafficFlip.state = "back";
        }
    }

    Button {
        id: closeButton
        label: i18n.close
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
