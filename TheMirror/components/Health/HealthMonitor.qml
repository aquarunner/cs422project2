import QtQuick 1.0

Rectangle {
    width: healthPanel.width
    height: healthPanel.height
    color: "#00000000"

    XmlListModel {

        id: healthXmlModel
        source: "healthMonitor.xml"
        query: "/health/monitor"
        //current condition
        XmlRole { name: "sleepHour"; query: "sleepHour/string()" }
        XmlRole { name: "sleepHour_w"; query: "sleepHour_w/string()" }

        XmlRole { name: "height_t"; query: "height_t/string()" }
        XmlRole { name: "height"; query: "height/string()" }
        XmlRole { name: "height_w"; query: "height_w/string()" }

        XmlRole { name: "weight_t"; query: "weight_t/string()" }
        XmlRole { name: "weight"; query: "weight/string()" }
        XmlRole { name: "weight_w"; query: "weight_w/string()" }

        XmlRole { name: "temperature_t"; query: "temperature_t/string()" }
        XmlRole { name: "temperature"; query: "temperature/string()" }
        XmlRole { name: "temperature_w"; query: "temperature_w/string()" }

        XmlRole { name: "heartBeat_t"; query: "heartBeat_t/string()" }
        XmlRole { name: "heartBeat"; query: "heartBeat/string()" }
        XmlRole { name: "heartBeat_w"; query: "heartBeat_w/string()" }
        XmlRole { name: "heartBeatImg"; query: "heartBeatImg/string()" }

        XmlRole { name: "caloriesBurn_t"; query: "caloriesBurn_t/string()" }
        XmlRole { name: "caloriesBurn"; query: "caloriesBurn/string()" }
        XmlRole { name: "caloriesBurn_w"; query: "caloriesBurn_w/string()" }

        XmlRole { name: "caloriesAte_t"; query: "caloriesAte_t/string()" }
        XmlRole { name: "caloriesAte"; query: "caloriesAte/string()" }
        XmlRole { name: "caloriesAte_w"; query: "caloriesAte_w/string()" }

    }

    Component {
        id: healthDelegate
        Rectangle {
            x: 0
            y: 0
            width: healthPanel.width;
            height: healthPanel.height;
            color: "#ffffff"

            Rectangle {
                x: healthPanel.width - 110
                y: 20
                width: 80
                height: 80
                color: "#00000000"
                Image {
                    source: "pictures/reportIcon.png"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        healthM.visible = false
                        healthR.visible = true
                    }
                }

            }

            Rectangle {
                x: 60
                y: 0
                width: 400
                height: 410
                color: "#00000000"
                Text {
                    x: 0
                    y: 20
                    text: "Hours since your last be here:"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 60
                    text: "Your current " + height_t + ":"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 100
                    text: "Your current " + weight_t + ":"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }

                Text {
                    x: 0
                    y: 140
                    text: "Your current " + temperature_t + ":"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 180
                    text: "Your current " + heartBeat_t + ":"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }

                Image {
                    x: 5
                    y: 220

                    source: "pictures/" + heartBeatImg

                }

                Text {
                    x: 0
                    y: 320
                    text: caloriesBurn_t + " in last 24 hours:"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 360
                    text: caloriesAte_t + " in last 24 hours:"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
            }

            Rectangle {
                x: 420
                y: 0
                width: 200
                height: 410
                color: "#00000000"
                Text {
                    x: 0
                    y: 20
                    text: sleepHour + " Hours(s)"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 60
                    text: height + " Feet"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 100
                    text: weight + " Pounds"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }

                Text {
                    x: 0
                    y: 140
                    text: temperature + " F"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 180
                    text: heartBeat + " BMP"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }

                Text {
                    x: 0
                    y: 320
                    text: caloriesBurn + " Calories"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 360
                    text: caloriesAte + " Calories"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 20
                }
            }


            Rectangle {
                x: 620
                y: 0
                width: 150
                height: 410
                color: "#00000000"
                Text {
                    x: 0
                    y: 20
                    text: sleepHour_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 60
                    text: height_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 100
                    text: weight_w
                    font.family: "Calibri"
                    color: "#b61b1b"
                    font.pixelSize: 23
                }

                Text {
                    x: 0
                    y: 140
                    text: temperature_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 180
                    text: heartBeat_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }

                Text {
                    x: 0
                    y: 320
                    text: caloriesBurn_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }
                Text {
                    x: 0
                    y: 360
                    text: caloriesAte_w
                    font.family: "Calibri"
                    color: "#1bb64e"
                    font.pixelSize: 20
                }
            }

        }


    }

    ListView {

        width: healthPanel.width
        height: healthPanel.height
        model: healthXmlModel
        delegate: healthDelegate
        interactive: false
    }
}
