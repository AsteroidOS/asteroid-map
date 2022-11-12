import QtQuick 2.0
import org.asteroid.controls 1.0
import Nemo.Configuration 1.0
import QtPositioning 5.15
import QtLocation 5.15

Item {
    ConfigurationValue {
        id: mapZoom
        key: "/map/zoomlevel"
        defaultValue: 3.4
    }
    ConfigurationValue {
        id: mapCenterLat
        key: "/map/location/lat"
        defaultValue: 0
    }
    ConfigurationValue {
        id: mapCenterLong
        key: "/map/location/long"
        defaultValue: 0
    }
    Label {
        text: "Map Data from OpenStreetMap"
        font.pixelSize: parent.width*0.02
        anchors.centerIn: parent
        z: 0
    }
    Map {
        id: mapView
        plugin: mapProvider
        anchors.fill: parent
        copyrightsVisible: false //this is compensated by showing the copyright when application is loading
        color: "#00000000"
        z: 1
        Component.onCompleted: { zoomLevel = mapZoom.value; center.latitude = mapCenterLat.value; center.longitude = mapCenterLong.value; console.log(mapCenterLat.value,mapCenterLong.value)}
        onZoomLevelChanged: mapZoom.value = zoomLevel
        onCenterChanged: {mapCenterLat.value = center.latitude; mapCenterLong.value = center.longitude; console.log(center)}
    }
    DefaultMapControls {
        id: mapControls
        anchors.fill: parent
        z: 2
    }
    SetPointMapControls {
        id: setPointControls
        anchors.fill: parent
        visible: false
        z: 2
        function primaryButtonAction() {
             pageStack.push(setPointPage,{coord: mapView.center})
        }
    }
    Component {
        id: setPointPage
        SetPointPage {
        }
    }
}
