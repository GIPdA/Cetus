import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0
import "../Controls"
import "../CetusStyle"
import "../items"

ColumnLayout {
    id: root
    spacing: 10

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
            font.pixelSize: height*0.7
            font.family: CetusStyle.control.text.font.family
            font.bold: true

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
            font.pixelSize: height*0.7
            font.family: CetusStyle.control.text.font.family
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
        //Layout.leftMargin: 10
        Layout.maximumHeight: axisRadioGroup.height
        Layout.maximumWidth: root.width

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
        spacing: 2

        RoundedRectangle {
            Layout.fillWidth: true
            height: 6
            color:CetusStyle.control.background.color
            radius: CetusStyle.control.radius
            radiusStyle: RoundedRectangle.RadiusStyle.TopRadius
        }

        RoundedButton {
            id: homeAllAxesButton
            Layout.fillWidth: true
            action: HomeAxisAction { id: homeAxisAction; axis: -1 }
            visible: homeAxisAction.homeAllAxesHelper.homingOrderDefined

            font.pixelSize: 22
            font.italic: !enabled
            color: CetusStyle.control.background.colorWhen(enabled, down, false)
            textColor: CetusStyle.control.foreground.colorWhen(enabled)
            radius: CetusStyle.control.radius
        }

        RoundedButton {
            id: homeAxisButton
            Layout.fillWidth: true
            action: HomeAxisAction { axis: axisRadioGroup.axis }
            visible: !homeAllAxesButton.visible

            font.pixelSize: 22
            font.italic: !enabled
            color: CetusStyle.control.background.colorWhen(enabled, down, false)
            textColor: CetusStyle.control.foreground.colorWhen(enabled)
            radius: CetusStyle.control.radius
        }

        RoundedButton {
            Layout.fillWidth: true
            action: TouchOffAction { touchOffDialog: touchOffDialog }

            font.pixelSize: 22
            font.italic: !enabled
            color: CetusStyle.control.background.colorWhen(enabled, down, false)
            textColor: CetusStyle.control.foreground.colorWhen(enabled)
            radius: CetusStyle.control.radius
        }

        RoundedRectangle {
            Layout.fillWidth: true
            height: 6
            color:CetusStyle.control.background.color
            radius: CetusStyle.control.radius
            radiusStyle: RoundedRectangle.RadiusStyle.BottomRadius
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

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        Layout.maximumWidth: root.width

        Label {
            text: qsTr("Jog Velocity")
        }
        Item {
            Layout.fillWidth: true
        }

        Label {
            text: jogVelocitySlider.displayValue.toFixed(1) + " " + jogVelocitySlider.units
        }
    }

    CombinedJogVelocitySlider {
        id: jogVelocitySlider
        Layout.fillWidth: true
        Layout.maximumWidth: root.width
        //axis: axisRadioGroup.axis
        proportional: false
    }

    Item {
        Layout.fillHeight: true
    }
}
