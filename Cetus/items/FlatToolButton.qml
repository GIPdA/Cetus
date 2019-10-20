import QtQuick 2.12
import QtQuick.Controls 2.12

ToolButton {
    flat: true
    display: AbstractButton.IconOnly
    //display: AbstractButton.TextUnderIcon
    icon.color: "transparent"
    background: Item {}
    Component.onCompleted: {
        contentItem.color = "white"
    }
}
