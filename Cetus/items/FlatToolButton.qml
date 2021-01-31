import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

ToolButton {
    id: control
    property bool hideIfDisabled: false

    implicitWidth: 40
    implicitHeight: 40

    visible: hideIfDisabled
             ? enabled
             : (action.visible !== undefined ? action.visible : true)
    flat: true
    display: AbstractButton.IconOnly
    //display: AbstractButton.TextUnderIcon
    icon.color: !enabled ? Material.hintTextColor : "transparent"

    ToolTip.visible: hovered && !down
    ToolTip.delay: 800
    ToolTip.timeout: 5000
    ToolTip.text: action.tooltip

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        radius: 2
        color: !control.enabled ? control.Material.buttonDisabledColor :
                                  control.highlighted ? control.Material.highlightedButtonColor :
                                                        control.checked ? control.Material.accentColor :
                                                                          control.Material.buttonColor

        Ripple {
            clipRadius: 2
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: control.down || control.visualFocus || control.hovered
            color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}
