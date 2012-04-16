import QtQuick 1.0
import ".."

Rectangle {
    id: healthWidget
    // anchors.fill: parent
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    //anchors.top: calendar.bottom
    anchors.topMargin: 2
    border.color: "lightgrey"
    border.width: 3
    clip: true
    radius: 3

    Rectangle {
        x: 0
        y: 0
        width: healthWidget.width
        height: healthWidget.height

        Image {
            source: "pictures/healthWidget_bg.png"
        }

        XmlListModel {

            id: healthWidgetXmlModel
            source: "healthMonitor.xml"
            query: "/health/monitor"
            //current condition
            XmlRole { name: "sleepHour"; query: "sleepHour/string()" }
            XmlRole { name: "height"; query: "height/string()" }
            XmlRole { name: "weight"; query: "weight/string()" }
            XmlRole { name: "caloriesAte"; query: "caloriesAte/string()" }
        }

        Component {
            id: healthWidgetDelegate
            Rectangle {
                x: 0
                y: 0
                width: healthWidget.width;
                height: healthWidget.height;
                color: "#00000000"

                Text {
                    x: 82
                    y: 50
                    text: weight
                    font.bold: true
                    smooth: true
                    font.family: "Calibri"
                    color: "#ba081d"
                    font.pixelSize: 17
                }

                Text {
                    x: 82
                    y: 89
                    text: height
                    smooth: true
                    font.bold: true
                    font.family: "Calibri"
                    color: "#08ba36"
                    font.pixelSize: 17
                }

                Text {
                    x: 133
                    y: 128
                    text: sleepHour + " Hours"
                    font.bold: true
                    smooth: true
                    font.family: "Calibri"
                    color: "#08ba36"
                    font.pixelSize: 17
                }

                Text {
                    x: 205
                    y: 50
                    text: caloriesAte
                    smooth: true
                    font.bold: true
                    font.family: "Calibri"
                    color: "#08ba36"
                    font.pixelSize: 17
                }

                Text {
                    x: 205
                    y: 89
                    text: "852"
                    font.bold: true
                    smooth: true
                    font.family: "Calibri"
                    color: "#08ba36"
                    font.pixelSize: 17
                }
            }
        }

        ListView {

            width: healthWidget.width
            height: healthWidget.height
            model: healthWidgetXmlModel
            delegate: healthWidgetDelegate
            interactive: false
        }
    }
}
