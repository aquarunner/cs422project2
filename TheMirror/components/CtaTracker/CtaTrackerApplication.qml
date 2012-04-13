import QtQuick 1.0
import "../../common"

Rectangle {

    id: tracker

    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 52
    clip: true

    XmlListModel {
        id: routesModel

        source: "http://www.ctabustracker.com/bustime/api/v1/getroutes?key=iKjMrnkQCtzUN2DeCQjUtrf26"
        query: "/bustime-response/route"

        XmlRole { name: "routeNumber"; query: "rt/string()" }
        XmlRole { name: "routeName"; query: "rtnm/string()" }
    }

    XmlListModel {
        id: directionsModel

        property string routeNumber;
        source: "http://www.ctabustracker.com/bustime/api/v1/getdirections?key=iKjMrnkQCtzUN2DeCQjUtrf26&rt="+routeNumber
        query: "/bustime-response/dir"

        XmlRole { name: "direction"; query: "string()" }
    }

    XmlListModel {
        id: stopsModel

        property string routeNumber;
        property string direction;

        source: "http://www.ctabustracker.com/bustime/api/v1/getstops?key=iKjMrnkQCtzUN2DeCQjUtrf26&rt="+routeNumber+"&dir="+direction.replace(" ", "%20")
        query: "/bustime-response/stop"

        XmlRole { name: "stopID"; query: "stpid/string()" }
        XmlRole { name: "stopName"; query: "stpnm/string()" }
    }

    XmlListModel {
        id: predictionsModel

        //        property string routeNumber;
        //        property string stopID;

        // source: "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=iKjMrnkQCtzUN2DeCQjUtrf26&rt="+routeNumber+"&stpid="+stopID
        query: "/bustime-response/prd"

        XmlRole { name: "currentTime"; query: "tmstmp/string()" }
        XmlRole { name: "predictedTime"; query: "prdtm/string()" }
        //        XmlRole { name: "stopID"; query: "stpid/string()" }
        //        XmlRole { name: "stopName"; query: "stpnm/string()" }
    }

    ListModel {
        id: existingRouteModel
    }

    ListView{
        id: pagesListView
        anchors.fill:parent
        anchors.bottomMargin: 55

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

        Component.onCompleted: positionViewAtIndex(1, ListView.Beginning)
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
            id: showingTrackingPage

            width: pagesListView.width
            height: pagesListView.height

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            ListView {
                id: predictionsList
                anchors.fill: parent
                model: predictionsModel
                clip: true

                delegate: PredictionButton { listView: predictionsList }
            }

            Button {
                id: backToCurrentTrackingPage
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.back

                onClicked: {
                    pagesListView.currentIndex = 1
                }
            }

        }

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
                text: "Press [Add track] to add. "
                font.pixelSize: 22
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
                    onClicked: {
                        predictionsModel.source = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=iKjMrnkQCtzUN2DeCQjUtrf26"+routeURL;
                        // console.log(routeURL);
                        pagesListView.currentIndex = 1;
                        pagesListView.currentIndex = 0;
                    }
                }

                //                Button {
                //                    anchors.horizontalCenter: parent.horizontalCenter
                //                    anchors.verticalCenter: parent.verticalCenter
                //                    label: "<--"
                //                    onClicked: {
                //                        pagesListView.currentIndex = 0
                //                    }
                //                }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 20
                label: "Add track"

                onClicked: {
                    routesList.currentSelection = "";
                    pagesListView.currentIndex = 2
                }
            }

            Button {
                id: exit

                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.exit

                onClicked: {
                    mainScreen.showMainMenuBar = true;
                    mainScreen.showApplicationArea = false;
                }
            }
        }

        Rectangle {
            id: selectRoutePage

            width: pagesListView.width
            height: pagesListView.height

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            ListView {
                id: routesList
                anchors.fill: parent
                model: routesModel
                clip: true

                property string currentSelection: "";
                delegate: RouteRadioButton { listView: routesList }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 20
                label: i18n.back

                onClicked: {
                    routesList.currentSelection = "";
                    pagesListView.currentIndex = 1
                }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.next
                visible: routesList.currentSelection != ""

                onClicked: {
                    directionsModel.routeNumber = routesList.currentSelection
                    directionsList.model = directionsModel;
                    pagesListView.currentIndex = 3
                }
            }

        }

        Rectangle {
            id: selectDirectionPage

            width: pagesListView.width
            height: pagesListView.height

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            ListView {
                id: directionsList
                anchors.fill: parent
                // model: directionsModel
                clip: true

                property string currentSelection: "";
                delegate: DirectionRadioButton { listView: directionsList }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 20
                label: i18n.back

                onClicked: {
                    directionsList.currentSelection = "";
                    pagesListView.currentIndex = 2
                }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.next
                visible: directionsList.currentSelection != ""

                onClicked: {
                    stopsModel.routeNumber = routesList.currentSelection
                    stopsModel.direction = directionsList.currentSelection;
                    stopsList.model = stopsModel;
                    pagesListView.currentIndex = 4
                }
            }


        }

        Rectangle {
            id: selectStopPage

            width: pagesListView.width
            height: pagesListView.height

            color: "grey"
            Image { source: "../../icons/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }

            ListView {
                id: stopsList
                anchors.fill: parent
                // model: stopsModel
                clip: true

                property string currentSelection: "";
                property string currentStopName: "";
                delegate: StopRadioButton { listView: stopsList }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 20
                label: i18n.back

                onClicked: {
                    stopsList.currentSelection = "";
                    pagesListView.currentIndex = 3
                }
            }

            Button {
                anchors.top: parent.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 20
                label: i18n.next
                visible: stopsList.currentSelection != ""

                onClicked: {
                    //                    predictionsModel.routeNumber = routesList.currentSelection;
                    //                    predictionsModel.stopID = stopsList.currentSelection;

                    selectStopPage.saveRoute(routesList.currentSelection, directionsList.currentSelection,
                                             stopsList.currentStopName, stopsList.currentSelection);

                    pagesListView.currentIndex = 1

                    readExistingRoutes();
                    widgetCanvas.reloadWidget("cta_widget");
                }
            }

            function saveRoute(routeNumber, direction, stopName, stopID) {
                var existingRoutes = settings.getSetting("routes", "routes", "./components/CtaTracker/");
                var newRouteID = routeNumber + "/" + direction + "/" + stopName;
                existingRoutes = existingRoutes + newRouteID + ";"

                var routeURL = "&rt="+routeNumber+"&stpid="+stopID

                settings.setSetting("routes", existingRoutes, "routes", "./components/CtaTracker/");
                settings.setSetting(newRouteID, routeURL, "routes", "./components/CtaTracker/");
            }
        }
    }


}
