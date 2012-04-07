import QtQuick 1.0

Rectangle {

    //identifier of the item
    id: button

    property string label: "UNKNOWN LABEL"

    //these properties act as constants, useable outside this QML file
    property int buttonHeight: 50
    property int buttonWidth: 200

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
        width: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        smooth: true
        source: "../icons/"+pictureName
    }

    Text {

        id: labelText
        x: image.x + image.width + 10

        // width: 80
        // height: 10
        text: label
        anchors.verticalCenter: parent.verticalCenter

        smooth: true
        font.bold: true

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        transformOrigin: Item.Center
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
        anchors.fill: parent
        smooth: true
        //stretch the area to the parent's dimension
        onClicked: buttonClick()
    }


    //change the color of the button when pressed
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.1) : buttonColor

}
