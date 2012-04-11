import QtQuick 1.0

Rectangle {
    function loadImage(icon, appName, startPath) {
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
                                    icon.source = startPath + innerElement.childNodes[0].nodeValue;
                                    //console.log("icon " + innerElement.childNodes[0].nodeValue);

                                    break;
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

        doc.open("GET", "applications.xml");
        doc.send();
    }

    function loadApplication(appName) {
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

                            applicationCanvas.componentLoder.title = appName

                            for(var innerIndex = i+1; innerIndex < applicationElement.childNodes.length; innerIndex++) {
                                var innerElement = applicationElement.childNodes[innerIndex];
                                // printObjectInfo(innerElement);

                                if(innerElement.nodeType == 1 && innerElement.nodeName == "icon") {
                                    //console.log("icon");
                                    applicationCanvas.componentLoder.iconName = innerElement.childNodes[0].nodeValue;
                                    //console.log("icon " + innerElement.childNodes[0].nodeValue);
                                }else if(innerElement.nodeType == 1 && innerElement.nodeName == "source") {
                                    //console.log("source");
                                    applicationCanvas.componentLoder.source = "./ApplicationMenu/"+innerElement.childNodes[0].nodeValue;
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

        doc.open("GET", "applications.xml");
        doc.send();
    }
}
