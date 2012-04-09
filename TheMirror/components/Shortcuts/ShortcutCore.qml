import QtQuick 1.0
import MirrorPlugin 1.0


Rectangle {

    property string appName;

    anchors.fill: parent
    color: /*mouseArea.pressed? "grey":*/"#00000000"
    radius: 3

    Settings {
        id: settings
    }

    Image {
        width: 32
        height: 32
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        source: "../../icons/"+ settings.getSetting(appName + "__icon", "shortcut_to_application")
        smooth: true
    }

    Text {
        text: appName
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        // font.bold: true
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        //        onClicked: {
        //            mainScreen.showMainMenuBar = false;
        //            mainScreen.showApplicationArea = true;

        //            applicationCanvas.isApplicationAreaTransparent = (settings.getSetting(appName + "__transparent", "shortcut_to_application") === 'true');
        //            applicationCanvas.showBorder = (settings.getSetting(appName + "__border", "shortcut_to_application") === 'true');
        //            applicationCanvas.applicationAreaHeightInNumberOfCells = settings.getSetting(appName + "__height", "shortcut_to_application")*1;
        //            applicationCanvas.applicationAreaWidthInNumberOfCells = settings.getSetting(appName + "__width", "shortcut_to_application")*1;

        //            applicationCanvas.componentLoder.title = appName;
        //            applicationCanvas.componentLoder.iconName = settings.getSetting(appName + "__icon", "shortcut_to_application");
        //            applicationCanvas.componentLoder.source = settings.getSetting(appName + "__source", "shortcut_to_application");
        //        }

        onClicked: {
            // console.log(appName + " has been clicked. " )
            // applicationCanvas.componentLoder.source = "";
            loadApplication();
            mainScreen.showMainMenuBar = false;
            mainScreen.showApplicationArea = true;
            // console.log(appName + " clicked over. " )
        }

    }

//    function printObjectInfo(modelObject) {
//        console.log(modelObject);
//        for(var prop in modelObject) {
//            console.log("name: " + prop + "; value: " + modelObject[prop])
//        }
//        console.log("===============\n");
//    }

    function loadApplication() {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.DONE) {
                var applicationsElement = doc.responseXML.documentElement;
                var found = false;
                // printObjectInfo(applicationsElement);
                for (var index = 0; index < applicationsElement.childNodes.length; index++) {
                    var applicationElement = applicationsElement.childNodes[index];
                    if(applicationElement.nodeType != 1 ) {
                        continue;
                    }
                    //printObjectInfo(applicationElement);

                    // <application>
                    for(var i = 0; i < applicationElement.childNodes.length; i++) {

                        if(applicationElement.childNodes[i].nodeType == 1
                                && applicationElement.childNodes[i].nodeName == "name"
                                && applicationElement.childNodes[i].childNodes[0].nodeValue == appName) { // <name> element

                           //  printObjectInfo(applicationElement.childNodes[i]);

                            found = true;

                            for(var innerIndex = i+1; innerIndex < applicationElement.childNodes.length; innerIndex++) {
                                var innerElement = applicationElement.childNodes[innerIndex];
                                // printObjectInfo(innerElement);

                                if(innerElement.nodeType == 1 && innerElement.nodeName == "icon") {
                                    //console.log("icon");
                                    applicationCanvas.componentLoder.iconName = innerElement.childNodes[0].nodeValue;
                                    //console.log("icon " + innerElement.childNodes[0].nodeValue);
                                }else if(innerElement.nodeType == 1 && innerElement.nodeName == "source") {
                                    //console.log("source");
                                    applicationCanvas.componentLoder.source = innerElement.childNodes[0].nodeValue;
                                    //console.log("source " + innerElement.childNodes[0].nodeValue);
                                }
                                else if(innerElement.nodeType == 1 && innerElement.nodeName == "width") {
                                    //console.log("width");
                                    applicationCanvas.applicationAreaWidthInNumberOfCells = innerElement.childNodes[0].nodeValue*1;
                                    //console.log("width " + innerElement.childNodes[0].nodeValue);
                                }
                                else if(innerElement.nodeType == 1 && innerElement.nodeName == "height") {
                                    //console.log("height");
                                    applicationCanvas.applicationAreaHeightInNumberOfCells = innerElement.childNodes[0].nodeValue*1;
                                    //console.log("height " + innerElement.childNodes[0].nodeValue);
                                }
                                else if(innerElement.nodeType == 1 && innerElement.nodeName == "transparent") {
                                    //console.log("transparent");
                                    applicationCanvas.isApplicationAreaTransparent = (innerElement.childNodes[0].nodeValue === 'true');
                                    //console.log("transparent " + innerElement.childNodes[0].nodeValue);
                                }
                                else if(innerElement.nodeType == 1 && innerElement.nodeName == "border") {
                                    //console.log("border");
                                    applicationCanvas.showBorder = (innerElement.childNodes[0].nodeValue  === 'true');
                                    //console.log("border " + innerElement.childNodes[0].nodeValue);
                                }
                            }

                            break;
                        }
                    }

                    if(found) {
                        break;
                    }
                }
            }
        }

        doc.open("GET", "../applications.xml");
        doc.send();
    }
}
