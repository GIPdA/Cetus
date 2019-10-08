import QtQuick 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../icons"

AbstractDigitalReadOut {
    id: root
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight
    visible: _ready
    offsetsVisible: true

    readonly property string units: helper.ready ? helper.distanceUnits + "/" + helper.timeUnits : "?"

    /*function serialize(object, maxDepth) {
        function _processObject(object, maxDepth, level) {
            var output = []
            var pad = "  "
            if (maxDepth === undefined) {
                maxDepth = -1
            }
            if (level === undefined) {
                level = 0
            }
            var padding = new Array(level + 1).join(pad)

            output.push((Array.isArray(object) ? "[" : "{"))
            var fields = []
            for (var key in object) {
                if (typeof object[key] == "function")
                    continue
                var keyText = Array.isArray(object) ? "" : ("\"" + key + "\": ")
                if (typeof (object[key]) == "object" && key !== "parent" && maxDepth !== 0) {
                    var res = _processObject(object[key], maxDepth > 0 ? maxDepth - 1 : -1, level + 1)
                    fields.push(padding + pad + keyText + res)
                } else {
                    fields.push(padding + pad + keyText + "\"" + object[key] + "\"")
                }
            }
            output.push(fields.join(",\n"))
            output.push(padding + (Array.isArray(object) ? "]" : "}"))

            return output.join("\n")
        }

        return _processObject(object, maxDepth)
    }

    property bool ready: helper.ready
    onReadyChanged: {
        if (ready) {
            console.log(">> " + "helper")
            print(serialize(helper))
            console.log("<<")
        }
    }
    property bool synced: status.synced
    onSyncedChanged: {
        if (synced) {
            console.log(">> " + "status")
            print(serialize(status))
            console.log("<<")
        }
    }//*/

    Rectangle {
        anchors.fill: parent
        opacity: 0
        border.width: 3
        border.color: "red"
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 15

        MultiAxisDro { // Main DRO
            id: mainDro
            Layout.fillWidth: true
            topMargin: 25

            label: qsTr("DRO")

            axes: {
                var list = []
                for (var i = 0; i < root.axes; ++i) {
                    var item = {}
                    item.name = root.axisNames[i]
                    item.homed = (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed
                    item.position = Number(root.position[root._axisNames[i]])
                    item.distanceToGo = Number(root.dtg[root._axisNames[i]])
                    list.push(item)
                }

                if (root.lathe) {
                    // Lathe mode, X is replaced by Rad, Dia is inserted juste after
                    item = list[0]
                    item.name = qsTr("Rad")

                    item = Object.assign({}, item) // copy item
                    item.name = qsTr("Dia")
                    item.position = Number(root.position['x']) * 2.0
                    item.distanceToGo = Number(root.dtg['x']) * 2.0
                    list.splice(1, 0, item)
                }
                return list
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                axisName: modelData.name
                axisColor: "#0096EC"

                radiusStyle: index == 0 ? DroAxisRow.RadiusStyle.TopRadius
                                        : index === (mainDro.axes.length-1) ? DroAxisRow.RadiusStyle.BottomRadius
                                                                            : DroAxisRow.RadiusStyle.NoRadius

                MultiText { // Position
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.position

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("Position")
                    }
                }

                MultiText { // Distance To Go
                    visible: root.offsetsVisible
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.distanceToGo

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("Distance to Go")
                    }
                }

                Icon { // Homed axis
                    Layout.fillHeight: true
                    margins: 5
                    disabled: !modelData.homed
                    icon: "home"
                }
            }
        }

        MultiAxisDro { // Extra
            id: extraDro
            Layout.fillWidth: true
            //visible: !root.offsetsVisible && (axes.length > 0)

            label: qsTr("Extra")

            axes: {
                var list = []
                var item

                if (root.velocityVisible) {
                    item = {}
                    item.name = qsTr("Vel")
                    item.value = root.velocity
                    item.units = root.units
                    list.push(item)
                }

                if (root.distanceToGoVisible) {
                    item = {}
                    item.name = qsTr("DTG")
                    item.value = root.distanceToGo
                    list.push(item);
                }

                if (root.spindleSpeedVisible) {
                    item = {}
                    item.name = qsTr("S%1").arg(root.spindleDirection === 1 ? "⟳" : (root.spindleDirection === -1 ? "⟲" : ""))
                    item.value = root.spindleSpeed
                    list.push(item)
                }

                return list
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                axisName: modelData.name
                axisColor: "#44D7B6"

                radiusStyle: index == 0 ? DroAxisRow.RadiusStyle.TopRadius
                                        : index === (extraDro.axes.length-1) ? DroAxisRow.RadiusStyle.BottomRadius
                                                                             : DroAxisRow.RadiusStyle.NoRadius

                MultiText {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.value
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    //visible: modelData.units !== undefined

                    Text {
                        id: unitsText
                        //anchors.verticalCenter: parent.verticalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        color: "white"
                        text: modelData.units !== undefined ? modelData.units : ""
                        font.family: "Monospace"
                        font.pixelSize: Math.min(parent.height*0.5, parent.width / 6)
                    }
                }

                Item {
                    width: 32
                    height: 32
                }
            }
        }

        MultiAxisDro { // G5x / G92 offsets
            id: offsetsDro
            Layout.fillWidth: true
            topMargin: 10

            label: qsTr("Offsets")

            axes: {
                var list = []
                for (var i = 0; i < root.axes; ++i) {
                    var item = {}
                    item.name = root.axisNames[i]
                    item.homed = (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed
                    item.g5xOffset = Number(root.g5xOffset[root._axisNames[i]])
                    item.g92Offset = Number(root.g92Offset[root._axisNames[i]])
                    item.toolOffset = Number(root.toolOffset[root._axisNames[i]])
                    list.push(item)
                }
                return list
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                axisName: modelData.name
                axisColor: "#D60000"

                radiusStyle: index == 0 ? DroAxisRow.RadiusStyle.TopRadius
                                        : index === (offsetsDro.axes.length-1) ? DroAxisRow.RadiusStyle.BottomRadius
                                                                            : DroAxisRow.RadiusStyle.NoRadius

                MultiText { // G5x Offset (current active offset)
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.g5xOffset

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("%1").arg(root.g5xNames[root.g5xIndex - 1])
                    }
                }

                MultiText { // G92
                    visible: root.offsetsVisible
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.g92Offset

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("G92")
                    }
                }

                MultiText { // Tool offset
                    visible: root.offsetsVisible
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.toolOffset

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("Tool Position")
                    }
                }
            }
        }

        MultiAxisDro { // Tool offsets
            id: toolOffsetsDro
            Layout.fillWidth: true
            topMargin: 10
            visible: false//root.offsetsVisible

            label: qsTr("Tool Offsets")

            axes: {
                var list = []
                for (var i = 0; i < root.axes; ++i) {
                    var item = {}
                    item.name = root.axisNames[i]
                    item.homed = (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed
                    item.toolOffset = Number(root.toolOffset[root._axisNames[i]])
                    list.push(item)
                }
                return list
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                axisName: modelData.name
                axisColor: "#84D600"

                radiusStyle: index == 0 ? DroAxisRow.RadiusStyle.TopRadius
                                        : index === (toolOffsetsDro.axes.length-1) ? DroAxisRow.RadiusStyle.BottomRadius
                                                                            : DroAxisRow.RadiusStyle.NoRadius

                MultiText { // Tool offset
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    digits: root.digits
                    decimals: root.decimals
                    value: modelData.toolOffset

                    DroLabel {
                        anchors {
                            leftMargin: parent.signWidth
                            left: parent.left
                            right: parent.right
                            bottom: parent.top
                            bottomMargin: -5
                        }
                        visible: index == 0
                        textColor: "white"
                        text: qsTr("Position")
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    } // layout

}
