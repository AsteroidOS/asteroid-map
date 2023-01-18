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
        Component.onCompleted: {
            var waypointArray = JSON.parse(waypointList.value)
            if (editMode) {
                var currWaypointData = waypointArray[editIndex]
                root.coord = QtPositioning.coordinate(currWaypointData[1][0],currWaypointData[1][1])
                root.selectedIcon = currWaypointData[0]
                root.selectedColor = currWaypointData[2]
                textbox.text = currWaypointData[3]
            } else {
                editIndex = waypointArray.length
                selectedColor = colors.secondary
            }
        }
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
                text: Date.toLocaleString()
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
        writebuffer[4] = Date
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
