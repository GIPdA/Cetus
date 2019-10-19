import QtQuick 2.12
import QtQuick.Layouts 1.12

import "../CetusStyle"
import "../items"

Item {
    id: root
    implicitWidth: 200
    implicitHeight: 40

    property string axisName: "?"
    property color axisColor: "#0096EC"
    property color axisTextColor: CetusStyle.control.foreground.color
    property color backgroundColor: CetusStyle.control.background.color

    default property alias content: contentLayout.data

    enum RadiusStyle {
        NoRadius = 0,
        TopRadius = 1,
        BottomRadius = 2,
        LeftRadius = 4,
        RightRadius = 8,
        AllRadius = 0xF
    }
    property int radiusStyle: DroAxisRow.NoRadius

    RoundedRectangle {
        anchors.fill: parent
        anchors.leftMargin: radius+1
        radius: CetusStyle.control.radius
        radiusStyle: root.radiusStyle
        color: root.backgroundColor
    }

    RoundedRectangle {
        id: axisIndicator
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        radius: CetusStyle.control.radius
        width: height
        color: root.axisColor

        radiusStyle: root.radiusStyle

        Text {
            id: axisTitleText
            anchors.fill: parent
            anchors.margins: 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 50
            text: root.axisName
            color: root.axisTextColor
            fontSizeMode: Text.Fit
            minimumPixelSize: 10
        }
    }

    RowLayout {
        id: contentLayout
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: axisIndicator.right
            right: parent.right
            rightMargin: 5
        }
        spacing: 8
    }
}
