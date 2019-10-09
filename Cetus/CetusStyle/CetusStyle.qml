pragma Singleton  
import QtQuick 2.12 

Item {
    property ControlTheme control: ControlTheme {}


    function colorWhen(_ctrl, _enabled, _down, _active) {
        if (!_enabled)
            return _ctrl.disabled.color
        if (_active)
            return _ctrl.active.color
        if (_down)
            return _ctrl.down.color
        return _ctrl.color
    }
}
