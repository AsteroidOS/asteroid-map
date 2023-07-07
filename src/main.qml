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
import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15
import Nemo.Configuration 1.0
import QtSensors 5.3

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
