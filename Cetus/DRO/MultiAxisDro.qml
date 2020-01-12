import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    id: root
    implicitHeight: repeater.count*implicitAxisHeight + topMargin
    implicitWidth: droColumn.implicitWidth + groupLabel.implicitWidth

    property alias axes: repeater.model
    property alias axesDelegate: repeater.delegate
    property int implicitAxisHeight: 40
    property int minimumAxisHeight: 20
    property int maximumAxisHeight: 45
    readonly property int axisHeight: d.clampAxisHeight(Math.floor(droColumn.height/repeater.count))
    readonly property int minimumImplicitHeight: repeater.count*minimumAxisHeight + topMargin
    readonly property int maximumImplicitHeight: repeater.count*maximumAxisHeight + topMargin
    property alias label: groupLabel.text
    property int topMargin: 0

    QtObject {
        id: d
        function clampAxisHeight(h) {
            return Math.max(minimumAxisHeight, Math.min(h, maximumAxisHeight))
        }
    }


    Item {
        id: sideLabel
        anchors {
            top: parent.top
            topMargin: root.topMargin
            bottom: parent.bottom
            left: parent.left
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
            topMargin: root.topMargin
            bottom: parent.bottom
            left: sideLabel.right
            right: parent.right
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
    }
}
