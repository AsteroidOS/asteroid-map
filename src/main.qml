import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15
import Nemo.Configuration 1.0
import QtSensors 5.3

Application {
    centerColor: "#6e90e9"
    outerColor: "#00bc1b"
    id: app

    Item {
        id: colours
        property string primary: "#0056d7"
        property string primaryUnselected: "#3274d7"
    }
    Plugin {
        id: mapProvider
        name: "osm"
    }
    PositionSource {
        id: positionProvider
    }
    Compass {
        id: compass
        active: enableCompass.value
    }
    LayerStack {
        id: pageStack
        anchors.fill: parent
        firstPage: mainMapView
    }
    ConfigurationValue {
        id: enableCompass
        key: "/map/enableCompass"
        defaultValue: true
    }

    Component {
        id: mainMapView
        MainMapView {
        }
    }
    Component {
        id: settingsPage
        SettingsPage {}
    }
}
