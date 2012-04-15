import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 50

    Rectangle {
        id: dressingPanel
        x: 0
        y: 0
        width: parent.width
        height: parent.height - 50
        color: "#00000000"

        Rectangle {
            x: 0
            y: 0
            width: dressingPanel.width
            height: dressingPanel.height
            Text {
                text: dressingPanel.width + "     " + dressingPanel.height
            }
            Rectangle {
                x: 0
                y: 0
                width: 520
                height: dressingPanel.height
                color: "#00000000"
                Image{
                    z: -10
                    source: "pictures/bg.png"
                }

                Image {
                    id: hatImg
                    x: 0
                    y: 0
                    source: "pictures/empty.png"

                }
                Image {
                    id: glassImg
                    x: 0
                    y: 0
                    source: "pictures/empty.png"

                }
                Image {
                    id: topImg
                    x: 0
                    y: 0
                    source: "pictures/empty.png"

                }
                Image {
                    id: necklessImg
                    x: 0
                    y: 0
                    source: "pictures/empty.png"

                }
                Image {
                    id: earringImg
                    x: 0
                    y: 0
                    source: "pictures/empty.png"

                }
            }

            Rectangle {
                x: 520
                y: 0
                width: 299
                height: dressingPanel.height
                color: "#a1a1a1"
                Rectangle {
                    x: 0
                    y: 1
                    width: 246
                    height: 82
                    color: "#00000000"
                    Image {
                        source: "pictures/dressing_box_frame.png"
                    }


                    GridView {

                        id: hatGrid
                        width: 246

                        boundsBehavior: Flickable.DragOverBounds
                        flickableDirection: Flickable.HorizontalFlick
                        interactive: false
                        anchors {
                            topMargin: 0; bottomMargin: 0
                            leftMargin: 0; rightMargin: 0
                            fill: parent
                        }


                        cellWidth: 82; cellHeight: 82;
                        model: HatModel {id: ico }
                        delegate: HatIconItem { }
                        MouseArea {

                                        property int currentId: -1                       // Original position in model
                                        property int newIndex                            // Current Position in model
                                        property int index: grid.indexAt(mouseX, mouseY) // Item underneath cursor
                                        id: loc
                                        anchors.fill: parent
                                        property bool startDrag: false;

                                        onPressAndHold: {
                                            currentId = ico.get(newIndex = index).gridId
                                            console.log(currentId);
                                            startDrag = true;
                                        }

                                        onReleased: {
                                            currentId = -1
                                            startDrag = false
                                        }

                                        onMousePositionChanged: {
                                            if(!startDrag) {
                                                return;
                                            }

                                            if (mouseX >= 1 )
                                            {
                                                if (loc.currentId != -1 && index != -1 && index != newIndex)

                                                    ico.move(newIndex, newIndex = index, 1)
                                            }
                                            else {

                                                hatImg.source = "pictures/hat" + (currentId+1) + "_b.png"
                                            }
                                        }
                                    }
                    }

                }

                Rectangle {
                    x: 0
                    y: 82
                    width: 246
                    height: 82
                    color: "#00000000"
                    Image {
                        source: "pictures/dressing_box_frame.png"
                    }

                    GridView {

                        id: glassGrid
                        width: 246

                        boundsBehavior: Flickable.DragOverBounds
                        flickableDirection: Flickable.HorizontalFlick
                        interactive: false
                        anchors {
                            topMargin: 0; bottomMargin: 0
                            leftMargin: 0; rightMargin: 0
                            fill: parent
                        }


                        cellWidth: 82; cellHeight: 82;
                        model: GlassModel {id: icoGlass }
                        delegate: GlassIconItem { }
                        MouseArea {

                                        property int currentId: -1                       // Original position in model
                                        property int newIndex                            // Current Position in model
                                        property int index: grid.indexAt(mouseX, mouseY) // Item underneath cursor
                                        id: locGlass
                                        anchors.fill: parent
                                        property bool startDrag: false;

                                        onPressAndHold: {
                                            currentId = icoGlass.get(newIndex = index).gridId
                                            console.log(currentId);
                                            startDrag = true;
                                        }

                                        onReleased: {
                                            currentId = -1
                                            startDrag = false
                                        }

                                        onMousePositionChanged: {
                                            if(!startDrag) {
                                                return;
                                            }

                                            if (mouseX >= 1 )
                                            {
                                                if (locGlass.currentId != -1 && index != -1 && index != newIndex)

                                                    icoGlass.move(newIndex, newIndex = index, 1)
                                            }
                                            else {

                                                glassImg.source = "pictures/glass" + (currentId+1) + "_b.png"
                                            }
                                        }
                                    }
                    }


                }
                Rectangle {
                    x: 0
                    y: 164
                    width: 246
                    height: 82
                    color: "#00000000"

                    Image {
                        source: "pictures/dressing_box_frame.png"
                    }

                    GridView {

                        id: topGrid
                        width: 246

                        boundsBehavior: Flickable.DragOverBounds
                        flickableDirection: Flickable.HorizontalFlick
                        interactive: false
                        anchors {
                            topMargin: 0; bottomMargin: 0
                            leftMargin: 0; rightMargin: 0
                            fill: parent
                        }


                        cellWidth: 82; cellHeight: 82;
                        model: TopModel {id: iocTop }
                        delegate: TopIconItem { }
                        MouseArea {

                                        property int currentId: -1                       // Original position in model
                                        property int newIndex                            // Current Position in model
                                        property int index: grid.indexAt(mouseX, mouseY) // Item underneath cursor
                                        id: locTop
                                        anchors.fill: parent
                                        property bool startDrag: false;

                                        onPressAndHold: {
                                            currentId = iocTop.get(newIndex = index).gridId
                                            console.log(currentId);
                                            startDrag = true;
                                        }

                                        onReleased: {
                                            currentId = -1
                                            startDrag = false
                                        }

                                        onMousePositionChanged: {
                                            if(!startDrag) {
                                                return;
                                            }

                                            if (mouseX >= 1 )
                                            {
                                                if (locTop.currentId != -1 && index != -1 && index != newIndex)

                                                    iocTop.move(newIndex, newIndex = index, 1)
                                            }
                                            else {

                                                topImg.source = "pictures/top" + (currentId+1) + "_b.png"
                                            }
                                        }
                                    }
                    }



                }
                Rectangle {
                    x: 0
                    y: 246
                    width: 246
                    height: 82
                    color: "#00000000"

                    Image {
                        source: "pictures/dressing_box_frame.png"
                    }

                    GridView {

                        id: earringGrid
                        width: 246

                        boundsBehavior: Flickable.DragOverBounds
                        flickableDirection: Flickable.HorizontalFlick
                        interactive: false
                        anchors {
                            topMargin: 0; bottomMargin: 0
                            leftMargin: 0; rightMargin: 0
                            fill: parent
                        }


                        cellWidth: 82; cellHeight: 82;
                        model: EarringModel {id: icoEarring }
                        delegate: EarringIconItem { }
                        MouseArea {

                                        property int currentId: -1                       // Original position in model
                                        property int newIndex                            // Current Position in model
                                        property int index: grid.indexAt(mouseX, mouseY) // Item underneath cursor
                                        id: locEarring
                                        anchors.fill: parent
                                        property bool startDrag: false;

                                        onPressAndHold: {
                                            currentId = icoEarring.get(newIndex = index).gridId
                                            console.log(currentId);
                                            startDrag = true;
                                        }

                                        onReleased: {
                                            currentId = -1
                                            startDrag = false
                                        }

                                        onMousePositionChanged: {
                                            if(!startDrag) {
                                                return;
                                            }

                                            if (mouseX >= 1 )
                                            {
                                                if (locEarring.currentId != -1 && index != -1 && index != newIndex)

                                                    icoEarring.move(newIndex, newIndex = index, 1)
                                            }
                                            else {

                                                earringImg.source = "pictures/earring" + (currentId+1) + "_b.png"
                                            }
                                        }
                                    }
                    }



                }
                Rectangle {
                    x: 0
                    y: 328
                    width: 246
                    height: 82
                    color: "#00000000"
                    Rectangle {
                        x:0
                        y:5
                        height:82
                        width:82
                        color: "#00000000"
                        Image {
                            source: "pictures/clear_btn.png"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                hatImg.source = "pictures/empty.png"
                                glassImg.source = "pictures/empty.png"
                                topImg.source = "pictures/empty.png"
                                earringImg.source = "pictures/empty.png"
                                necklessImg.source = "pictures/empty.png"
                            }
                        }

                    }

                    Rectangle {
                        x:82
                        y:5
                        height:82
                        width:82
                        color: "#00000000"
                        Image {
                            source: "pictures/recommand_btn.png"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                hatImg.source = "pictures/empty.png"
                                glassImg.source = "pictures/glass3_b.png"
                                topImg.source = "pictures/top2_b.png"
                                earringImg.source = "pictures/earring3_b.png"
                                necklessImg.source = "pictures/neck2_b.png"
                            }
                        }

                    }


                }
                Rectangle {
                    x:246
                    y:0
                    width: 53
                    height: dressingPanel.height
                    color: "#a1a1a1"
                    Image {
                        x:0
                        y:0
                        source: "pictures/hat_icon.png"
                    }
                    Image {
                        x:0
                        y:82
                        source: "pictures/glass_icon.png"
                    }
                    Image {
                        x:0
                        y:164
                        source: "pictures/top_icon.png"
                    }
                    Image {
                        x:0
                        y:246
                        source: "pictures/earring_icon.png"
                    }

                }


            }
        }

    }


    Button {
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
