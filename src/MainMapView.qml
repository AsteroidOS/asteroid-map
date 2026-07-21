/*
 * Copyright (C) 2023 - Arseniy Movshev <dodoradio@outlook.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick
import org.asteroid.controls
import Nemo.Configuration
import QtPositioning
import QtLocation
import QtSensors
import "mapControls"

Item {
    id: mapViewRoot
    required property ConfigurationValue enableCompass
    required property PositionSource positionSource
    required property Compass compass
    property ConfigurationValue mapZoom: ConfigurationValue {
        id: mapZoom
        key: "/map/view/zoomlevel"
        defaultValue: 3.4
    }
    property ConfigurationValue mapCenterLat: ConfigurationValue {
        id: mapCenterLat
        key: "/map/view/location/lat"
        defaultValue: ""
    }
    property ConfigurationValue mapCenterLong: ConfigurationValue {
        id: mapCenterLong
        key: "/map/view/location/long"
        defaultValue: ""
    }
    property ConfigurationValue compassMode: ConfigurationValue {
        id: compassMode
        key: "/map/view/compassMode"
        defaultValue: 0
    }
    property ConfigurationValue waypointSource: ConfigurationValue {
        id: waypointSource
        key: "/map/waypointList"
        defaultValue: "[]"
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
    property Map mapView: mapView
    Map {
        id: mapView
        plugin: mapProvider
        anchors.fill: parent
        copyrightsVisible: false //this is compensated by showing the copyright when application is loading
        color: "#00000000"
        z: 1
        Component.onCompleted: {
            zoomLevel = mapZoom.value
            //the precision of the saved value seems to get truncated by nemo-configuration or its backend.
            //multiply by a million to prevent the value getting 'rounded'
            center.latitude = mapCenterLat.value/1000000
            center.longitude = mapCenterLong.value/1000000
        }
        Component.onDestruction: {
            mapZoom.value = zoomLevel
            mapCenterLat.value = center.latitude*1000000
            mapCenterLong.value = center.longitude*1000000
        }

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                mapView.startCentroid = mapView.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                mapView.zoomLevel += Math.log2(delta)
                mapView.alignCoordinateToPoint(mapView.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                mapView.bearing -= delta
                mapView.alignCoordinateToPoint(mapView.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => mapView.pan(-delta.x, -delta.y)
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
            clearMapItems()
            var waypointsList = JSON.parse(waypointSource.value)
            console.log(waypointsList)
            for(var i = 0, size = waypointsList.length; i < size ; i++){
                var currWaypointData = waypointsList[i]
                mapItem = waypoint.createObject(mapView)
                mapItem.coordinate = QtPositioning.coordinate(currWaypointData[1][0],currWaypointData[1][1])
                console.log(mapItem.coordinate)
                mapItem.iconName = currWaypointData[0]
                console.log(currWaypointData[2])
                mapItem.iconColor = currWaypointData[2]
                mapItem.index = i
                mapView.addMapItem(mapItem)
            }
            console.log("waypoints updated")
        }
    }
    DefaultMapControls {
        id: mapControls
        anchors.fill: parent
        z: 2

        mapView: mapViewRoot.mapView
        compass: mapViewRoot.compass
        compassMode: mapViewRoot.compassMode
        enableCompass: mapViewRoot.enableCompass
        positionSource: mapViewRoot.positionSource
    }
    SetPointMapControls {
        id: setPointControls
        anchors.fill: parent
        visible: false
        z: 2

        mapView: mapViewRoot.mapView
        compass: mapViewRoot.compass
        compassMode: mapViewRoot.compassMode
        enableCompass: mapViewRoot.enableCompass
        positionSource: mapViewRoot.positionSource
        function primaryButtonAction() {
             pageStack.push(setPointPage,{coord: mapView.center})
        }
    }
    function editWaypoint(index) {
        pageStack.push(setPointPage,{editMode: true, editIndex: index})
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
