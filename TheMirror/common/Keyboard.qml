// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

// Based on keyboard code located at http://qt-project.org/forums/viewthread/1486

Grid {
    id: number_pad
    width: 70*columns
    height: 70*rows

    property string line1: "1234567890qwertyuiop"
    property string line2: "asdfghjkl"
    property string line3: "zxcvbnm"

    signal hideKeyboard()
    signal letterClicked(string letter)

    rows: 4
    columns: 10
    spacing: 1

    Repeater {
        model: line1.length
        Button {
            width: 70; height: 70
            label: { line1.charAt( index ); }
            onClicked: { letterClicked ( label ) }
        }
    }

    Repeater
    {
        model: line2.length
        Button {
            width: 70; height: 70
            label: { line2.charAt(index); }
            onClicked: { letterClicked(label) }
        }
    }

    Button {
        width: 70; height: 70
        label: "Enter"
        onClicked: {  }
    }

    Button {
        width: 70; height: 70
        label: "Caps"
        onClicked: {  }
    }

    Button {
        width: 70; height: 70
        label: "Shift"
        onClicked: {  }
    }

    Repeater
    {
        model: line3.length
        Button {
            width: 70; height: 70
            label: { line3.charAt(index); }
            onClicked: { letterClicked(label) }
        }
    }

    Button {
        width: 70; height: 70
        label: "<-"
        onClicked: {  }
    }
}
