import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../Controls"
import "../DRO"
import "../CetusStyle"
import "../items"

ColumnLayout {
    id: root
    spacing: 1

    onVisibleChanged: RoundedRectangleHelper.updateRadiusStyle(this)

    ApplicationObject {
        id: d
        readonly property bool spindleOverrideVisible: status.synced && status.ui.spindleOverrideVisible
        readonly property bool ready: status.synced
        readonly property int minItemHeight: 30
        readonly property int maxItemHeight: 50

        onReadyChanged: RoundedRectangleHelper.updateRadiusStyle(root)
    }

    Item {
        //visible: false
        DroLabel {
            x: -width+2
            y: (root.height-height)/2
            text: qsTr("Speeds")
            rotated: true
        }
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: d.maxItemHeight
        Layout.minimumHeight: d.minItemHeight

        labelText: qsTr("Jog Velocity")
        valueText: displayValue.toFixed(1) + " " + units

        handler: MultiAxisJogVelocityHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: d.maxItemHeight
        Layout.minimumHeight: d.minItemHeight
        proportional: true

        labelText: qsTr("Feed Override")
        valueText: displayValue.toFixed(0) + " " + units

        handler: FeedrateHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: d.maxItemHeight
        Layout.minimumHeight: d.minItemHeight
        proportional: true

        labelText: qsTr("Rapid Override")
        valueText: displayValue.toFixed(0) + " " + units

        handler: RapidrateHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: d.maxItemHeight
        Layout.minimumHeight: d.minItemHeight
        proportional: false

        labelText: qsTr("Max Velocity")
        valueText: displayValue.toFixed(1) + " " + units

        handler: MaximumVelocityHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: d.maxItemHeight
        Layout.minimumHeight: d.minItemHeight
        visible: d.spindleOverrideVisible
        onVisibleChanged: RoundedRectangleHelper.updateRadiusStyle(root)
        proportional: true

        labelText: qsTr("Spindle Override")
        valueText: displayValue.toFixed(1) + " " + units

        handler: SpindlerateHandler {}
    }

}
