import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import "../items"

Slider {
    id: control

    implicitWidth: 200
    implicitHeight: 80

    property alias radius: mask.radius
    property alias radiusStyle: mask.radiusStyle

    property alias backgroundColor: background.color
    property alias backgroundFillColor: backgroundFill.color
    property alias handleColor: handleRectangle.color
    property real sideClickStepSize: stepSize

    // Overwrite "side" clicks for small increase/decrease
    MouseArea {
        id: sideClicks_ma
        anchors.fill: parent
        enabled: !handle_ma.hovered
        //propagateComposedEvents: true

        onClicked: {
            if (control.horizontal) {
                if (mouse.x > control.visualPosition * control.width)
                    control.value += sideClickStepSize
                else
                    control.value -= sideClickStepSize
            } else {
                if (mouse.y < control.visualPosition * control.height)
                    control.value += sideClickStepSize
                else
                    control.value -= sideClickStepSize
            }
        }
    }

    states: [
        State {
            name: "horizontal"
            when: control.horizontal
            PropertyChanges {
                target: backgroundFill
                anchors.left: control.mirrored ? undefined : background.left
                anchors.right: control.mirrored ? background.right : undefined
                height: control.availableHeight
                width: control.position * control.availableWidth
            }
            PropertyChanges {
                target: handleRectangle
                anchors.horizontalCenter: control.mirrored ? backgroundFill.left : backgroundFill.right
                height: control.availableHeight
                width: control.pressed || handle_ma.hovered ? 10 : 2
            }
            PropertyChanges {
                target: handleItem
                x: control.leftPadding + (control.visualPosition * (control.availableWidth)) - handleItem.width/2
                y: control.topPadding
                implicitHeight: parent.height
                implicitWidth: 10
            }
        },
        State {
            name: "vertical"
            when: control.vertical
            PropertyChanges {
                target: backgroundFill
                anchors.bottom: background.bottom
                height: (control.position) * parent.height
                width: parent.width
            }
            PropertyChanges {
                target: handleRectangle
                anchors.verticalCenter: backgroundFill.top
                height: control.pressed || handle_ma.hovered ? 10 : 2
                width: parent.width
            }
            PropertyChanges {
                target: handleItem
                x: control.leftPadding
                y: control.topPadding + ((control.visualPosition) * control.availableHeight) - handleItem.height/2
                implicitHeight: 10
                implicitWidth: parent.width
            }
        }
    ]

    background: Item {
        x: control.leftPadding
        y: control.topPadding

        width: control.availableWidth
        height: control.availableHeight

        RoundedRectangle {
            id : mask
            anchors.fill: parent
            visible: false // OpacityMask will display it
            //radius:
            //radiusStyle:
        }

        Rectangle {
            id: background
            anchors.fill: parent
            visible: false // OpacityMask will display it
            color: "#bdbebf"

            Rectangle {
                id: backgroundFill
                color: "#21be2b"
                //radius: 2

                Rectangle {
                    id: handleRectangle
                    radius: 2
                    color: "#A0A0A0"
                    //opacity: 0.5

                }
            }
        }

        OpacityMask {
            anchors.fill: parent
            source: background
            maskSource: mask
        }
    }

    handle: Item {
        id: handleItem

        MouseArea {
            id: handle_ma
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            propagateComposedEvents: true
            hoverEnabled: true
            property bool hovered: false
            onEntered: hovered = true
            onExited: hovered = false
        }
    }
}
