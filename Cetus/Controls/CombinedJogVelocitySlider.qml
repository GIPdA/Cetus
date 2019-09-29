import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0

Slider {
    property alias core: handler.core
    property alias status: handler.status
    property alias settings: handler.settings
    property alias displayValue: handler.displayValue
    property alias units: handler.units
    property alias proportional: handler.proportional

    id: root
    from: handler.proportional ? handler.minimumProportion : handler.minimumValue
    to: handler.proportional ? 100.0 : handler.maximumValue
    enabled: handler.enabled

    CombinedJogVelocityHandler {
        id: handler
    }

    Binding { target: root; property: "value"; value: handler.value }
    Binding { target: handler; property: "value"; value: root.value }
}
