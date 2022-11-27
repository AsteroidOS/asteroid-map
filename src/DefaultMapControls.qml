import QtQuick 2.0
import org.asteroid.controls 1.0

Item {
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
