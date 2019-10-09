import QtQuick 2.12 

Item {
    readonly property ControlColorStyle background: ControlColorStyle { color:"#585858" }
    readonly property ControlColorStyle foreground: ControlColorStyle {
        color: "white"
        disabled.color: "#8A8A8A"
    }
    readonly property TextStyle text: TextStyle {
        font.pixelSize:20
    }
    readonly property int radius: 4
}
