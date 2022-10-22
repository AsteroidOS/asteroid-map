import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15

Item {
    Label {
        text: "Map Data from OpenStreetMap"
        anchors.centerIn: parent
        z: 0
    }
    Map {
        id: mapView
        plugin: mapProvider
        anchors.fill: parent
        copyrightsVisible: false //this is compensated by showing the copyright when application is loading
        color: "#00000000"
        z: 1
    }
    IconButton {
        iconName: "ios-add-circle-outline"
        anchors.right: parent.right
        anchors.bottom: parent.verticalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: mapView.zoomLevel = mapView.zoomLevel + 0.3
    }
    IconButton {
        iconName: "ios-remove-circle-outline"
        anchors.right: parent.right
        anchors.top: parent.verticalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: mapView.zoomLevel = mapView.zoomLevel - 0.3
    }
    IconButton {
        iconName: "ios-locate-outline"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
    }
    IconButton {
        iconName: "ios-menu-outline"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: pageStack.push(settingsPage,{})
    }
}
