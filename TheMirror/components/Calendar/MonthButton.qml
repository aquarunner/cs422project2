import QtQuick 1.0

Item {
    // width: calendar.width - margin*2;
    // height: 66
    height: calendar.height/6
    id: monthHandler
    property string calendarString: ""
    signal previousClicked()
    signal nextClicked()

    //TODO: must be Nokia Sans Semibold
    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    ImageButton {
        id: prevBtn
        current: "../imgs/btn_prev.png"
        background: "../imgs/btn_prev.png"
        pressed: "../imgs/btn_prev_pressed.png"
        focused: "../imgs/btn_prev.png"
        anchors.left: parent.left
        // anchors.leftMargin: -2
        onButtonClicked: monthHandler.previousClicked()
    }

    Image {
        id: calendarStringImg
        source: "../imgs/calendar_string_bg.png"
        // height: 66; width: 211
        height: monthHandler.height
        width: monthHandler.width/5*3
        fillMode: Image.Tile
        anchors.left: prevBtn.right
    }

    Text {
        text: calendarString
        font { family: nsRegular.name; pixelSize: 18 }
        color: "#5b5b5b"
        anchors.verticalCenter: calendarStringImg.verticalCenter
        anchors.horizontalCenter: calendarStringImg.horizontalCenter

    }

    ImageButton {
        id: nextBtn
        current: "../imgs/btn_next.png"
        background: "../imgs/btn_next.png"
        pressed: "../imgs/btn_next_pressed.png"
        focused: "../imgs/btn_next.png"
        anchors.left: calendarStringImg.right
        onButtonClicked: monthHandler.nextClicked()
    }

}
