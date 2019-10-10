import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0

import "../Controls"
import "../DRO"
import "../CetusStyle"
import "../items"

ColumnLayout {
    id: root
    spacing: 5

    Item {
        //visible: false
        DroLabel {
            x: -width+2
            y: (root.height-height)/2
            text: qsTr("Axis Controls")
            rotated: true
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        Layout.maximumWidth: root.width
        spacing: 2

        JogButton {
            id: decrementButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: 80

            direction: -1
            distance: jogCombo.distance
            axis: axisRadioGroup.axis
            text: "-"
            font.pixelSize: height*0.9
            font.family: CetusStyle.control.text.font.family
            font.bold: true
            //font.weight: Font.Medium

            contentItem: Text {
                anchors.fill: parent
                text: decrementButton.text
                font: decrementButton.font
                color: CetusStyle.control.foreground.colorWhen(decrementButton.enabled)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: RoundedRectangle {
                implicitWidth: 50
                implicitHeight: 40
                color: CetusStyle.control.background.colorWhen(decrementButton.enabled, decrementButton.down)
                radius: CetusStyle.control.radius
                radiusStyle: RoundedRectangle.RadiusStyle.LeftRadius
            }
        }

        JogButton {
            id: incrementButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: 80

            direction: 1
            distance: jogCombo.distance
            axis: axisRadioGroup.axis
            text: "+"
            font.pixelSize: height*0.9
            font.family: CetusStyle.control.text.font.family
            //font.weight: Font.Medium
            font.bold: true

            contentItem: Text {
                anchors.fill: parent
                text: incrementButton.text
                font: incrementButton.font
                color: CetusStyle.control.foreground.colorWhen(incrementButton.enabled)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //elide: Text.ElideRight
            }
            background: RoundedRectangle {
                implicitWidth: 50
                implicitHeight: 40
                color: CetusStyle.control.background.colorWhen(incrementButton.enabled, incrementButton.down)
                radius: CetusStyle.control.radius
                radiusStyle: RoundedRectangle.RadiusStyle.RightRadius
            }
        }

        KeyboardJogControl {
            id: keyboardJogControl
            enabled: jogCombo.distance !== 0.0
            onSelectAxis: axisRadioGroup.axis = axis
            onIncrement: incrementButton._toggle(enabled)
            onDecrement: decrementButton._toggle(enabled)
            onSelectIncrement: {
                if (jogCombo.currentIndex === 0) {
                    jogCombo.currentIndex = index;
                }
            }
        }

    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        spacing: 25
        Layout.maximumHeight: axisRadioGroup.height

        AxisButtonGroup {
            id: axisRadioGroup
            Layout.fillWidth: false
            Layout.fillHeight: true
        }

        JogDistanceButtonGroup {
            id: jogCombo
            Layout.fillWidth: true
            Layout.fillHeight: true
            axis: axisRadioGroup.axis
        }

    }


    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        //Layout.maximumWidth: root.width
        spacing: 1

        onChildrenChanged: RoundedRectangleHelper.updateRadiusStyle(this)
        Component.onCompleted: RoundedRectangleHelper.updateRadiusStyle(this)

        RoundedButton {
            id: homeAllAxesButton
            Layout.fillWidth: true
            action: HomeAxisAction { id: homeAxisAction; axis: -1 }
            visible: homeAxisAction.homeAllAxesHelper.homingOrderDefined

            font.pixelSize: 22
            font.italic: !enabled
        }

        RoundedButton {
            id: homeAxisButton
            Layout.fillWidth: true
            action: HomeAxisAction { axis: axisRadioGroup.axis }
            visible: !homeAllAxesButton.visible

            font.pixelSize: 22
            font.italic: !enabled
        }

        RoundedButton {
            Layout.fillWidth: true
            action: TouchOffAction { touchOffDialog: touchOffDialog }

            font.pixelSize: 22
            font.italic: !enabled
        }

        Item {
            Layout.fillHeight: true
        }

        TouchOffDialog {
            id: touchOffDialog
            axis: axisRadioGroup.axis
            height: window.height * 0.2
        }
    }

    /*Item {
        Layout.fillHeight: true
    }//*/
}
