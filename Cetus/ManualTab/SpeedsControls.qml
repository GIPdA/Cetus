import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0

import "../Controls"
import "../DRO"
import "../CetusStyle"
import "../items"

ColumnLayout {
    id: root
    spacing: 1

    onChildrenChanged: RoundedRectangleHelper.updateRadiusStyle(root)
    Component.onCompleted: RoundedRectangleHelper.updateRadiusStyle(root)

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
        implicitHeight: 50
        proportional: false

        labelText: qsTr("Jog Velocity")
        valueText: displayValue.toFixed(1) + " " + units

        handler: MultiAxisJogVelocityHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        implicitHeight: 50
        proportional: true

        labelText: qsTr("Feed Override")
        valueText: displayValue.toFixed(0) + " " + units

        handler: FeedrateHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        implicitHeight: 50
        proportional: true

        labelText: qsTr("Rapid Override")
        valueText: displayValue.toFixed(0) + " " + units

        handler: RapidrateHandler {}
    }

    CombinedSpeedSlider {
        Layout.fillWidth: true
        implicitHeight: 50
        proportional: false

        labelText: qsTr("Max Velocity")
        valueText: displayValue.toFixed(1) + " " + units

        handler: MaximumVelocityHandler {}
    }

}
