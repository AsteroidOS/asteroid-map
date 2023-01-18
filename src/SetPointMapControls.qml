import QtQuick 2.0
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0

Item {
    PageHeader {
        text: "Add waypoint"
    }
    IconButton {
        iconName: "ios-add-circle-outline"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: - height/2 + DeviceInfo.flatTireHeight/2
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
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
        iconColor: colors.primary
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
            color: colors.primary
        }
    }
    IconButton {
        iconName: "ios-locate-outline"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height/2 + DeviceInfo.flatTireHeight/2
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
        z: 2
    }
    IconButton {
        iconName: "ios-close-circle-outline"
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
        z: 2
        onClicked: {
            parent.visible = false
            mapControls.visible = true
        }
    }
    IconButton {
        iconName: "ios-checkmark-circle-outline"
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: colors.primary
        z: 2
        onClicked: primaryButtonAction()
    }
    Icon {
        anchors.centerIn: parent
        width: parent.width*0.1
        height: width
        name: "ios-add"
        color: colors.primary
    }
}
