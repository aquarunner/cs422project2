import QtQuick 1.0

Rectangle {

    //identifier of the item
    id: button

    property string label: "UNKNOWN LABEL"

    //these properties act as constants, useable outside this QML file
    property int buttonHeight: 65
    property int buttonWidth: 80

    //buttonColor is set to the button's main color
    property color buttonColor: "grey"

    property string pictureName: "default.png";
    height: buttonHeight
    width: buttonWidth

    radius:10
    smooth: true

    anchors.verticalCenter: parent.verticalCenter;

    Image {
        id: image
        x: 0
        y: 0
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        source: "../icons/"+pictureName
    }

    Text {

        id: labelText

        width: 80
        height: 10
        text: label
        smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        transformOrigin: Item.Center
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        color: "white"
        font.pixelSize: 15
    }

    signal buttonClick()
    onButtonClick: {
        // console.log(labelText.text + " clicked" )
    }

    //define the clickable area to be the whole rectangle
    MouseArea{
        id: buttonMouseArea
        smooth: true
        anchors.fill: parent    //stretch the area to the parent's dimension
        onClicked: buttonClick()
    }


    //change the color of the button when pressed
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.1) : buttonColor

}
