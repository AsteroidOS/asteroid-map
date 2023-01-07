import QtQuick 2.0
import org.asteroid.controls 1.0 as Asteroid
import QtPositioning 5.15
import QtLocation 5.15
import Nemo.Configuration 1.0

Item {
    id: root
    // FlatMesh {
    //     centerColor: "#003ee9"
    //     outerColor: "#00bc1b"
    //     anchors.fill: parent
    // }
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
            Asteroid.TextField {
                id: textBox
                width: parent.width
                height: parent.width*0.2
                //for the default text, we probably want a date/time
                previewText: "Waypoint name"
                text: Date().toLocaleString(Locale.ShortFormat)
            }
            ListView {
                id: iconSelectorView
                width: parent.width
                height: width*0.2
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
            Asteroid.IconButton {
                width: parent.width*0.2
                height: width
                iconName: "ios-checkmark-circle-outline"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: appendWayPoint()
            }
        }
    }

    function appendWayPoint() { //the colours.primary is currently a placeholder. it would be nice to let users select colours, but I CBA to write a colour picker right now.
        var newWayPointString = ">" + "selectedIcon" + ";" + coord + ";" + colours.primary + ";" + textBox.text + ";" + Date()
        console.log(newWayPointString)
        pageStack.pop()
    }
}
