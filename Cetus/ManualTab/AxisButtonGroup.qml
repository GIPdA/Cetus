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

    property int axis: 0
    property var axisNames: d.axisNames
    property var axisIndices: d.axisIndices

    ApplicationObject {
        id: d
        readonly property var axisNames: helper.ready ? helper.axisNamesUpper : []
        readonly property var axisIndices: helper.ready ? helper.axisIndices : []
    }

    enabled: d.status.synced
    spacing: 1

    ButtonGroup {
        id: buttonGroup
    }

    Repeater {
        id: repeater
        model: d.axisNames

        RoundedButton {
            id: control
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 40
            Layout.minimumHeight: 30
            implicitWidth: implicitHeight
            implicitHeight: 40

            ButtonGroup.group: buttonGroup

            checkable: true
            checked: index == root.axis
            font.pixelSize: 22

            text: modelData

            color: CetusStyle.control.background.colorWhen(control.enabled, control.down, control.checked)
            textColor: CetusStyle.control.foreground.colorWhen(control.enabled)

            radius: CetusStyle.control.radius
            radiusStyle: index == 0 ? RoundedRectangle.TopRadius
                                    : index == repeater.count-1 ? RoundedRectangle.BottomRadius
                                                                : RoundedRectangle.NoRadius

            onCheckedChanged: {
                if (checked)
                    root.axis = index;
            }
        }
    }

    ApplicationObject {
        id: object
    }
}
