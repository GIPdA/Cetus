import QtQuick 2.12
import QtQuick.Controls 2.12

ToolButton {
    id: control
    property bool hideIfDisabled: false

    visible: hideIfDisabled ? enabled : true
    flat: true
    display: AbstractButton.IconOnly
    //display: AbstractButton.TextUnderIcon
    icon.color: enabled ? "transparent" : "gray"

    ToolTip.visible: hovered
    ToolTip.delay: 800
    ToolTip.timeout: 5000
    ToolTip.text: action.tooltip

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: 3
        color: Qt.darker("#777777", control.enabled && (control.checked || control.highlighted) ? 1.2 : 1.0)
        opacity: enabled ? 1 : 0
        visible: control.down || (control.enabled && (control.checked || control.highlighted))
    }

    Component.onCompleted: {
        contentItem.color = "white"
    }
}
