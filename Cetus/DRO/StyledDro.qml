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

    readonly property string units: helper.ready ? helper.distanceUnits + "/" + helper.timeUnits : "?"

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
            Layout.fillHeight: true
            Layout.minimumHeight: minimumImplicitHeight

            label: qsTr("DRO")

            axes: PropertyMapModel {
                Component.onCompleted: {
                    function addAxis(i) { // var item can't be "reused", so to use loops we must use a function to create a row
                        var item = append()//appendWithProperties(["name", "homed", "position", "distanceToGo"])
                        item.name =         root.axisNames[i]
                        item.homed =        Qt.binding(function() { return (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed })
                        item.position =     Qt.binding(function() { return Number(root.position[root._axisNames[i]]) })
                        item.distanceToGo = Qt.binding(function() { return Number(root.dtg[root._axisNames[i]]) })
                    }
                    for (var i = 0; i < root.axes; ++i) {
                        addAxis(i)
                    }

                    if (root.lathe) {
                        // Lathe mode, X is replaced by Rad, Dia is inserted juste after
                        at(0).name = qsTr("Rad")

                        var item = insertAt(1)
                        item.name =         qsTr("Dia")
                        item.position =     Qt.binding(function() { return Number(root.position['x']) * 2.0 })
                        item.distanceToGo = Qt.binding(function() { return Number(root.dtg['x']) * 2.0 })
                    }
                }
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: mainDro.axisHeight
                Layout.maximumHeight: mainDro.axisHeight
                Layout.minimumHeight: mainDro.axisHeight
                axisName: modelData.name
                axisColor: "#0096EC"

                radiusStyle: index == 0 ? DroAxisRow.TopRadius
                                        : index === (mainDro.axes.count-1) ? DroAxisRow.BottomRadius
                                                                            : DroAxisRow.NoRadius

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
            Layout.fillHeight: true
            Layout.minimumHeight: minimumImplicitHeight
            //visible: !root.offsetsVisible && (axes.length > 0)

            label: qsTr("Extra")

            Connections {
                target: root
                onVelocityVisibleChanged: extraDroModel.makeModel()
                onDistanceToGoVisibleChanged: extraDroModel.makeModel()
                onSpindleSpeedVisibleChanged: extraDroModel.makeModel()
            }

            axes: PropertyMapModel {
                id: extraDroModel
                function makeModel() {
                    clear()
                    if (root.velocityVisible) {
                        var velocityItem = beginAppend()
                        velocityItem.name = qsTr("Vel")
                        velocityItem.value = Qt.binding(function() { return root.velocity+0 })
                        velocityItem.units = root.units
                        endAppend()
                    }

                    if (root.distanceToGoVisible) {
                        var dtgItem = beginAppend()
                        dtgItem.name = qsTr("DTG")
                        dtgItem.value = Qt.binding(function() { return root.distanceToGo+0 })
                        dtgItem.units = ""
                        endAppend()
                    }

                    if (root.spindleSpeedVisible) {
                        var spindleSpeedItem = beginAppend()
                        spindleSpeedItem.name = Qt.binding(function() { return qsTr("S%1").arg(root.spindleDirection === 1 ? "⟳" : (root.spindleDirection === -1 ? "⟲" : "")) })
                        spindleSpeedItem.value = Qt.binding(function() { return root.spindleSpeed })
                        spindleSpeedItem.units = ""
                        endAppend()
                    }
                }

                Component.onCompleted: makeModel()
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: mainDro.axisHeight
                Layout.maximumHeight: mainDro.axisHeight
                Layout.minimumHeight: mainDro.axisHeight
                axisName: modelData.name
                axisColor: "#44D7B6"

                radiusStyle: {
                    if (extraDro.axes.count === 1)
                        return DroAxisRow.AllRadius
                    if (index == 0)
                        return DroAxisRow.TopRadius
                    if (index == (extraDro.axes.count-1))
                        return DroAxisRow.BottomRadius
                    return DroAxisRow.NoRadius
                }

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
                        anchors.bottomMargin: parent.height*0.15
                        color: "white"
                        text: modelData.units
                        font.family: "Monospace"
                        font.pixelSize: Math.min(parent.height*0.5, parent.width / 6)
                    }
                }

                Item {
                    Layout.fillHeight: true
                    width: 32
                    height: 32
                }
            }
        }

        MultiAxisDro { // G5x / G92 / Tools offsets
            id: offsetsDro
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: minimumImplicitHeight
            topMargin: 10
            visible: root.offsetsVisible

            label: qsTr("Offsets")

            axes: PropertyMapModel {
                Component.onCompleted: {
                    function addAxis(i) {
                        var item = append()
                        item.name =         root.axisNames[i]
                        item.homed =        Qt.binding(function() { return (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed })
                        item.g5xOffset =    Qt.binding(function() { return Number(root.g5xOffset[root._axisNames[i]]) })
                        item.g92Offset =    Qt.binding(function() { return Number(root.g92Offset[root._axisNames[i]]) })
                        item.toolOffset =   Qt.binding(function() { return Number(root.toolOffset[root._axisNames[i]]) })
                    }
                    for (var i = 0; i < root.axes; ++i) {
                        addAxis(i)
                    }
                }
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: mainDro.axisHeight
                Layout.maximumHeight: mainDro.axisHeight
                Layout.minimumHeight: mainDro.axisHeight
                axisName: modelData.name
                axisColor: "#D60000"

                radiusStyle: index == 0 ? DroAxisRow.TopRadius
                                        : index === (offsetsDro.axes.count-1) ? DroAxisRow.BottomRadius
                                                                            : DroAxisRow.NoRadius

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

        /*MultiAxisDro { // Tool offsets, splitted from offsets
            id: toolOffsetsDro
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: minimumImplicitHeight
            topMargin: 10
            visible: false//root.offsetsVisible

            label: qsTr("Tool Offsets")

            axes: PropertyMapModel {
                Component.onCompleted: {
                    function addAxis(i) {
                        var item = append()
                        item.name =         root.axisNames[i]
                        item.homed =        Qt.binding(function() { return (i < root.axisHomed.length) && root.axisHomed[root._axisIndices[i]].homed })
                        item.toolOffset =   Qt.binding(function() { return Number(root.toolOffset[root._axisNames[i]]) })
                    }
                    for (var i = 0; i < root.axes; ++i) {
                        addAxis(i)
                    }
                }
            }

            axesDelegate: DroAxisRow {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: mainDro.axisHeight
                Layout.maximumHeight: mainDro.axisHeight
                Layout.minimumHeight: mainDro.axisHeight
                axisName: modelData.name
                axisColor: "#84D600"

                radiusStyle: index == 0 ? DroAxisRow.TopRadius
                                        : index === (toolOffsetsDro.axes.count-1) ? DroAxisRow.BottomRadius
                                                                            : DroAxisRow.NoRadius

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
        }//*/

        Item {
            Layout.fillHeight: true
        }
    } // layout

}
