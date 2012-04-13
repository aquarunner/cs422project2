import QtQuick 1.0
import ".."

Rectangle {
    id: weatherWidget
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
        /*Text {

            x: 0
            y: 60
            text: weatherWidget.width
            font.family: "Calibri"
            color: "#0f0f0f"
            font.pixelSize: 20
        }
        Text {

            x: 0
            y: 80
            text: weatherWidget.height
            font.family: "Calibri"
            color: "#0f0f0f"
            font.pixelSize: 20
        }*/
        x: 0
        y: 0
        width: weatherWidget.width
        height: weatherWidget.height

        Image {
            source: "pictures/weather_widget_bg.png"
        }

        XmlListModel {

            id: weatherWidgetXmlModel
            source: "http://www.google.com/ig/api?weather=chicago"
            query: "/xml_api_reply/weather/current_conditions"
            //current condition
            XmlRole { name: "condition"; query: "condition/@data/string()" }
            XmlRole { name: "temp_f"; query: "temp_f/@data/string()" }
            XmlRole { name: "humidity"; query: "humidity/@data/string()" }
            XmlRole { name: "icon"; query: "icon/@data/string()" }
            XmlRole { name: "wind_condition"; query: "wind_condition/@data/string()" }

        }

        Component {
            id: weatherWidgetDelegate
            Rectangle {
                x: 0
                y: 0
                width: weatherWidget.width;
                height: weatherWidget.height;
                color: "#00000000"

                Image{
                    x:120
                    y:10
                    source: "pictures/"+  icon.substring(icon.lastIndexOf("/"), icon.length - 4) +"_s.png"
                }
                Text {
                    id: text1
                    // x: 175
                    y: 115
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    text: condition
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 18
                }
                Text {
                    id: text2
                    x: 15
                    y: 25
                    text: temp_f + " F"
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 18
                }
                Text {
                    id: text3
                    x: 15
                    y: 45
                    text: humidity
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 18
                }
                /*Text {
                    id: text4
                    x: 130
                    y: 80
                    text: wind_condition
                    font.family: "Calibri"
                    color: "#0f0f0f"
                    font.pixelSize: 18
                }*/

            }


        }

        ListView {

            width: weatherWidget.width;
            height: weatherWidget.height;
            model: weatherWidgetXmlModel
            delegate: weatherWidgetDelegate
        }

    }

    XmlApplicationLoader {
        id: xmlApplicationLoader
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            xmlApplicationLoader.loadApplication("Weather");
            mainScreen.showMainMenuBar = false;
            mainScreen.showApplicationArea = true;
        }
    }

}
