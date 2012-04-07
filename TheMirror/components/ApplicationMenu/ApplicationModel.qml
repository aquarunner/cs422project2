import QtQuick 1.0

XmlListModel {

    source: "../applications.xml"

    XmlRole { name: "appName"; query: "name/string()" }
    XmlRole { name: "appCategory"; query: "category/string()" }
    XmlRole { name: "appIcon"; query: "icon/string()" }
    XmlRole { name: "appSource"; query: "source/string()" }
    XmlRole { name: "appWidth"; query: "width/string()" }
    XmlRole { name: "appHeight"; query: "height/string()" }
    XmlRole { name: "appIsTransparent"; query: "transparent/string()" }
    XmlRole { name: "appShowBorder"; query: "border/string()" }
}
