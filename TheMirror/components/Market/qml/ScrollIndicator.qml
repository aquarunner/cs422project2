import QtQuick 1.0

// Description text scroll indicator
Rectangle {

    id: scrollArea

    property variant target: ""
    property string scrollColor: "grey"
    property string scrollSide: 'right'
    property int scrollRadius: 5
    property double scrollOpacity: 0.1
    property double scrollWidth: 2
    property variant scrollOrientation: 'vertical'

    visible: target.moving
    color: scrollColor
    width: scrollWidth
    //anchors.margins: 10

    // Scroll Bar
    Rectangle {
        y: descFlickable.visibleArea.yPosition * descScroll.height
        width: descScroll.width
        height: descFlickable.visibleArea.heightRatio * descScroll.height
        color: "dark grey"
        //opacity: 0.1
        radius: 5
    }

    onVisibleChanged: {
        if (!visible) {
            return;
        }

        if (scrollSide == 'left') {
            anchors.top = target.top
            anchors.bottom = target.bottom
            anchors.left = target.left
        }

        if (scrollSide == 'right') {
            anchors.top = target.top
            anchors.bottom = target.bottom
            anchors.right = target.right
        }

        if (scrollSide == 'top') {
            anchors.top = target.top
            anchors.right = target.right
            anchors.left = target.left
        }

        if (scrollSide == 'bottom') {
            anchors.bottom = target.bottom
            anchors.right = target.right
            anchors.left = target.left
        }
    }
}
