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
import org.asteroid.utils
import QtSensors
import Nemo.Configuration
import QtPositioning
import QtLocation

Item {
    id: controlsRoot
    required property Map mapView
    required property Compass compass
    required property ConfigurationValue compassMode
    required property ConfigurationValue enableCompass
    required property PositionSource positionSource

    ZoomButton {
        mapView: controlsRoot.mapView
        zoomOut: false

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - height/2 + DeviceSpecs.flatTireHeight/2
        height: parent.height*0.2
        width: height
    }
    ZoomButton {
        mapView: controlsRoot.mapView
        zoomOut: true

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height/2 + DeviceSpecs.flatTireHeight/2
        height: parent.height*0.2
        width: height
    }
    CompassButton {
        compass: controlsRoot.compass
        compassMode: controlsRoot.compassMode
        enableCompass: controlsRoot.enableCompass
        mapView: controlsRoot.mapView

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - height/2 + DeviceSpecs.flatTireHeight/2
        height: parent.height*0.2
        width: height
    }
    RecenterButton {
        positionSource: controlsRoot.positionSource
        mapView: controlsRoot.mapView

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height/2 + DeviceSpecs.flatTireHeight/2
        height: parent.height*0.2
        width: height
    }
    IconButton {
        iconName: "ios-menu-outline"
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
        onClicked: pageStack.push(settingsPage,{})
    }
    IconButton {
        iconName: "ios-pin-outline"
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
        onClicked: {
            parent.visible = false
            setPointControls.visible = true
        }
    }
}
