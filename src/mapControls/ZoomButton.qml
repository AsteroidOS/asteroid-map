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
import QtLocation

IconButton {
    required property Map mapView
    property bool zoomOut: false

    iconName: zoomOut ? "ios-remove-circle-outline" : "ios-add-circle-outline"
    iconColor: colors.primary
    onClicked: mapView.zoomLevel = mapView.zoomLevel + 0.3*(zoomOut ? -1 : 1)
}
