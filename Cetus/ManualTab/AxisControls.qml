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

    QtObject {
        id: d
        readonly property int minItemHeight: 20
        readonly property int maxItemHeight: 40
    }

    Item {
        //visible: false
        DroLabel {
            x: -width+2
            y: (root.height-height)/2
            text: qsTr("Axis Controls")
            rotated: true
        }
    }

    // Jog + / -
    RowLayout {
        Layout.maximumHeight: 80
        Layout.minimumHeight: 50
        spacing: 2

        JogButton {
            id: decrementButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: 80
            implicitWidth: implicitHeight

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
            implicitWidth: implicitHeight

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
            distance: jogCombo.distance
            onSelectAxis: axisRadioGroup.axis = axis
            onSelectIncrement: {
                if (jogCombo.currentIndex === 0)
                    jogCombo.currentIndex = index;
            }
        }

    }

    // Jog axis + increments
    RowLayout {
        spacing: 25
        Layout.maximumHeight: jogCombo.implicitHeight

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

    // Buttons
    ColumnLayout {
        id: buttonsLayout
        spacing: 1

        onVisibleChanged: RoundedRectangleHelper.updateRadiusStyle(this)

        RoundedButton {
            id: homeAllAxesButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: d.maxItemHeight
            Layout.minimumHeight: d.minItemHeight
            action: HomeAxisAction { id: homeAxisAction; axis: -1 }
            visible: homeAxisAction.homeAllAxesHelper.homingOrderDefined
            onVisibleChanged: RoundedRectangleHelper.updateRadiusStyle(buttonsLayout)

            font.pixelSize: 22
            font.italic: !enabled
        }

        RowLayout { // Home/Unhome axis
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: d.maxItemHeight
            Layout.minimumHeight: d.minItemHeight
            spacing: 1

            function update() {
                //RoundedRectangleHelper.updateRowRadiusStyle(this, !controlsItem.visible, true)
            }

            RoundedButton {
                id: homeAxisButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: d.maxItemHeight
                Layout.minimumHeight: d.minItemHeight
                action: HomeAxisAction { axis: axisRadioGroup.axis }
                //visible: !homeAllAxesButton.visible
                onVisibleChanged: parent.update()

                font.pixelSize: 22
                font.italic: !enabled
            }

            RoundedButton {
                id: unhomeAxisButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: d.maxItemHeight
                Layout.minimumHeight: d.minItemHeight
                action: UnhomeAxisAction { axis: axisRadioGroup.axis }
                onVisibleChanged: parent.update()

                font.pixelSize: 22
                font.italic: !enabled
            }
        }


        RoundedButton {
            id: touchOffButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: d.maxItemHeight
            Layout.minimumHeight: d.minItemHeight
            action: TouchOffAction { touchOffDialog: touchOffDialog }

            font.pixelSize: 22
            font.italic: !enabled
        }


        RoundedButton {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: d.maxItemHeight
            Layout.minimumHeight: d.minItemHeight
            text: qsTr("MDI Panel")
            checkable: true
            checked: rootControls.mdiPanelVisible

            font.pixelSize: 22
            font.italic: !enabled

            onCheckedChanged: {
                if (checked)
                    rootControls.showMdiControls()
                else
                    rootControls.hideMdiControls()
            }

            ToolTip.visible: hovered && !down
            ToolTip.delay: 800
            ToolTip.timeout: 5000
            ToolTip.text: qsTr("Show or hide MDI panel [F5]")
        }

        TouchOffDialog {
            id: touchOffDialog
            x: -width-30
            axis: axisRadioGroup.axis
            height: 300
        }
    }

}
