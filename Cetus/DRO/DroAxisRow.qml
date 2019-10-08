import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    id: root
    implicitWidth: 200
    implicitHeight: 40

    property string axisName: "?"
    property color axisColor: "#0096EC"
    property color axisTextColor: "white"
    property color backgroundColor: "#585858"

    default property alias content: contentLayout.data

    enum RadiusStyle {
        NoRadius,
        TopRadius,
        BottomRadius
    }
    property int radiusStyle: DroAxisRow.RadiusStyle.NoRadius

    Rectangle {
        anchors.fill: parent
        radius: 4
        color: root.backgroundColor
    }

    Rectangle {
        id: axisIndicator
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        radius: 6
        width: height
        color: root.axisColor

        // Corners hiding rectangles
        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            visible:    root.radiusStyle === DroAxisRow.RadiusStyle.NoRadius
                     || root.radiusStyle === DroAxisRow.RadiusStyle.BottomRadius
            height: parent.radius
            color: parent.color
            antialiasing: parent.antialiasing
        }

        Rectangle {
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            visible:    root.radiusStyle === DroAxisRow.RadiusStyle.NoRadius
                     || root.radiusStyle === DroAxisRow.RadiusStyle.TopRadius
            height: parent.radius
            color: parent.color
            antialiasing: parent.antialiasing
        }

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
