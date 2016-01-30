import QtQuick 2.0
import QtGraphicalEffects 1.0


Item {

    id: cat


    width: 200

    property int movementDuration: 1000

    readonly property real scale:
        width / body.sourceSize.width

    height: body.sourceSize.height * scale


    readonly property real forearmXOffset: 655 * scale
    readonly property real forearmYOffset: 1060 * scale

    readonly property real pawXOffset: 605 * scale
    readonly property real pawYOffset: 985 * scale


    function pawMovementStart(y) {

        var newPawTopMargin = y - cat.y - paw.height / 2
        if (newPawTopMargin < cat.pawYOffset) return

        forearmAnim.to = y - cat.y - forearm.y
        forearmAnim.start()

        pawAnim.to = newPawTopMargin
        pawAnim.start()
    }

    signal pawMovementStopped()


    Image {

        id: body
        source: "qrc:/images/cat_body.png"

        anchors.left: cat.left
        anchors.top: cat.top

        width: cat.width
        height: cat.height
    }

    Image {

        id: forearm
        source: "qrc:/images/cat_forearm.png"

        anchors.left: body.left
        anchors.top: body.top
        anchors.leftMargin: cat.forearmXOffset
        anchors.topMargin: cat.forearmYOffset

        width: sourceSize.width * cat.scale
        height: 0
    }

    Image {

        id: paw
        source: "qrc:/images/cat_paw.png"

        anchors.left: body.left
        anchors.top: body.top
        anchors.leftMargin: cat.pawXOffset
        anchors.topMargin: cat.pawYOffset

        width: sourceSize.width * cat.scale
        height: sourceSize.height * cat.scale
    }


    DropShadow {

        anchors.fill: body
        source: body
        z: cat.z - 1
        color: "#66000000"
        radius: cat.width / 20
        samples: 16
        horizontalOffset: 0
        verticalOffset: cat.width / 20
        spread: 0
    }

    DropShadow {

        anchors.fill: paw
        source: paw
        z: cat.z - 1
        color: "#66000000"
        radius: cat.width / 20
        samples: 16
        horizontalOffset: 0
        verticalOffset: cat.width / 20
        spread: 0
    }


    PropertyAnimation {

        id: forearmAnim
        running: false
        target: forearm
        property: "height"
        duration: cat.movementDuration
        easing.type: Easing.InQuart
        onStopped: {
            cat.pawMovementStopped()
            forearmAnimRev.start()
        }
    }

    PropertyAnimation {

        id: forearmAnimRev
        running: false
        target: forearm
        property: "height"
        duration: cat.movementDuration
        easing.type: Easing.OutQuart
        to: 0
    }


    PropertyAnimation {

        id: pawAnim
        running: false
        target: paw
        property: "anchors.topMargin"
        duration: cat.movementDuration
        easing.type: Easing.InQuart
        onStopped: pawAnimRev.start()
    }

    PropertyAnimation {

        id: pawAnimRev
        running: false
        target: paw
        property: "anchors.topMargin"
        duration: cat.movementDuration
        easing.type: Easing.OutQuart
        to: cat.pawYOffset
    }

}

