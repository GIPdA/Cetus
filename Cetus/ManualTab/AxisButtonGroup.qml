/****************************************************************************
**
** Copyright (C) 2014 Alexander Rössler
** License: LGPL version 2.1
**
** This file is part of QtQuickVcp.
**
** All rights reserved. This program and the accompanying materials
** are made available under the terms of the GNU Lesser General Public License
** (LGPL) version 2.1 which accompanies this distribution, and is available at
** http://www.gnu.org/licenses/lgpl-2.1.html
**
** This library is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
** Lesser General Public License for more details.
**
** Contributors:
** Alexander Rössler @ The Cool Tool GmbH <mail DOT aroessler AT gmail DOT com>
**
****************************************************************************/

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../CetusStyle"
import "../items"

ColumnLayout {
    id: root

    property alias core: object.core
    property alias status: object.status
    property alias helper: object.helper
    property alias currentIndex: axisGroup.currentIndex
    property int axis: 0
    property var axisNames: helper.ready ? helper.axisNamesUpper : ["X", "Y", "Z"]
    property var axisIndices: helper.ready ? helper.axisIndices : [0, 1, 2]
    property var axisHomed: _ready ? status.motion.axis : [{"homed":false}, {"homed":false}, {"homed":false}, {"homed":false}]

    readonly property bool _ready: status.synced
    readonly property int __axes: axisNames.length

    enabled: status.synced
    //height: 40
    spacing: 1

    Binding {
        target: root
        property: "axis"
        value: root.axisIndices[root.currentIndex]
    }

    Binding {
        target: root
        property: "currentIndex"
        value: root.axisIndices.indexOf(root.axis)
    }

    ButtonGroup {
        id: axisGroup
        property int currentIndex: 0
        buttons: axisButonsRepeater.children
    }

    Repeater {
        id: axisButonsRepeater
        model: __axes

        RadioButton {
            id: radioButton
            Layout.fillWidth: true
            implicitWidth: 40
            implicitHeight: 40
            ButtonGroup.group: axisGroup

            text: root.axisNames[index]

            indicator: RoundedRectangle {
                implicitWidth: radioButton.implicitWidth
                implicitHeight: implicitWidth
                radius: CetusStyle.control.radius
                radiusStyle: index == 0 ? RoundedRectangle.TopRadius
                                        : index == axisButonsRepeater.count-1 ? RoundedRectangle.BottomRadius
                                                                              : RoundedRectangle.NoRadius

                //root.axisHomed[index] && root.axisHomed[index].homed
                color: CetusStyle.control.background.colorWhen(radioButton.enabled, radioButton.pressed, radioButton.checked)

                Text {
                    //id: axisTitleText
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    //font.family: CetusStyle.control.text.font.family
                    text: root.axisNames[index]
                    color: CetusStyle.control.foreground.colorWhen(radioButton.enabled)
                }
            }

            contentItem: Item {
                implicitWidth: radioButton.implicitWidth
                implicitHeight: implicitWidth
            }

            onCheckedChanged: {
                if (checked)
                    axisGroup.currentIndex = index;
            }

            Binding {
                target: radioButton
                property: "checked"
                value: index === axisGroup.currentIndex
            }
        }

    }

    ApplicationObject {
        id: object
    }
}