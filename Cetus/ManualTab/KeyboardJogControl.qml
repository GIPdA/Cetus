import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0

ApplicationItem {
    property int axes: status.synced ? status.config.axes : 3
    property var decrementKeys: ["Left", "Down", "Page Down", "["]
    property var incrementKeys: ["Right", "Up", "Page Up", "]"]
    property var axisSelectionKeys: ["X", "Y", "Z", "A"]

    id: root

    signal selectAxis(int axis)
    signal increment(bool enabled)
    signal decrement(bool enabled)
    signal selectIncrement(int index)

    QtObject {
        id: d
        function activateIncrement(axis) {
            root.selectAxis(axis);
            root.increment(true);
        }
        function deactivateIncrement(axis) {
            root.selectAxis(axis);
            root.increment(false);
        }

        function activateDecrement(axis) {
            root.selectAxis(axis);
            root.decrement(true);
        }
        function deactivateDecrement(axis) {
            root.selectAxis(axis);
            root.decrement(false);
        }
    }

    // Decrement keys
    KeystrokeWatcher {
        readonly property int index: 0
        sequence: root.decrementKeys[index]
        onPressed: d.activateDecrement(index)
        onReleased: d.deactivateDecrement(index);
        enabled: root.axes >= (index + 1) && !g_mdiOverride
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 1
        sequence: root.decrementKeys[index]
        onPressed: d.activateDecrement(index)
        onReleased: d.deactivateDecrement(index);
        enabled: root.axes >= (index + 1) && !g_mdiOverride
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 2
        sequence: root.decrementKeys[index]
        onPressed: d.activateDecrement(index)
        onReleased: d.deactivateDecrement(index);
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 3
        sequence: root.decrementKeys[index]
        onPressed: d.activateDecrement(index)
        onReleased: d.deactivateDecrement(index);
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }


    // Increment keys
    KeystrokeWatcher {
        readonly property int index: 0
        sequence: root.incrementKeys[index]
        onPressed: d.activateIncrement(index)
        onReleased: d.deactivateIncrement(index);
        enabled: root.axes >= (index + 1) && !g_mdiOverride
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 1
        sequence: root.incrementKeys[index]
        onPressed: d.activateIncrement(index)
        onReleased: d.deactivateIncrement(index);
        enabled: root.axes >= (index + 1) && !g_mdiOverride
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 2
        sequence: root.incrementKeys[index]
        onPressed: d.activateIncrement(index)
        onReleased: d.deactivateIncrement(index);
        enabled: root.axes >= (index + 1)
        autoRepeat: false
    }

    KeystrokeWatcher {
        readonly property int index: 3
        sequence: root.incrementKeys[index]
        onPressed: d.activateIncrement(index)
        onReleased: d.deactivateIncrement(index);
        enabled: root.axes >= (index + 1)
        autoRepeat: false
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
