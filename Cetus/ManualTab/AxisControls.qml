import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0
import "../Controls"
import "../style"

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
            //Layout.fillHeight: true
            //implicitWidth: 50
            direction: -1
            distance: jogCombo.distance
            axis: axisRadioGroup.axis
            text: "<"
            font.pixelSize: CetusStyle.control.text.font.pixelSize*2
            font.family: CetusStyle.control.text.font.family
            font.bold: true
            topPadding: 0

            contentItem: Text {
                text: decrementButton.text
                font: decrementButton.font
                color: CetusStyle.control.text.color
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 40
                color: decrementButton.down ? "#2D2D2D" : "#000000"//CetusStyle.control.background.color
                border.color: "#F2F2F2"//CetusStyle.control.border.color
                border.width: 1
                //border.color: control.down ? "#17a81a" : "#21be2b"
                radius: 4
            }
        }

        JogButton {
            id: incrementButton
            Layout.fillWidth: true
            //Layout.fillHeight: true
            //implicitWidth: 50
            direction: 1
            distance: jogCombo.distance
            axis: axisRadioGroup.axis
            text: ">"
            font.pixelSize: CetusStyle.control.text.font.pixelSize*2
            font.family: CetusStyle.control.text.font.family
            font.bold: true
            topPadding: 0

            contentItem: Text {
                text: incrementButton.text
                font: incrementButton.font
                color: CetusStyle.control.text.color
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 40
                color: incrementButton.down ? "#2D2D2D" : "#000000"//CetusStyle.control.background.color
                border.color: "#F2F2F2"//CetusStyle.control.border.color
                border.width: 1
                //border.color: control.down ? "#17a81a" : "#21be2b"
                radius: 4
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
        spacing: 6
        //Layout.leftMargin: 10
        Layout.maximumHeight: axisRadioGroup.height
        Layout.maximumWidth: root.width

        AxisButtonGroup {
            id: axisRadioGroup
            Layout.fillWidth: false
            Layout.fillHeight: true
        }

        Rectangle {
            Layout.fillHeight: true
            width: 3
            radius: 2
            //color: "steelblue"
            opacity: 0.5
        }

        JogDistanceButtonGroup {
            id: jogCombo
            Layout.fillWidth: true
            Layout.fillHeight: true
            axis: axisRadioGroup.axis
        }

    }


    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: false
        //Layout.maximumWidth: root.width

        Button {
            id: homeAllAxesButton
            Layout.fillWidth: false
            action: HomeAxisAction { id: homeAxisAction; axis: -1 }
            visible: homeAxisAction.homeAllAxesHelper.homingOrderDefined
        }

        Button {
            id: homeAxisButton
            Layout.fillWidth: false
            action: HomeAxisAction { axis: axisRadioGroup.axis }
            visible: !homeAllAxesButton.visible
        }

        Button {
            Layout.fillWidth: false
            action: TouchOffAction { touchOffDialog: touchOffDialog }
        }

        Item {
            Layout.fillWidth: true
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
