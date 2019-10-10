import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0

import "../CetusStyle"

FlatSlider {
    id: root

    implicitHeight: 50

    radius: CetusStyle.control.radius
    backgroundColor: CetusStyle.control.background.color
    backgroundFillColor: CetusStyle.control.background.active.color
    sideClickStepSize: (to-from)/50
    //stepSize: 1
    padding: 0

    property alias labelText: labelText.text
    property alias valueText: valueText.text

    Label {
        id: labelText
        anchors {
            top: parent.top
            left: parent.left
            margins: 2
            leftMargin: 5
        }
        //text:
        font.pixelSize: parent.height*0.34
        font.weight: Font.Medium
        color: CetusStyle.control.foreground.color
    }

    Label {
        id: valueText
        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 3
            rightMargin: 5
        }
        //text:
        font.pixelSize: parent.height*0.4
        color: CetusStyle.control.foreground.color
    }
}
