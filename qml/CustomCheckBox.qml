import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {

    id: root

    width: 50
    height: 2 * width

    property string color: "#00ACED"

    property bool isChecked: false
    property int duration: 300

    signal checked()


    Rectangle {

        id: background
        anchors.fill: root
        radius: width / 2

        color: root.isChecked ? root.color : "lightgray"
        Behavior on color {
            PropertyAnimation { duration: root.duration }
        }
    }


    Rectangle {

        id: foreground

        anchors.left: root.left
        anchors.top: root.top
        anchors.leftMargin: 0.05 * root.width
        anchors.topMargin:
            root.isChecked ? 0.05 * root.width : root.width * 1.05

        anchors {
            Behavior on topMargin {
                PropertyAnimation { duration: root.duration }
            }
        }

        width: 0.9 * root.width
        height: width
        radius: width / 2

        color: "white"
    }

    DropShadow {

        anchors.fill: foreground
        source: foreground

        radius: 0.1 * foreground.radius
        verticalOffset: radius / 2

        samples: 10
        transparentBorder: true
        color: "#80000000"
    }


    FontLoader { id: externalFont; source: "qrc:/fonts/Archangelsk.ttf" }

    Text {

        anchors.centerIn: foreground

        font.pixelSize: foreground.width / 2
        font.family: externalFont.name

        color: "#444"
        text: root.isChecked ? "1" : "0"

        Behavior on text {
            PropertyAnimation {
                duration: root.duration
            }
        }
    }


    MouseArea {
        anchors.fill: background
        onPressed: {
            root.isChecked = !root.isChecked
            if (root.isChecked) root.checked()
        }
        cursorShape: Qt.PointingHandCursor
    }

}

