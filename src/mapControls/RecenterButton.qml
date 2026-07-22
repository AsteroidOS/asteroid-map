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

MouseArea {
    id: buttonRoot
    required property PositionSource positionSource
    required property Map mapView
    states: [
        State {
            name: "error"
            when: positionSource.valid == false
            PropertyChanges {
                target: indicatorDot
                name: "ios-locate-dot-alert.svg"
                color: "red"
            }
        },
        State {
            name: "off"
            when: positionSource.active == false
        },
        State {
            name: "acquiring"
            when: positionSource.active == true
            PropertyChanges {
                target: acquiringAnimation
                running: true
            }
        },
        State {
            name: "acquired"
            PropertyChanges {
                target: indicatorDotFill
                opacity: 1
            }
        }
    ]
    transitions: Transition {
        to: "*"
        NumberAnimation { target: indicatorDotFill; property: "opacity"; duration: 200}
    }
    Connections {
        target: positionSource
        function onPositionChanged() {
            buttonRoot.state = "acquired"
            acquiringTimer.restart()
        }
    }
    Timer { // changes back to 'acquiring' state if we've not gotten an update for a while
        id: acquiringTimer
        interval: positionSource.updateInterval * 2 // position sources don't always support the exact update interval
        repeat: false
        onTriggered: if(buttonRoot.state == "acquired") buttonRoot.state = "acquiring"
    }
    Icon {
        anchors.fill: parent
        name: "ios-locate-frame"
        color: colors.primary
    }
    Icon {
        id: indicatorDot
        anchors.fill: parent
        name: "ios-locate-dot-outline"
        color: colors.primary
        Icon {
            id: indicatorDotFill
            anchors.fill: parent
            name: "ios-locate-dot-filled"
            color: colors.primary
            opacity: 0
            SequentialAnimation on opacity {
                id: acquiringAnimation
                loops: Animation.Infinite
                running: false
                PropertyAnimation { to: 1; duration: 500}
                PropertyAnimation { to: 0; duration: 500}
            }
        }
    }
    onClicked: if(!positionSource.active) {
        positionSource.active = true
    } else {
        mapView.center = positionSource.position.coordinate
    }
    onPressAndHold: positionSource.active = false
}
