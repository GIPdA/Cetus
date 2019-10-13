import QtQuick 2.12
import Machinekit.Application 1.0

ApplicationObject {
    property int axisType: 1
    readonly property string units: distanceUnits + "/" + timeUnits
    readonly property string distanceUnits: helper.ready ? helper.distanceUnits : "mm"
    readonly property string timeUnits: helper.ready ? helper.timeUnits : "min"
    readonly property double displayValue: value * __timeFactor * __distanceFactor
    property double value: 0
    property double minimumValue: 0
    property double maximumValue: 100
    property bool enabled: __ready
    property bool synced: false

    readonly property double __timeFactor: helper.ready ? helper.timeFactor : 1
    readonly property double __distanceFactor: helper.ready ? helper.distanceFactor : 1
    readonly property bool __ready: status.synced && settings.initialized
    property bool __remoteUpdate: false

    function forEachAxis(fct) {
        for (var axisIdx = 0; axisIdx < status.config.axes; axisIdx++) {
            if (status.config.axis[axisIdx].axisType === axisType)
                fct(axisIdx)
        }
    }

    onValueChanged: {
        if (__ready && !__remoteUpdate) {
            forEachAxis(function(idx) {
                settings.setValue("axis" + idx + ".jogVelocity", value);
            })

            synced = false;
        }
    }

    on__ReadyChanged: {
        if (__ready) {
            _update();
            settings.onValuesChanged.connect(_update);
            //status.onConfigChanged.connect(_update)
        } else {
            settings.onValuesChanged.disconnect(_update);
            //status.onConfigChanged.disconnect(_update);
            synced = false;
        }
    }

    onAxisTypeChanged: {
        if (__ready)
            _update()
    }

    Component.onDestruction: {
        if (!settings.onValuesChanged) // for qmlplugindump
            return;
        settings.onValuesChanged.disconnect(_update);
        status.onConfigChanged.disconnect(_update);
        status.onMotionChanged.disconnect(_update);
    }

    function _update() {

        function findMaxAxisVelocity() {
            var _maxVel = 0
            forEachAxis(function(idx) {
                _maxVel = Math.max(_maxVel, status.config.axis[idx].maxVelocity);
            })
            return _maxVel
        }

        function findMinMaxAxisJogVelocity() {
            var combinedJogVel = {}
            combinedJogVel.max = 0;
            combinedJogVel.min = Infinity;

            forEachAxis(function(idx) {
                var jogvel = settings.value("axis" + idx + ".jogVelocity")
                combinedJogVel.max = Math.max(combinedJogVel.max, jogvel);
                combinedJogVel.min = Math.min(combinedJogVel.min, jogvel);
            })
            return combinedJogVel
        }

        function clampToMinMax(v) {
            return Math.max(Math.min(v, maximumValue), minimumValue)
        }

        __remoteUpdate = true;

        minimumValue = status.config.minVelocity;
        var axisMaxVel = findMaxAxisVelocity()
        var configMaxVel = status.config.maxVelocity;
        if ((axisMaxVel === undefined) || (axisMaxVel === 0) || (configMaxVel < axisMaxVel)) {
            maximumValue = configMaxVel;
        } else {
            maximumValue = axisMaxVel;
        }

        // Compare with min/max jog velocities for all axis to avoid a binding loop
        var combinedJogVel = findMinMaxAxisJogVelocity()
        combinedJogVel.min = clampToMinMax(combinedJogVel.min)
        combinedJogVel.max = clampToMinMax(combinedJogVel.max)

        if (   Math.abs(value-combinedJogVel.min) > 0.00001
            && Math.abs(value-combinedJogVel.max) > 0.00001)
            value = combinedJogVel.min;
        else
            synced = true;

        __remoteUpdate = false;
    }
}
