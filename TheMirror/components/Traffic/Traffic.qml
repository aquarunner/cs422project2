import QtQuick 1.0
import "../../common"

Item {
    id: trafficMain
    //color: bgColor
    anchors.fill: parent
    anchors.topMargin: 55
    clip: true

    property string bgColor: "#00000000"

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
            text: "search (translate)"
            font.italic: true
            //anchors.fill: parent
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            onActiveFocusChanged: {
                if (searchText.activeFocus) {
                    searchText.text = "";
                } else {
                    searchText.text = "translate...";
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
                recentModel.insert(0, {address: searchText.text})
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
                address: "City Hall, New York City"
            }
            ListElement {
                address: "Oak Park, IL"
            }
            ListElement {
                address: "850 S Morgan Street, Chicago, IL"
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
                text: address
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
                    map.address = address;
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
        label: "translate"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10

        onClicked: {
            recentModel.clear();
        }
    }

    Button {
        id: helpButton
        label: "?"
        anchors.right: closeButton.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 40
    }

    Button {
        id: closeButton
        label: "Translate"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onClicked: {
            mainScreen.showMainMenuBar = true;
            mainScreen.showApplicationArea = false;
        }
    }
}
