import QtQuick 2.12
import Machinekit.Application 1.0

ApplicationObject {
    property int axisType: 1
    readonly property string units: proportional ? "%" : distanceUnits + "/" + timeUnits
    readonly property string distanceUnits: helper.ready ? helper.distanceUnits : "mm"
    readonly property string timeUnits: helper.ready ? helper.timeUnits : "min"
    readonly property double displayValue: proportional ? value : value * __timeFactor * __distanceFactor
    property double value: 0
    property double minimumValue: 0
    property double maximumValue: 100
    property bool proportional: false
    property double minimumProportion: 0.0
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
            var velocity = value;
            if (proportional) {
                velocity /= 100.0;
                velocity *= (maximumValue-minimumValue)
                velocity += minimumValue
            }

            forEachAxis(function(idx) {
                settings.setValue("axis" + idx + ".jogVelocity", velocity);
            })

            synced = false;
        }
    }

    on__ReadyChanged: {
        if (__ready) {
            _update();
            settings.onValuesChanged.connect(_update);
            status.onConfigChanged.connect(_update);
            status.onMotionChanged.connect(_update);
        } else {
            settings.onValuesChanged.disconnect(_update);
            status.onConfigChanged.disconnect(_update);
            status.onMotionChanged.disconnect(_update);
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

        function findMaxAxisJogVelocity() {
            var _maxVel = 0
            forEachAxis(function(idx) {
                _maxVel = Math.max(_maxVel, settings.value("axis" + idx + ".jogVelocity"));
            })
            return _maxVel
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
        minimumProportion = (minimumValue / maximumValue) * 100.0;

        // Use max jog velocity
        var tmpValue = findMaxAxisJogVelocity()
        tmpValue = Math.max(Math.min(tmpValue, maximumValue), minimumValue); // clamp value
        if (proportional) {
            tmpValue /= (maximumValue-minimumValue);
            tmpValue *= 100.0;
            tmpValue += minimumValue
        }

        if (Math.abs(value-tmpValue) > 0.00001)
            value = tmpValue;
        else
            synced = true;

        __remoteUpdate = false;
    }
}
