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

Item {
    id: root
    PageHeader {
        text: "Map settings"
    }
    Flickable {
        anchors.fill: parent
        contentHeight: contentColumn.implicitHeight
        Column {
            id: contentColumn
            anchors.fill: parent
            Item { width: parent.width ; height: root.width*0.2 }
            LabeledSwitch {
                width: parent.width
                height: root.width*0.2
                text: "enable compass"
                Component.onCompleted: checked = enableCompass.value
                onCheckedChanged: enableCompass.value = checked
            }
            LabeledSwitch {
                width: parent.width
                height: root.width*0.2
                text: "enable GPS"
                Component.onCompleted: checked = prioritiseGPS.value
                onCheckedChanged: prioritiseGPS.value = checked
            }
            Item { width: parent.width ; height: root.width*0.2 }
            Column {
                width: parent.width*0.7
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    text: "Map Data © OpenStreetMap contributors"
                    width: parent.width
                    font.pixelSize: root.width*0.05
                    wrapMode: Text.Wrap
                }
                Label {
                    text: "under the ODbL"
                    width: parent.width
                    font.pixelSize: root.width*0.05
                }
            Item { width: parent.width ; height: root.width*0.05 }
                Label {
                    text: "Made by dodoradio"
                    width: parent.width
                    font.pixelSize: root.width*0.05
                }
                Label {
                    text: "dodorad.io"
                    width: parent.width
                    font.pixelSize: root.width*0.05
                }
            }
            Item { width: parent.width ; height: root.width*0.2 }
        }
    }
}
