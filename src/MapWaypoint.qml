import QtQuick 2.0
import org.asteroid.controls 1.0 as Asteroid
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: root
    anchorPoint.x: width/2
    anchorPoint.y: height
    zoomLevel: 0
    autoFadeIn: false
    property string iconName
    property color iconColor
    property int index
    sourceItem: Asteroid.IconButton {
        width: Asteroid.Dims.w(12)
        iconName: "waypoint"
        height: width
        iconColor: root.iconColor.hsvValue < 0.5 ? "#E0E0E0" : colors.primary
        Asteroid.Icon {
            anchors.centerIn: parent
            width: parent.width*0.9
            height: width
            name: root.iconName
            color: root.iconColor
        }
        onClicked: editWaypoint(index)
    }
}
