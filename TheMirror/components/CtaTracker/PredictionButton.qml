import QtQuick 1.0

Rectangle {

    property variant listView;
    property int fontSize: 22

    width: listView.width
    height: 70

    color: "#00000000"
    border.color: "white"
    border.width: 3

    Text {
        id: titleArea
        x: listView.width/20
        height: 20
        text: computeEstimatedTime(currentTime, predictedTime);
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: fontSize
        font.bold: true
        font.family: "Arial"
        color: "white"
    }

    function computeEstimatedTime(currentTime, predictedTime)
    {
        var current = parseDate(currentTime);
        var predicted = parseDate(predictedTime);

        // console.log((predicted - current)/1000/60)

        return "["+Math.ceil((predicted - current)/1000/60) + "] minutes - "
                + predictedTime.substring(9);
    }

    function parseDate(dateString) {
        var yyyy = dateString.substring(0, 4)*1;
        var mm = dateString.substring(4,6)*1;
        var dd = dateString.substring(6,8)*1;
        var hh = dateString.substring(9,11)*1;
        var min = dateString.substring(12)*1;

        // console.log(yyyy + " " + mm + " " + dd + " " + hh + " " + min)

        var date = new Date(yyyy, mm, dd, hh, min, 0, 0);
        // console.log(date.getTime());

        return date.getTime();

    }
}
