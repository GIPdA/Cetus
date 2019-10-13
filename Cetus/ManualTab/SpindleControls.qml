import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../Controls"
import "../DRO"
import "../CetusStyle"
import "../items"
import "../icons"

ColumnLayout {
    id: root
    spacing: 1
    visible: d.spindleCcwVisible || d.spindleCwVisible || d.spindleMinusVisible || d.spindlePlusVisible || d.spindleStopVisible

    ApplicationObject {
        id: d
        readonly property bool spindleCwVisible: status.synced && status.ui.spindleCwVisible
        readonly property bool spindleCcwVisible: status.synced && status.ui.spindleCcwVisible
        readonly property bool spindleStopVisible: status.synced && status.ui.spindleStopVisible
        readonly property bool spindlePlusVisible: status.synced && status.ui.spindlePlusVisible
        readonly property bool spindleMinusVisible: status.synced && status.ui.spindleMinusVisible
    }

    Item {
        //visible: false
        DroLabel {
            x: -width+2
            y: (root.height-height)/2
            text: qsTr("Spindle")
            rotated: true
        }
    }

    RowLayout {
        id: controlsItem
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 50
        Layout.maximumHeight: 50
        Layout.minimumHeight: 30
        spacing: 1

        visible: d.spindleCcwVisible || d.spindleStopVisible || d.spindleCwVisible
        onVisibleChanged: speedsLayout.update()
        function update() {
            RoundedRectangleHelper.updateRowRadiusStyle(this, true, !speedsLayout.visible)
        }

        onChildrenChanged: update()
        Component.onCompleted: update()

        RoundedButton {
            id: ccwButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: SpindleCcwAction {}
            visible: d.spindleCcwVisible
            onVisibleChanged: parent.update()
            text: ""

            ColumnLayout {
                anchors.fill: parent
                anchors.topMargin: 2
                spacing: 0
                Icon {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    icon: "reload"
                    mirror: true
                    opacity: ccwButton.enabled ? 1.0 : 0.3
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    visible: ccwButton.height > 40
                    text: ccwButton.action.text
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    font.italic: !enabled
                    color: CetusStyle.control.foreground.colorWhen(ccwButton.enabled)
                }
            }
        }

        RoundedButton {
            id: startStopButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: StopSpindleAction { }
            visible: d.spindleStopVisible
            onVisibleChanged: parent.update()
            text: ""

            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Icon {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    icon: "stop"
                    mirror: true
                    opacity: startStopButton.enabled ? 1.0 : 0.3
                    scale: 0.8
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    visible: startStopButton.height > 40
                    text: startStopButton.action.text
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    font.italic: !enabled
                    color: CetusStyle.control.foreground.colorWhen(startStopButton.enabled)
                }
            }
        }

        RoundedButton {
            id: cwButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: SpindleCwAction { }
            visible: d.spindleCwVisible
            onVisibleChanged: parent.update()
            text: ""

            ColumnLayout {
                anchors.fill: parent
                anchors.topMargin: 2
                spacing: 0
                Icon {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    icon: "reload"
                    opacity: cwButton.enabled ? 1.0 : 0.3
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    visible: cwButton.height > 40
                    text: cwButton.action.text
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    font.italic: !enabled
                    color: CetusStyle.control.foreground.colorWhen(cwButton.enabled)
                }
            }
        }
    }

    RowLayout {
        id: speedsLayout
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 50
        Layout.maximumHeight: 50
        Layout.minimumHeight: 30
        spacing: 1

        visible: d.spindleMinusVisible || d.spindlePlusVisible
        onVisibleChanged: controlsItem.update()
        function update() {
            RoundedRectangleHelper.updateRowRadiusStyle(this, !controlsItem.visible, true)
        }

        RoundedButton {
            id: spindleDecreaseButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: DecreaseSpindleSpeedAction { }
            visible: d.spindleMinusVisible
            onVisibleChanged: parent.update()
            font.pixelSize: height
            font.family: CetusStyle.control.text.font.family
            //font.weight: Font.Medium
            font.bold: true
        }
        RoundedButton {
            id: spindleIncreaseButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: IncreaseSpindleSpeedAction { }
            visible: d.spindlePlusVisible
            onVisibleChanged: parent.update()
            font.pixelSize: height
            font.family: CetusStyle.control.text.font.family
            //font.weight: Font.Medium
            font.bold: true
        }
    }
}
