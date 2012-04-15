import QtQuick 1.1
import "../../common"

Rectangle{
    id: notepad_app
    anchors.fill: parent
    anchors.topMargin: 55

    property int numNotes: settings.getSetting("numNotes", "notes", "./components/Notepad/")
    property string oldText: ""

    Component.onCompleted: {
        for(var i = 0; i < numNotes; ++i)
            notes_model.append({
                                   "title": settings.getSetting("note"+i,"notes", "./components/Notepad/").split("::")[0],
                                   "text": settings.getSetting("note"+i,"notes", "./components/Notepad/").split("::")[1]
                               })

        if(numNotes > 0)
            thetext.text = notes_model.get(0).text
    }

    ListModel {
        id: notes_model
    }

    Rectangle {
        id: np_list
        anchors.top: parent.top
        anchors.bottom: edit_area.bottom
        anchors.left: parent.left
        anchors.right: edit_area.left
        anchors.rightMargin: 2
        anchors.leftMargin: 2
        anchors.bottomMargin: 2

        Component {
            id: noteDelegate
            Item {
                width: np_list.width; height: np_list.height/5.5
                Column {

                    Text {
                        text: '<b>' + title  + "</b>";
                        horizontalAlignment: Text.AlignRight
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            np_view.currentIndex = index;
                            thetext.text = text
                            oldText = text
                        }
                    }
                }
            }
        }

        ListView {
            id: np_view
            anchors.bottomMargin: -153
            preferredHighlightBegin: 0
            anchors.fill: parent
            model: notes_model
            delegate: noteDelegate
            highlight: Rectangle { color: "lightgray"; radius: 5 }
            focus: true
        }
    }

    Rectangle {
        id: edit_area
        anchors.top: parent.top
        anchors.right: parent.right
        width: keyboard.width
        height: keyboard.height + thetext.height
        anchors.rightMargin: 2
        anchors.leftMargin: 2
        anchors.bottomMargin: 2

        Component.onCompleted: {
            keyboard.letterClicked.connect(addletter)
            keyboard.enter.connect(enter)
            keyboard.backspace.connect(backspace)
        }

        Text{
            id: thetext
            height: 100
            text: "" // np_view.currentItem.
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

    Rectangle {
        id: buttons
        anchors.left: parent.left
        anchors.top: edit_area.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 2
        anchors.rightMargin: 2
        anchors.leftMargin: 2
        anchors.bottomMargin: 2

        Button {
            id:newbutton
            anchors.left: parent.left
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            label: "New"

            Image {
                anchors.left: parent.left
                anchors.leftMargin: 5
                source: "imgs/add.png"
                width: parent.height - 2
                height: parent.height - 2
            }

            onClicked: {
                if(thetext.text.length > 0)
                {
                    settings.setSetting("note"+numNotes, thetext.text + ":: ", "notes", "./components/Notepad/")
                    numNotes++
                    settings.setSetting("numNotes", numNotes, "notes", "./components/Notepad/")
                    notes_model.append({"title": thetext.text, "text": ""})
                    thetext.text = ""
                }
            }
        }

        Button {
            id:deletebutton
            anchors.left: newbutton.right
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            label: "Delete"

            Image {
               anchors.left: parent.left
               anchors.leftMargin: 5
               source: "imgs/subtract.png"
               width: parent.height - 2
               height: parent.height - 2
               visible: !eventArea.inAddNewEventPage
           }

            onClicked: {
                if(numNotes > 0) // Only if there is something to remove
                {
                    numNotes--

                    // If the index is not last, then we have to do some moving around
                    if(np_view.currentIndex != numNotes)
                    {
                        // Move the last one to the deleted slot
                        settings.setSetting("note"+np_view.currentIndex, settings.getSetting("note" + numNotes, "notes", "./components/Notepad/"),"notes", "./components/Notepad/")
                        notes_model.set(np_view.currentIndex, notes_model.get(numNotes))
                    }

                    // Finally, delete the last setting and set the new number of notes
                    settings.setSetting("note"+numNotes, "", "notes", "./components/Notepad/")
                    notes_model.remove(numNotes)
                    settings.setSetting("numNotes", numNotes, "notes", "./components/Notepad/")
                    if(numNotes > 0)
                    {
                        thetext.text = notes_model.get(np_view.currentIndex).text
                    }
                    else
                    {
                        thetext.text = ""
                    }
                }
            }
        }

        Button {
            id:cancelbutton
            anchors.left: deletebutton.right
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            label: "Cancel"

            onClicked:{
                thetext.text = oldText
            }
        }

        Button {
            id:savebutton
            anchors.left: cancelbutton.right
            anchors.right: exitbutton.left
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            label: "Save"

            onClicked: {
                notes_model.setProperty(np_view.currentIndex, "text", thetext.text)
                settings.setSetting("note"+ np_view.currentIndex,
                                    notes_model.get(np_view.currentIndex).title + ":: " + notes_model.get(np_view.currentIndex).text,
                                    "notes", "./components/Notepad/")
            }
        }

        Button{
            id:exitbutton
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            label: "Exit"

            onClicked: {                
                widgetCanvas.reloadWidget("notes_widget")
                mainScreen.showMainMenuBar = true;
                mainScreen.showApplicationArea = false;
            }
        }
    }
}
