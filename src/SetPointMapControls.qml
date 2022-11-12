import QtQuick 2.0
import org.asteroid.controls 1.0

Item {
    PageHeader {
        text: "Add waypoint"
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
        iconName: "ios-close-circle-outline"
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        height: parent.height*0.2
        width: height
        iconColor: "blue"
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
        iconColor: "blue"
        z: 2
        onClicked: primaryButtonAction()
    }
    Icon {
        anchors.centerIn: parent
        width: parent.width*0.1
        height: width
        name: "ios-add"
        color: "blue"
    }
}
