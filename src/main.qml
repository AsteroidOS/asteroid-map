import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15
import Nemo.Configuration 1.0
import QtSensors 5.3

Application {
    centerColor: colors.primary
    outerColor: colors.secondary
    id: app

    Item {
        id: colors
        property string primary: "#003F1A"
        property string secondary: "#00FCC9"
        property string textDefault: "#FFFFFF"
        property string textUnselected: "#999999"
    }
    Plugin {
        id: mapProvider
        name: "osm"
    }
    PositionSource {
        id: positionProvider
        preferredPositioningMethods: prioritiseGPS.value ? PositionSource.SatellitePositioningMethods : PositionSource.AllPositioningMethods
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
    ConfigurationValue {
        id: prioritiseGPS
        key: "/map/prioritiseGPS"
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
