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
import Nemo.Configuration 1.0

Item {
    id: root
    Asteroid.PageHeader {
        text: editMode ? "Edit waypoint" : "Add waypoint"
    }
    ConfigurationValue {
        id: waypointList
        key: "/map/waypointList"
        defaultValue: "[]"
        Component.onCompleted: {
            var waypointArray = JSON.parse(waypointList.value)
            if (editMode) {
                var currWaypointData = waypointArray[editIndex]
                root.coord = QtPositioning.coordinate(currWaypointData[1][0],currWaypointData[1][1])
                root.selectedIcon = currWaypointData[0]
                root.selectedColor = currWaypointData[2]
                textBox.text = currWaypointData[3]
                dateLabel.text = Qt.formatDateTime(currWaypointData[4])
            } else {
                editIndex = waypointArray.length
                selectedColor = colors.secondary
            }
        }
    }
    Asteroid.HandWritingKeyboard {
        anchors.fill: parent
    }
    property string selectedIcon: "ios-locate-outline"
    property string selectedColor
    property variant coord
    property bool editMode: false
    property int editIndex
    Flickable {
        anchors.fill: parent
        contentHeight: contentColumn.implicitHeight
        anchors.leftMargin: root.width*0.15
        anchors.rightMargin: root.width*0.15
        Column {
            id: contentColumn
            anchors.fill: parent
            Item { width: parent.width ; height: root.width*0.2 }

            Asteroid.TextField {
                id: textBox
                width: parent.width
                height: parent.width*0.2
                previewText: "Waypoint name"
                text: Qt.formatDateTime(new Date)
            }

            Asteroid.Label {
                id: dateLabel
                width: parent.width
                height: root.width*0.1
                visible: editMode
            }
            ListView {
                id: iconSelectorView
                width: root.width
                height: root.height*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: ListView.Horizontal
                model: iconModel
                delegate: Asteroid.IconButton {
                    iconName: name
                    onClicked: root.selectedIcon = model.name
                    height: iconSelectorView.height
                    width: height
                    iconColor: root.selectedIcon == model.name ? colors.textDefault : colors.textUnselected
                }
                ListModel {
                    id: iconModel
                    ListElement {
                        name: "ios-locate-outline"
                    }
                    ListElement {
                        name: "ios-checkmark"
                    }
                    ListElement {
                        name: "ios-help"
                    }
                    ListElement {
                        name: "ios-information"
                    }
                    ListElement {
                        name: "ios-body-outline"
                    }
                    ListElement {
                        name: "ios-bicycle"
                    }
                    ListElement {
                        name: "ios-car-outline"
                    }
                    ListElement {
                        name: "ios-boat-outline"
                    }
                }
            }
            Row {
                height: root.width*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Asteroid.IconButton {
                    height: parent.height
                    width: height
                    iconName: "ios-trash-circle"
                    visible: editMode
                    onClicked: removeWaypoint(editIndex)
                }
                Asteroid.IconButton {
                    height: parent.height
                    width: height
                    iconName: "ios-checkmark-circle-outline"
                    onClicked: commitChanges(editIndex)
                }
            }
            Item { width: parent.width ; height: root.width*0.2 }
        }
    }

    function commitChanges(index) {
        var waypointArray = JSON.parse(waypointList.value)
        var writebuffer = {}
        writebuffer[0] = selectedIcon
        writebuffer[1] = [coord.latitude,coord.longitude]
        writebuffer[2] = selectedColor //the colors.secondary is currently a placeholder. it would be nice to let users select colours, but I CBA to write a colour picker right now
        writebuffer[3] = textBox.text
        writebuffer[4] = new Date()
        waypointArray[index] = writebuffer
        waypointList.value = JSON.stringify(waypointArray)
        setPointControls.visible = false
        mapControls.visible = true
        pageStack.pop(pageStack.currentLayer)
    }
    function removeWaypoint(index) {
        var waypointArray = JSON.parse(waypointList.value)
        waypointArray.splice(index)
        waypointList.value = JSON.stringify(waypointArray)
        setPointControls.visible = false
        mapControls.visible = true
        pageStack.pop(pageStack.currentLayer)
    }
}
