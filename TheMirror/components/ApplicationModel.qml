import QtQuick 1.0

XmlListModel {

    property string queryCondition: "/applications/application";

    source: "applications.xml"
    query: queryCondition

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "category"; query: "category/string()" }
    XmlRole { name: "icon"; query: "allergen/string()" }
    XmlRole { name: "source"; query: "nutrition/string()" }
    // XmlRole { name: "width"; query: "width/string()" }
    // XmlRole { name: "height"; query: "height/string()" }
}
