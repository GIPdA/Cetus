import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

ApplicationItem {
    id: root
    property int axes: status.synced ? status.config.axes : 3
    property var decrementKeys: ["Left", "Down", "Page Down", "["]
    property var incrementKeys: ["Right", "Up", "Page Up", "]"]
    property var axisSelectionKeys: ["X", "Y", "Z", "A"]

    property double distance: 0.0

    property bool useSafeJog: true
    property int safeJogInterval: 100 // ms
    property double safeJogDistanceFactor: 1.2 // Add 20% distance to send the next jog command just before it ends

    signal selectAxis(int axis)
    signal selectIncrement(int index)


    // Jog key events for each axis
    Repeater {
        model: axes

        Item {
            id: d
            property int axis: index
            property double velocity: jogAction.settings.initialized ? jogAction.settings.values["axis" + axis]["jogVelocity"] : 0.0

            JogAction {
                id: jogAction
                axis: index
                distance: root.distance
                safeJogInterval: root.safeJogInterval
                safeDistance: useSafeJog ? Math.abs(velocity) * safeJogInterval/1000 * safeJogDistanceFactor : 0.0
            }

            // Decrement key
            KeystrokeWatcher {
                sequence: root.decrementKeys[index]
                onPressed: {
                    selectAxis(d.axis)
                    jogAction.velocity = -d.velocity
                    jogAction.trigger()
                }
                onReleased: {
                    if (jogAction.distance === 0.0) {
                        jogAction.velocity = 0
                        jogAction.trigger()
                    }
                }
                enabled: !g_mdiOverride
                autoRepeat: false
            }

            // Increment key
            KeystrokeWatcher {
                sequence: root.incrementKeys[index]
                onPressed: {
                    selectAxis(d.axis)
                    jogAction.velocity = d.velocity
                    jogAction.trigger()
                }
                onReleased: {
                    if (jogAction.distance === 0.0) {
                        jogAction.velocity = 0
                        jogAction.trigger()
                    }
                }
                enabled: !g_mdiOverride
                autoRepeat: false
            }
        }
    }


    // Axis Selection
    Shortcut {
        readonly property int index: 0
        sequence: root.axisSelectionKeys[index]
        onActivated: root.selectAxis(index)
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }

    Shortcut {
        readonly property int index: 1
        sequence: root.axisSelectionKeys[index]
        onActivated: root.selectAxis(index)
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }

    Shortcut {
        readonly property int index: 2
        sequence: root.axisSelectionKeys[index]
        onActivated: root.selectAxis(index)
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }

    Shortcut {
        readonly property int index: 3
        sequence: root.axisSelectionKeys[index]
        onActivated: root.selectAxis(index)
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }
}
