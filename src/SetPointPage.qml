import QtQuick 2.0
import org.asteroid.controls 1.0 as Asteroid
import QtPositioning 5.15
import QtLocation 5.15
import Nemo.Configuration 1.0

Item {
    id: root
    Asteroid.PageHeader {
        text: "Add waypoint"
    }
    ConfigurationValue {
        id: waypointList
        key: "/map/waypointList"
        defaultValue: ""
    }
    property string selectedIcon: "ios-locate-outline"
    property variant coord
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
                //for the default text, we probably want a date/time
                previewText: "Waypoint name"
                text: Date.toLocaleString(Locale.ShortFormat)
            }
            ListView {
                id: iconSelectorView
                width: parent.width
                height: root.height*0.2
                orientation: ListView.Horizontal
                model: iconModel
                delegate: Asteroid.IconButton {
                    iconName: name
                    onClicked: root.selectedIcon = model.name
                    height: iconSelectorView.height
                    width: height
                    iconColor: root.selectedIcon == model.name ? colours.primary : colours.primaryUnselected
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
                width: parent.width
                Asteroid.IconButton {
                    height: parent.height
                    width: height
                    iconName: "ios-checkmark-circle-outline"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: appendWayPoint()
                }
                Asteroid.IconButton {
                    height: parent.height
                    width: height
                    iconName: "ios-trash-circle"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: removeWaypoint()
                }
            }
            Item { width: parent.width ; height: root.width*0.2 }
        }
    }

    function appendWayPoint() { //the colours.primary is currently a placeholder. it would be nice to let users select colours, but I CBA to write a colour picker right now.
        var newWayPointString = selectedIcon + ";" + coord.latitude + "," + coord.longitude + ";" + colours.primary + ";" + textBox.text + ";" + Date.now() + ">"
        console.log(newWayPointString)
        waypointList.value = waypointList.value + newWayPointString
        setPointControls.visible = false
        mapControls.visible = true
        pageStack.pop(pageStack.currentLayer)
    }
}
