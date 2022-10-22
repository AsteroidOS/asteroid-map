import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15

Application {
    id: app

    centerColor: "#9800A6"
    outerColor: "#0C0009"

    Label {
        text: "Map Data from OpenStreetMap"
        anchors.centerIn: parent
        z: 0
    }
    Plugin {
        id: mapProvider
        name: "osm"
    }
    LayerStack {
        id: pagestack
        anchors.fill: parent
        firstPage: mainmapview
    }

    Component {
        id: mainmapview
        MainMapView {}
    }
}
