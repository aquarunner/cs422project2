import QtQuick 1.0
import "../../common"

Rectangle {

    id: tracker

    color: "lightgrey"
    anchors.fill: parent
    clip: true

    border.color: "grey"
    border.width: 3
    radius: 3

    XmlListModel {
        id: predictionsModel
        query: "/bustime-response/prd"

        XmlRole { name: "currentTime"; query: "tmstmp/string()" }
        XmlRole { name: "predictedTime"; query: "prdtm/string()" }
    }

    ListModel {
        id: existingRouteModel
    }

    Text {
        id: title
        anchors.top: tracker.top
        anchors.topMargin: 5
        anchors.horizontalCenter: tracker.horizontalCenter
        //        anchors.verticalCenter: tracker.verticalCenter
        // height: 20
        // width: parent.width

        text: "CTA Bus Tracker"
        font.pixelSize: 18
        font.bold: true
        font.family: "Arial"
        color: "black"

    }

    ListView{
        id: pagesListView
        anchors.fill:parent
        anchors.topMargin: 30

        interactive: false

        //the model contains the data
        model: pagesModel

        //control the movement of the menu switching
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 5000
        highlightFollowsCurrentItem: true
        highlightMoveDuration:240
        highlightRangeMode: ListView.NoHighlightRange
    }

    function readExistingRoutes() {
        existingRouteModel.clear();

        var existingRoutes = settings.getSetting("routes", "routes", "./components/CtaTracker/");
        var ids = existingRoutes.split(";");
        var id;
        var url;
        for(var i = 0; i < ids.length; i++) {
            id = ids[i].replace(/^\s+|\s+$/g, ""); // trim
            if(id.length !== 0 && id != "NONE"){
                url = settings.getSetting(id, "routes", "./components/CtaTracker/");
                existingRouteModel.append({"routeID": id, "routeURL": url})
            }
        }

    }


    VisualItemModel {
        id: pagesModel

        Rectangle {
            id: currentTrackingPage

            width: pagesListView.width
            height: pagesListView.height

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            Component.onCompleted: {
                readExistingRoutes();
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: existingRouteModel.count == 0
                text: "No route been selected"
                font.pixelSize: 15
                font.bold: true
                font.family: "Arial"
                color: "white"
            }

            ListView {
                id: existingRoutesList
                anchors.fill: parent

                model: existingRouteModel
                clip: true

                delegate: ExistingRouteButton {
                    listView: pagesListView
                    height: 60
                    fontSize:15
                    onClicked: {
                        predictionsModel.source = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=iKjMrnkQCtzUN2DeCQjUtrf26"+routeURL;
                        pagesListView.currentIndex = 1;
                    }
                }

//                MouseArea {
//                    anchors.fill: existingRoutesList
//                    visible: existingRouteModel.count == 0
//                    onClicked: {
//                        xmlApplicationLoader.loadApplication("CTA Bus");
//                    }
//                }
            }
        }



        Rectangle {
            id: showingTrackingPage

            width: pagesListView.width
            height: pagesListView.height - 40

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            ListView {
                id: predictionsList
                anchors.fill: parent
                model: predictionsModel
                clip: true

                delegate: PredictionButton {
                    listView: predictionsList
                    height: 30
                    fontSize:15
                }
            }

            Button {
                id: backToCurrentTrackingPage
                anchors.top: parent.bottom
                anchors.topMargin: 3
                anchors.horizontalCenter: parent.horizontalCenter
                label: i18n.back

                onClicked: {
                    pagesListView.currentIndex = 0
                }
            }

        } 
    }


}
