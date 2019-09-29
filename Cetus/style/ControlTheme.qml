import QtQuick 2.12 

QtObject {
    readonly property BaseColorStyle background: BaseColorStyle { color:"#212121" }
    readonly property BaseColorStyle foreground: BaseColorStyle {}
    readonly property BaseTextStyle text: BaseTextStyle {font.pixelSize:20}
    readonly property BaseColorStyle border: BaseColorStyle {}
}
