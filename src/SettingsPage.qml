import QtQuick 2.0
import org.asteroid.controls 1.0
import QtPositioning 5.15
import QtLocation 5.15

Item {
    id: root
    PageHeader {
        text: "Map settings"
    }
    Flickable {
        anchors.fill: parent
        contentHeight: contentColumn.implicitHeight
        anchors.leftMargin: root.width*0.15
        anchors.rightMargin: root.width*0.15
        Column {
            id: contentColumn
            anchors.fill: parent
            Item { width: parent.width ; height: root.width*0.2 }
            LabeledSwitch {
                width: parent.width
                height: root.width*0.2
                text: "enable compass"
                Component.onCompleted: checked = enableCompass.value
                onCheckedChanged: enableCompass.value = checked
            }
            LabeledSwitch {
                width: parent.width
                height: root.width*0.2
                text: "enable GPS"
                Component.onCompleted: checked = prioritiseGPS.value
                onCheckedChanged: prioritiseGPS.value = checked
            }
            Row {
                width: parent.width
                height: root.width*0.2
                // Icon {
                //     name: "ios-information-circle-outline"
                //     height: parent.height
                //     width: height
                // }
                Column {
                    height: parent.height
                    width: parent.width - parent.height
                    Label {
                        text: "Map Data © OpenStreetMap contributors"
                        width: parent.width
                        font.pixelSize: root.width*0.05
                        wrapMode: Text.Wrap
                    }
                    Label {
                        text: "under the ODbL"
                        width: parent.width
                        font.pixelSize: root.width*0.05
                    }
                }
            }
            Item { width: parent.width ; height: root.width*0.2 }
        }
    }
}
