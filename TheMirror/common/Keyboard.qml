// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

// Based on keyboard code located at http://qt-project.org/forums/viewthread/1486

Grid {
    signal letterClicked(string letter)
    signal enter()
    signal backspace()

    width: kr.width
    height: kr.height + 71
    rows: 2
    columns: 1
    spacing: 1

    Component.onCompleted: {
        kr.letterClicked.connect(letterClicked)
        kr.enter.connect(enter)
        kr.backspace.connect(backspace)
    }

    Keyrows{
        id: kr
    }

    Button {
        width: 71*11
        height: 70
        label: { "Space" }
        onClicked: { letterClicked(" ") }
    }
}
