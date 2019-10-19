import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    id: root
    implicitHeight: repeater.count*implicitAxisHeight + topMargin + margins*2
    implicitWidth: droColumn.implicitWidth + groupLabel.implicitWidth + margins*2

    property alias axes: repeater.model
    property alias axesDelegate: repeater.delegate
    property int implicitAxisHeight: 40
    property int minimumAxisHeight: 20
    property int maximumAxisHeight: 40
    readonly property int axisHeight: d.clampAxisHeight(Math.floor(droColumn.height/repeater.count))
    readonly property int minimumImplicitHeight: repeater.count*minimumAxisHeight
    property alias label: groupLabel.text
    property int topMargin: 0
    property int margins: 0

    QtObject {
        id: d
        function clampAxisHeight(h) {
            return Math.max(minimumAxisHeight, Math.min(h, maximumAxisHeight))
        }
    }

    Rectangle {
        anchors.fill: parent
        opacity: 0
        border.width: 3
        border.color: "red"
    }

    Item {
        id: sideLabel
        anchors {
            top: parent.top
            topMargin: root.topMargin+root.margins
            bottom: parent.bottom
            bottomMargin: root.margins
            left: parent.left
            leftMargin: root.margins
        }
        width: groupLabel.implicitWidth

        DroLabel {
            id: groupLabel
            anchors {
                right: parent.right
                rightMargin: -2
                verticalCenter: parent.verticalCenter
            }
            height: parent.height
            textColor: "white"
            rotated: true
        }
    }

    ColumnLayout {
        id: droColumn
        anchors {
            top: parent.top
            topMargin: root.topMargin+root.margins
            bottom: parent.bottom
            bottomMargin: root.margins-spacing
            left: sideLabel.right
            right: parent.right
            rightMargin: root.margins
        }
        spacing: 0

        ColumnLayout {
            id: internalContentLayout
            //Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 1
            Repeater {
                id: repeater
            }
        }

        /*Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }//*/
    }
}
