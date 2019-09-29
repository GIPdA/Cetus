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
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0
import "../style"

ColumnLayout {
    property alias settings: appObject.settings
    property alias axis: handler.axis
    property alias continuousVisible: handler.continuousVisible
    property alias continuousText: handler.continuousText
    readonly property double distance: (currentIndex < handler.distanceModelReverse.length) ? handler.distanceModelReverse[currentIndex] : 0.0
    property int currentIndex: 0
    readonly property bool __ready: handler.settings.initialized

    id: root

    spacing: 3

    function __setIndex(index) {
        if (!__ready) {
            return;
        }
        root.settings.setValue("axis" + axis + ".jogIncrementSelection", index);
    }

    function __update() {
        if (!__ready)
            return

        var value = root.settings.value("axis" + axis + ".jogIncrementSelection");
        if (value !== undefined) {
            root.currentIndex = value
            if (value < repeater.count)
                repeater.itemAt(value).checked = true
        }
    }

    on__ReadyChanged: __update()

    /*! /internal
        Cannot directly connect to slots since the file property is var and not a QObject.
    */
    onSettingsChanged: {
        if (root.settings.onValuesChanged) {
            root.settings.onValuesChanged.connect(__update)
        }
    }


    ButtonGroup {
        id: buttonGroup
    }

    function changeIndex(index) {
        root.currentIndex = index
        repeater.itemAt(index).checked = true
        __setIndex(index)
    }

    Repeater {
        id: repeater
        //Layout.fillWidth: true
        model: handler.incrementsModelReverse
        onModelChanged: __update()

        Button {
            id: control
            TextMetrics {
                id: textMetrics
                font: control.font
                elide: Text.ElideNone
                elideWidth: 1
                text: modelData
            }

            Layout.fillWidth: true
            Layout.fillHeight: true
            //implicitWidth: textMetrics.width+10
            text: modelData

            contentItem: Text {
                text: control.text
                font: control.font
                //color: control.checked ? CetusStyle.control.text.color : "#BBBBBB"//control.down ? "#17a81a" : "#21be2b"
                color: control.checked ? "white" : "#BBBBBB"//control.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            checkable: true
            font.pixelSize: 22
            font.bold: control.checked

            ButtonGroup.group: buttonGroup

            padding: 0
            horizontalPadding: 0
            spacing: 0
            topInset: 0
            leftInset: 0
            rightInset: 0
            bottomInset: 0

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 35
                color: control.checked ? "#888888" : control.down ? "#2D2D2D" : "#000000"//CetusStyle.control.background.color
                border.color: "#F2F2F2"//CetusStyle.control.border.color
                border.width: 1//control.checked ? 2 : 1
                //border.color: control.down ? "#17a81a" : "#21be2b"
                radius: 4
            }

            onCheckedChanged: {
                if (checked)
                    changeIndex(index)
            }
        }


    }

    ApplicationObject {
        id: appObject
    }

    JogDistanceHandler {
        id: handler
        continuousText: "∞"
    }
}
