import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15

Application {
    id: app

    centerColor: "#9800A6"
    outerColor: "#0C0009"

    Plugin {
        id: mapProvider
        name: "osm"
    }
    LayerStack {
        id: pageStack
        anchors.fill: parent
        firstPage: mainmapview
    }

    Component {
        id: mainmapview
        MainMapView {}
    }
    Component {
        id: settingsPage
        SettingsPage {}
    }
}
