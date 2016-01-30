import QtQuick 2.5
import QtQuick.Controls 1.3 // ApplicationWindow type
import QtQuick.Window 2.2   // Screen

ApplicationWindow {

    id: appWin

    Component.onCompleted: appWin.showFullScreen()


    readonly property real usableSpace:
        Math.min(appWin.width, appWin.height);

    readonly property int duration: 500


    Rectangle {

        anchors.fill: parent
        color: "white"
    }


    CustomCheckBox {

        id: checkBox
        duration: 0.4 * appWin.duration

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: (appWin.width - width) / 2
        anchors.topMargin: 1.1 * appWin.height / 2

        width: 0.1 * appWin.usableSpace

        onChecked: timer.start()
    }


    Cat {

        id: cat

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: checkBox.x - width * 0.46;
        anchors.topMargin: appWin.height / 2 - cat.width

        width: 0.45 * appWin.usableSpace
        movementDuration: appWin.duration

        onPawMovementStopped: checkBox.isChecked = false
    }


    Timer {

        id: timer

        interval: (Math.random() + 0.5) * appWin.duration
        running: false

        onTriggered: {
            cat.pawMovementStart(checkBox.y + checkBox.width / 2)
            interval =
                    Math.random() * appWin.duration +
                    checkBox.duration
        }
    }

}
