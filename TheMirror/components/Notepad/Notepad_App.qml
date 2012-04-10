// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import MirrorPlugin 1.0
import "../../common"

Grid{
    id: notepad_app
    anchors.fill: parent
    anchors.topMargin: 55
    spacing: 10

    Rectangle {
        width: 180; height: 200

        Component {
            id: contactDelegate
            Item {
                width: 180; height: 40
                Column {
                    Text { text: '<b>Title: </b> ' + title }
                }
            }
        }

        ListView {
            width: 180
            height: notepad_app.height
            anchors.bottomMargin: -153
            preferredHighlightBegin: 0
            anchors.fill: parent
            model: NotesModel {}
            delegate: contactDelegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
        }
    }

    Rectangle {
        id: edit_area
        width: keyboard.width
        height: keyboard.height + thetext.height

        Component.onCompleted: {
            keyboard.letterClicked.connect(addletter)
            keyboard.enter.connect(enter)
            keyboard.backspace.connect(backspace)
        }

        Text{
            id: thetext
            height: 100
            text: "Hello"
        }

        Keyboard {
            y: thetext.height
            id: keyboard
        }

        function addletter(letter)
        {
            thetext.text += letter
        }

        function enter()
        {
            thetext.text += '\n';
        }

        function backspace()
        {
            thetext.text = thetext.text.substring(0,thetext.text.length-1);
        }
    }
}
