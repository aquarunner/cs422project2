// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "common"

Rectangle {
    id: notepad_app
    width: keyboard.width
    height: 500

    //signal addletter(String letter)

    Component.onCompleted: {
        //notepad_app.addletter.connect()
        keyboard.letterClicked.connect(addletter)
    }

    Keyboard {
        id: keyboard
    }

    function addletter(letter)
    {
        console.log("Added: " + letter)
    }
}
