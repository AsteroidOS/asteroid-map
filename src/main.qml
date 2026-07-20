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
import QtPositioning
import QtLocation
import Nemo.Configuration
import QtSensors

Application {
    centerColor: colors.secondary
    outerColor: colors.primary
    id: app

    Item {
        id: colors
        property string primary: "#00382d"
        property string secondary: "#00c9a0"
        property string textDefault: "#FFFFFF"
        property string textUnselected: "#999999"
    }
    Plugin {
        id: mapProvider
        name: "osm"
    }
    property PositionSource positionSource: PositionSource {
        id: positionSource
        preferredPositioningMethods: prioritiseGPS.value ? PositionSource.SatellitePositioningMethods : PositionSource.AllPositioningMethods
    }
    property Compass compass: Compass {
        id: compass
        active: enableCompass.value
    }
    LayerStack {
        id: pageStack
        anchors.fill: parent
        firstPage: mainMapView
    }
    property ConfigurationValue enableCompass: ConfigurationValue {
        id: enableCompass
        key: "/map/enableCompass"
        defaultValue: true
    }
    property ConfigurationValue prioritiseGPS: ConfigurationValue {
        id: prioritiseGPS
        key: "/map/prioritiseGPS"
        defaultValue: true
    }
    Component {
        id: mainMapView
        MainMapView {
            enableCompass: app.enableCompass
            compass: app.compass
            positionSource: app.positionSource
        }
    }
    Component {
        id: settingsPage
        SettingsPage {}
    }
}
