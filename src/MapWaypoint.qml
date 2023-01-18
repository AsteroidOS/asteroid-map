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
import org.asteroid.controls 1.0 as Asteroid
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: root
    anchorPoint.x: width/2
    anchorPoint.y: height
    zoomLevel: 0
    autoFadeIn: false
    property string iconName
    property color iconColor
    property int index
    sourceItem: Asteroid.IconButton {
        width: Asteroid.Dims.w(12)
        iconName: "waypoint"
        height: width
        iconColor: root.iconColor.hsvValue < 0.5 ? "#E0E0E0" : colors.primary
        Asteroid.Icon {
            anchors.centerIn: parent
            width: parent.width*0.9
            height: width
            name: root.iconName
            color: root.iconColor
        }
        onClicked: editWaypoint(index)
    }
}
