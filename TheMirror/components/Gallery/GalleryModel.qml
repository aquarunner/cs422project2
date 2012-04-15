import QtQuick 1.0

XmlListModel {

    source: "http://api.flickr.com/services/feeds/photos_public.gne?tags=headshot&"
    query: "/feed/entry"
    namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"

    XmlRole { name: "src"; query: "link[@rel='enclosure']/@href/string()" }
}
