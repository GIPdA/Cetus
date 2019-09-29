import QtQuick 2.12
import Machinekit.Application 1.0

ApplicationAction {
    property string groupName: "group"
    property string valueName: "value"

    id: root
    text: "Group Value"
    checkable: true
    checked: settings.initialized && settings.values[groupName][valueName]
    onTriggered: {
        settings.setValue(groupName + "." + valueName, !settings.values[groupName][valueName])
    }
}
