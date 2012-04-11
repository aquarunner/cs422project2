// import QtQuick 1.0 // to target Sbuttonheight 5th Edition or Maemo 5
import QtQuick 1.1

// Based on keyboard code located at http://qt-project.org/forums/viewthread/1486

Grid {
    id: keyrows

    property string linenum: "1234567890"
    property string line1: "qwertyuiop-"
    property string line2: "asdfghjkl'"
    property string line3: "zxcvbnm,."
    property bool shifted : false
    property bool capslocked: false
    property int buttonwidth: 55
    property int buttonheight: 50

    signal letterClicked(string letter)
    signal enter()
    signal backspace()

    rows: 4
    columns: 11
    spacing: 1

    Repeater {
        id: ln
        model: linenum.length
        Button {
            width: buttonwidth; height: buttonheight
            label: { linenum.charAt( index ); }
            onClicked: { letterClicked(label); unshift() }
        }
    }

    Button {
        width: buttonwidth; height: buttonheight
        label: "<-"
        onClicked: { backspace() }
    }

    Repeater {
        id: l1
        model: line1.length
        Button {
            width: buttonwidth; height: buttonheight
            label: { line1.charAt( index ); }
            onClicked: { letterClicked(label); unshift() }
        }
    }

    Button {
        width: buttonwidth; height: buttonheight
        label: "Caps"
        onClicked: {
            if(!capslocked && !shifted) { uppercaseall() }
            else { lowercaseall() }

            capslocked = !capslocked;
        }
    }

    Repeater
    {
        id: l2
        model: line2.length
        Button {
            width: buttonwidth; height: buttonheight
            label: { line2.charAt(index); }
            onClicked: { letterClicked(label); unshift(); }
        }
    }

    Button {
        width: buttonwidth; height: buttonheight
        label: "Shift"
        onClicked: {
            if(shifted) unshift()
            else shift()
        }
    }

    Repeater
    {
        id: l3
        model: line3.length
        Button {
            width: buttonwidth; height: buttonheight
            label: { line3.charAt(index); }
            onClicked: { letterClicked(label); unshift() }
        }
    }

    Button {
        width: buttonwidth; height: buttonheight
        label: "Enter"
        onClicked: { enter() }
    }

    function unshift()
    {
        if(!shifted) return;

        if(capslocked) { uppercaseall() }
        else { lowercaseall() }

        shifted = false;
    }

    function shift()
    {
        if(capslocked) { lowercaseall() }
        else { uppercaseall() }

        shifted = true;
    }

    function uppercaseall()
    {
        linenum = "!@#$%^&*()"
        line1 = "QWERTYUIOP_"
        line2 = "ASDFGHJKL\""
        line3 = "ZXCVBNM:?"
    }

    function lowercaseall()
    {
        linenum = "1234567890"
        line1 = "qwertyuiop-"
        line2 = "asdfghjkl'"
        line3 = "zxcvbnm,."
    }
}
