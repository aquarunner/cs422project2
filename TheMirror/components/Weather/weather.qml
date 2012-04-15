import QtQuick 1.0
import "../../common"

Rectangle {

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 55

    Rectangle {
        id: weatherPanel
        x: 0
        y: 0
        width: parent.width
        height: parent.height - 55
        color: "#f0f0f0"

        Rectangle {
            x: 0
            y: 0
            width: weatherPanel.width;
            height: weatherPanel.height;
            color: "#0f0f0f"
            Image {
                source: "pictures/chicago_weather_bg.png";
            }

            Rectangle {
                id: weatherCurrentCondition
                x: (weatherPanel.width / 3)
                y: 0
                width:(weatherPanel.width / 3) + (weatherPanel.width / 3);
                height: weatherPanel.height / 2;
                color: "#00000000"

                XmlListModel {

                    id: weatherCurrentConditionXmlModel
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
                    id: weatherCurrentConditionPanelDelegate
                    Rectangle {
                        x: 0
                        y: 0
                        width: weatherPanel.width / 3;
                        height: weatherPanel.height / 2;
                        color: "#00000000"

                        Image{
                            x:10
                            y:0
                            source: "pictures/"+  icon.substring(icon.lastIndexOf("/"), icon.length - 4) +".png"
                        }
                        Text {
                            id: text1
                            x: 280
                            y: 20
                            text: condition
                            font.family: "Calibri"
                            color: "#0f0f0f"
                            font.pixelSize: 20
                        }
                        Text {
                            id: text2
                            x: 280
                            y: 60
                            text: temp_f + " F"
                            font.family: "Calibri"
                            color: "#0f0f0f"
                            font.pixelSize: 20
                        }
                        Text {
                            id: text3
                            x: 280
                            y: 100
                            text: humidity
                            font.family: "Calibri"
                            color: "#0f0f0f"
                            font.pixelSize: 20
                        }
                        Text {
                            id: text4
                            x: 280
                            y: 140
                            text: wind_condition
                            font.family: "Calibri"
                            color: "#0f0f0f"
                            font.pixelSize: 20
                        }

                    }


                }

                ListView {

                    width: weatherCurrentCondition.width;
                    height: weatherCurrentCondition.height;
                    model: weatherCurrentConditionXmlModel
                    delegate: weatherCurrentConditionPanelDelegate
                    interactive: false
                }

            }



            Rectangle {

                x: 0
                y: weatherPanel.height / 2
                width: weatherPanel.width;
                height: weatherPanel.height;
                color: "#00000000"

                XmlListModel {

                    id: weatherForecastXmlModel
                    property int index
                    source: "http://www.google.com/ig/api?weather=chicago"
                    query: "/xml_api_reply/weather"
                    XmlRole { name: "day_of_week1"; query: "forecast_conditions[1]/day_of_week/@data/string()" }
                    XmlRole { name: "low_f_s1"; query: "forecast_conditions[1]/low/@data/string()" }
                    XmlRole { name: "high_f_s1"; query: "forecast_conditions[1]/high/@data/string()" }
                    XmlRole { name: "icon_s1"; query: "forecast_conditions[1]/icon/@data/string()" }
                    XmlRole { name: "condition_s1"; query: "forecast_conditions[1]/condition/@data/string()" }

                    XmlRole { name: "day_of_week2"; query: "forecast_conditions[2]/day_of_week/@data/string()" }
                    XmlRole { name: "low_f_s2"; query: "forecast_conditions[2]/low/@data/string()" }
                    XmlRole { name: "high_f_s2"; query: "forecast_conditions[2]/high/@data/string()" }
                    XmlRole { name: "icon_s2"; query: "forecast_conditions[2]/icon/@data/string()" }
                    XmlRole { name: "condition_s2"; query: "forecast_conditions[2]/condition/@data/string()" }

                    XmlRole { name: "day_of_week3"; query: "forecast_conditions[3]/day_of_week/@data/string()" }
                    XmlRole { name: "low_f_s3"; query: "forecast_conditions[3]/low/@data/string()" }
                    XmlRole { name: "high_f_s3"; query: "forecast_conditions[3]/high/@data/string()" }
                    XmlRole { name: "icon_s3"; query: "forecast_conditions[3]/icon/@data/string()" }
                    XmlRole { name: "condition_s3"; query: "forecast_conditions[3]/condition/@data/string()" }

                    XmlRole { name: "day_of_week4"; query: "forecast_conditions[4]/day_of_week/@data/string()" }
                    XmlRole { name: "low_f_s4"; query: "forecast_conditions[4]/low/@data/string()" }
                    XmlRole { name: "high_f_s4"; query: "forecast_conditions[4]/high/@data/string()" }
                    XmlRole { name: "icon_s4"; query: "forecast_conditions[4]/icon/@data/string()" }
                    XmlRole { name: "condition_s4"; query: "forecast_conditions[4]/condition/@data/string()" }

                }

                Component {
                    id: weatherForecastPanelDelegate
                    Rectangle
                    {
                        x: 0
                        y: 0
                        width: weatherPanel.width;
                        height: weatherPanel.height / 2;
                        color: "#00000000"
                        Rectangle {
                            // forecast1

                            x: 0
                            y: 0
                            width: weatherPanel.width / 4;
                            height: weatherPanel.height / 2;
                            color: "#00000000"
                            Image{
                                x:10
                                y:0
                                source: "pictures/"+  icon_s1.substring(icon_s1.lastIndexOf("/"), icon_s1.length - 4) +"_s.png"
                            }
                            Text {
                                id: text1
                                x: 65
                                y: 90
                                text: day_of_week1
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 19
                            }
                            Text {
                                id: text2
                                x: 25
                                y: 120
                                text: condition_s1
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text3
                                x: 25
                                y: 145
                                text: low_f_s1 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text4
                                x: 25
                                y: 170
                                text: high_f_s1 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                        }
                        Rectangle {
                            // forecast2
                            x: weatherPanel.width / 4
                            y: 0
                            width: weatherPanel.width / 4;
                            height: weatherPanel.height / 2;
                            color: "#00000000"

                            Image{
                                x:10
                                y:0
                                source: "pictures/"+  icon_s2.substring(icon_s2.lastIndexOf("/"), icon_s2.length - 4) +"_s.png"
                            }
                            Text {
                                id: text21
                                x: 65
                                y: 90
                                text: day_of_week2
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 19
                            }
                            Text {
                                id: text22
                                x: 25
                                y: 120
                                text: condition_s2
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text23
                                x: 25
                                y: 145
                                text: low_f_s2 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text24
                                x: 25
                                y: 170
                                text: high_f_s2 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                        }
                        Rectangle {
                            // forecast3
                            x: (weatherPanel.width / 4) + (weatherPanel.width / 4)
                            y: 0
                            width: weatherPanel.width / 4;
                            height: weatherPanel.height / 2;
                            color: "#00000000"

                            Image{
                                x:10
                                y:0
                                source: "pictures/"+  icon_s3.substring(icon_s3.lastIndexOf("/"), icon_s3.length - 4) +"_s.png"
                            }
                            Text {
                                id: text31
                                x: 65
                                y: 90
                                text: day_of_week3
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 19
                            }
                            Text {
                                id: text32
                                x: 25
                                y: 120
                                text: condition_s3
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text33
                                x: 25
                                y: 145
                                text: low_f_s3 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text34
                                x: 25
                                y: 170
                                text: high_f_s3 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                        }
                        Rectangle {
                            // forecast4
                            x: (weatherPanel.width / 4) + (weatherPanel.width / 4) + (weatherPanel.width / 4)
                            y: 0
                            width: weatherPanel.width / 4;
                            height: weatherPanel.height / 2;
                            color: "#00000000"
                            Image{
                                x:10
                                y:0
                                source: "pictures/"+  icon_s4.substring(icon_s4.lastIndexOf("/"), icon_s4.length - 4) +"_s.png"
                            }
                            Text {
                                id: text41
                                x: 65
                                y: 90
                                text: day_of_week4
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 19
                            }
                            Text {
                                id: text42
                                x: 25
                                y: 120
                                text: condition_s4
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text43
                                x: 25
                                y: 145
                                text: low_f_s4 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                            Text {
                                id: text44
                                x: 25
                                y: 170
                                text: high_f_s4 + " F"
                                font.family: "Calibri"
                                color: "#0f0f0f"
                                font.pixelSize: 18
                            }
                        }


                    }

                }

                ListView {

                    width: weatherCurrentCondition.width;
                    height: weatherCurrentCondition.height;
                    model: weatherForecastXmlModel
                    delegate: weatherForecastPanelDelegate
                    interactive: false
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
