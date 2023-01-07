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
    sourceItem: Asteroid.Icon {
        width: Asteroid.Dims.w(12)
        height: width
        name: root.iconName
        color: root.iconColor
    }
}
