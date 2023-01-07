import QtQuick 2.0
import org.asteroid.controls 1.0
import Nemo.Configuration 1.0
import QtPositioning 5.15
import QtLocation 5.15
import QtSensors 5.3

Item {
    ConfigurationValue {
        id: mapZoom
        key: "/map/view/zoomlevel"
        defaultValue: 3.4
    }
    ConfigurationValue {
        id: mapCenterLat
        key: "/map/view/location/lat"
        defaultValue: ""
    }
    ConfigurationValue {
        id: mapCenterLong
        key: "/map/view/location/long"
        defaultValue: ""
    }
    ConfigurationValue {
        id: compassMode
        key: "/map/view/compassMode"
        defaultValue: 0
    }
    ConfigurationValue {
        id: waypointSource
        key: "/map/waypointList"
        defaultValue: ""
        onValueChanged: {
            mapView.updateWaypoints()
            console.log("value changed")
        }
        Component.onCompleted: mapView.updateWaypoints()
    }

    Label {
        text: "Map Data from OpenStreetMap"
        font.pixelSize: parent.width*0.03
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
        Connections {
            target: positionProvider
            function onPositionChanged() {
                mapView.center = positionProvider.position.coordinate
            }
        }
        Connections {
            target: compass
            function onReadingChanged() {
                if (compassMode.value == 2) {
                    mapView.bearing = compass.reading.azimuth
                }
            }
        }
        property MapQuickItem mapItem
        function updateWaypoints() {
            console.log("waypoints updated")
            var waypointsList = waypointSource.value.split(">")
            for(var i = 0, size = waypointsList.length-1; i < size ; i++){
                var currWaypointData = waypointsList[i].split(";")
                var currWaypointCoord = currWaypointData[1].split(",")
                mapItem = waypoint.createObject(mapView)
                mapItem.coordinate = QtPositioning.coordinate(currWaypointCoord[0],currWaypointCoord[1])
                mapItem.iconName = currWaypointData[0]
                mapItem.iconColor = currWaypointData[2]
                mapView.addMapItem(mapItem)
            }
        }
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
        id: waypoint
        MapWaypoint {
        }
    }
    Component {
        id: setPointPage
        SetPointPage {
        }
    }
}
