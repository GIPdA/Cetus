import QtQuick 2.4
import QtQuick.Controls 2.5

import "../CetusStyle"

Button {
    id: control

    property alias radius: backgroundItem.radius
    property alias radiusStyle: backgroundItem.radiusStyle
    property alias color: backgroundItem.color

    property alias textColor: textItem.color

    color: CetusStyle.control.background.colorWhen(enabled, down, checked)
    textColor: CetusStyle.control.foreground.colorWhen(enabled)
    radius: CetusStyle.control.radius

    implicitHeight: backgroundItem.implicitHeight+topPadding+bottomPadding
    implicitWidth: 80

    contentItem: Text {
        id: textItem
        anchors.fill: parent
        text: control.text
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    padding: 0
    horizontalPadding: 0
    verticalPadding: 0
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    spacing: 0
    topInset: 0
    leftInset: 0
    rightInset: 0
    bottomInset: 0

    background: RoundedRectangle {
        id: backgroundItem
        implicitWidth: 100
        implicitHeight: 35
    }
}
