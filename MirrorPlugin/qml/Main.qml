// This file is a demo of the Settings class
// (which is in the "MirrorPlugin" uri)

import QtQuick 1.1
import MirrorPlugin 1.0

Rectangle {
    width: 200
    height: 62

    Settings {
        id: settings
    }

    Text {
        id: test
        text: qsTr("click me")
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        property int temp
        onClicked: {
            temp = parseInt(settings.getSetting("number", "AppName"))
            temp = temp + 1
            settings.setSetting("number", temp, "AppName");
            test.text = qsTr("click me: %1").arg(settings.getSetting("number", "AppName"))

        }
    }
}
