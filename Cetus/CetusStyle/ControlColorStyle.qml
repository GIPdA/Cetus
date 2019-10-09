import QtQuick 2.12 

QtObject {
    property color color: "white"
    readonly property ColorStyle active: ColorStyle { color:"#0096EC" }
    readonly property ColorStyle down: ColorStyle { color:"#696767" }
    readonly property ColorStyle disabled: ColorStyle { color:"#585858" }

    function colorWhen(_enabled, _down=false, _active=false) {
        if (!_enabled)
            return disabled.color
        if (_active)
            return active.color
        if (_down)
            return down.color
        return color
    }
}
