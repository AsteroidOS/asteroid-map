import QtQuick 2.0
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0

Item {
    IconButton {
        iconName: "ios-add-circle-outline"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - height/2 + DeviceInfo.flatTireHeight/2
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: mapView.zoomLevel = mapView.zoomLevel + 0.3
    }
    IconButton {
        iconName: "ios-remove-circle-outline"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height/2 + DeviceInfo.flatTireHeight/2
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: mapView.zoomLevel = mapView.zoomLevel - 0.3
    }
    MouseArea {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - height/2 + DeviceInfo.flatTireHeight/2
        height: parent.height*0.2
        width: height
        z: 2
        rotation: compassMode.value == 1 ? 360 - compass.reading.azimuth : 45
        onClicked: compassMode.value = enableCompass.value ? (compassMode.value+1)%3 : 0
        onPressAndHold: {
            if (compassMode.value == 2) {compassMode.value = 0}
            mapView.bearing = 0
        }
        Icon {
            anchors.fill: parent
            name: compass.reading.calibrationLevel > 0 ? "ios-compass-outline" : "ios-infinite-outline"
            rotation: -45
            color: "blue"
        }
    }
    IconButton {
        iconName: "ios-locate-outline"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height/2 + DeviceInfo.flatTireHeight/2
        anchors.left: parent.left
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: positionProvider.update()
    }
    IconButton {
        iconName: "ios-menu-outline"
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: pageStack.push(settingsPage,{})
    }
    IconButton {
        iconName: "ios-pin-outline"
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
        z: 2
        onClicked: {
            parent.visible = false
            setPointControls.visible = true
        }
    }
}
