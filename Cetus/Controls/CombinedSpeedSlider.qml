import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0

SpeedSlider {
    id: root

    implicitHeight: 30

    from: handler.minimumValue
    to: handler.maximumValue
    enabled: handler.enabled

    sideClickStepSize: proportional ? 0.01 : (to-from)/100
    stepSize: proportional ? 0.01 : 1

    QtObject {
        id: d
        property var helper: handler.core.helper
        readonly property double timeFactor: handler.enabled ? helper.timeFactor : 1
        readonly property double distanceFactor: handler.enabled ? helper.distanceFactor : 1
    }

    property bool proportional: false

    readonly property string units: proportional ? "%" : distanceUnits + "/" + timeUnits
    readonly property string distanceUnits: handler.enabled ? d.helper.distanceUnits : "?"
    readonly property string timeUnits: handler.enabled ? d.helper.timeUnits : "?"
    readonly property double displayValue: proportional ? value*100 : value * d.timeFactor * d.distanceFactor

    default property var handler

    property var core: handler.core
    property var status: handler.status
    //property var settings: handler.settings
    //property var displayValue: handler.displayValue
    //property var units: handler.units
    //property var proportional: handler.proportional


    Binding { target: root; property: "value"; value: handler.value }
    Binding { target: handler; property: "value"; value: root.value }
}
