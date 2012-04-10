// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {

    property string blurbs: "Etiam id tellus justo, a tincidunt eros.

Aliquam erat volutpat. Suspendisse condimentum eleifend malesuada.

Suspendisse eget augue quis diam porttitor mattis eget gravida dolor. Nam non leo tortor. Sed sem nibh, dapibus eu viverra ut, viverra id nulla.

Donec eget nulla sed mauris luctus hendrerit non sit amet sem.

Quisque pellentesque augue vel sapien ultrices cursus. Aliquam sodales feugiat sapien eu venenatis. Nam non odio vel felis laoreet porta. Praesent vel eros sed lectus dignissim euismod.
"

    property variant all: allModel
    property variant fun: funModel
    property variant office: officeModel
    property variant productivity: productivityModel
    property variant social: socialModel
    property variant utility: utilityModel
    property variant multimedia: multimediaModel

    ListModel {
        id: allModel
        ListElement {
            image: "../../icons/Application_Daily_Calendar.png"
            name: "Calendar Plus v1.2.1"
            author: "Hong Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Daily_Email.png"
            name: "GMail 7.0"
            author: "Dia Young"
            description: ""
        }
        ListElement {
            image: "../../icons/Arrange_Widgets.png"
            name: "Wheel Of Fortune"
            author: "Ian Spaulding"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Dressing_Makeup.png"
            name: "Personal Assistant"
            author: "Hong Wang"
            description: ""
        }

        ListElement {
            image: "../../icons/Application_Multimedia_Gallery.png"
            name: "Photo Share"
            author: "Ann Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Multimedia_YouTube.png"
            name: "Youtube"
            author: "Ann Wang"
            description: ""
        }

        ListElement {
            image: "../../icons/Application_Dressing_Dressing.png"
            name: "MySpace"
            author: "Ann Wang"
            description: ""
        }

        ListElement {
            image: "../../icons/Application_Daily_Email.png"
            name: "Twitter"
            author: "Ian Spaulding"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Multimedia.png"
            name: "Silly Movie Maker"
            author: "Dia Young"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Daily.png"
            name: "CNN World News"
            author: "Dia Young"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Daily_Weather.png"
            name: "Paint Program"
            author: "Dia Young"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Dressing.png"
            name: "Movies Plus"
            author: "Dia Young"
            description: ""
        }
        ListElement {
            image: "../../icons/Settings.png"
            name: "Advanced Settings"
            author: "Dia Young"
            description: ""
        }
    }




    ListModel {
        id: funModel
        ListElement {
            image: "../../icons/Arrange_Widgets.png"
            name: "Wheel Of Fortune"
            author: "Ian Spaulding"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Multimedia_Gallery.png"
            name: "Photo Share"
            author: "Ann Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Multimedia.png"
            name: "Silly Movie Maker"
            author: "Dia Young"
            description: ""
        }

    }




    ListModel {
        id: officeModel
        ListElement {
            image: "../../icons/Application_Daily_Email.png"
            name: "GMail 7.0"
            author: "Dia Young"
            description: ""
        }

    }




    ListModel {
        id: productivityModel
        ListElement {
            image: "../../icons/Application_Daily_Calendar.png"
            name: "Calendar Plus v1.2.1"
            author: "Hong Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Dressing_Makeup.png"
            name: "Personal Assistant"
            author: "Hong Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Daily.png"
            name: "CNN World News"
            author: "Dia Young"
            description: ""
        }

    }




    ListModel {
        id: socialModel
        ListElement {
            image: "../../icons/Application_Dressing_Dressing.png"
            name: "MySpace"
            author: "Ann Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/Application_Daily_Email.png"
            name: "Twitter"
            author: "Ian Spaulding"
            description: ""
        }

    }




    ListModel {
        id: utilityModel
        ListElement {
            image: "../../icons/Application_Daily_Weather.png"
            name: "Paint Program"
            author: "Dia Young"
            description: ""
        }

    }




    ListModel {
        id: multimediaModel
        ListElement {
            image: "../../icons/Application_Multimedia_YouTube.png"
            name: "Youtube"
            author: "Ann Wang"
            description: ""
        }
        ListElement {
            image: "../../icons/ApplicationMenu_Dressing.png"
            name: "Movies Plus"
            author: "Dia Young"
            description: ""
        }

    }
}
