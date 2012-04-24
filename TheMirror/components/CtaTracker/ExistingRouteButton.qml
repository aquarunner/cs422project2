import QtQuick 1.0

Rectangle {

    id: wrapper

    property variant listView;
    property int fontSize: 22

    width: listView.width
    height: 70

    color: mouseArea.pressed? "lightgrey": "#00000000"
    border.color: "white"
    border.width: 3

    signal clicked

    property bool showCheckBox: false

    Text {
        id: titleArea
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        x: listView.width/25
        height: 20
        width: parent.width - 10
        text: routeID
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: fontSize
        font.bold: true
        font.family: "Arial"
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            parent.clicked();
        }
    }

    property bool checked: false;

    Image {
        id: checkIcon
        anchors.right: wrapper.right
        anchors.rightMargin: 10
        anchors.verticalCenter: wrapper.verticalCenter
        source: checked? "icons/ICON_checkbox-d.gif": "icons/ICON_checkbox-u.gif"
        smooth: true
        visible: showCheckBox
    }

    MouseArea {
        id: checkArea
        anchors.fill: checkIcon
        visible: showCheckBox

        onClicked: {
            wrapper.checked = !wrapper.checked;
            var checkedIndicesCopy = currentTrackingPage.checkedIndices;
            if(wrapper.checked) {
                checkedIndicesCopy[index*1] = true;
                // console.log("T:["+index+"]"+checkedIndicesCopy[index*1])
                currentTrackingPage.numberOfChecked++;
            }else {
                checkedIndicesCopy[index*1] = false;
                // console.log("F:["+index+"]"+checkedIndicesCopy[index*1])
                currentTrackingPage.numberOfChecked--;
            }

            currentTrackingPage.checkedIndices = checkedIndicesCopy
        }
    }
}
