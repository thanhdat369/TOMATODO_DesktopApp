import QtQuick
import QtQuick.Layouts
import "../style"

Rectangle {
	id: root

	property string taskID: "0"
	property string taskName: "0"
	property int remainTime: 0
	property int originalTime: 0
	property alias isDone: roundTick.isDone

	signal itemClick()
	signal removeTask()
	signal doneClick()
	signal doubleClicked()

	implicitWidth: 431
	implicitHeight: 50

	border.width: 1
	border.color: _.cardColor

	radius: 20

	color: "transparent"

	onIsDoneChanged: {
		root.state = root.isDone ? "check" : "uncheck";
	}

	RowLayout {
		spacing: 10
		anchors.verticalCenter: parent.verticalCenter

		RoundTick {
			id: roundTick

			Layout.alignment: Qt.AlignCenter
			Layout.leftMargin: 20

			color: _.cardColor

			onClicked: {
				root.isDone = !root.isDone
				root.doneClick();
			}
		}

		TextEdit {
			id: taskNameEdit

			selectByMouse: true
			Layout.fillWidth: true

			font.bold: true
			font.family: FontStyle.ubuntuMonoRegular.name
			font.pixelSize: 14

			color: _.cardColor

			text: root.taskName
		}
	}

	MouseArea {
		anchors.fill: parent

		hoverEnabled: true

		onDoubleClicked: {
			root.doubleClicked();
		}
	}

	DeadlineBox {
		id: deadlineBox

		anchors.right: root.right
		implicitHeight: root.height
		width: 70

		backgroundColor: _.cardColor

		deadlineTime: root.originalTime
		workedTime: root.originalTime - root.remainTime

		MouseArea {
			anchors.fill: parent
			hoverEnabled: true

			onClicked: {
				root.itemClick();
			}
		}

	}
	states: [
		State {
			name: "check"
			PropertyChanges {
				target: roundTick
				isDone: true
			}
			PropertyChanges {
				target: taskNameEdit
				font.strikeout: true
				readOnly:true
			}
		},
		State {
			name: "uncheck"
			PropertyChanges {
				target: roundTick
				isDone: false
			}
			PropertyChanges {
				target: taskNameEdit
				font.strikeout: false
			}

		}
	]

	MouseArea {
		id: mouseArea

		anchors.fill: parent
		hoverEnabled: true
		propagateComposedEvents: true
	}

	IconButton {
		id: deleteButton

		anchors.right: deadlineBox.right
		y: -10

		visible: mouseArea.containsMouse || deleteButton.hovered

		iconSrc: "qrc:/assets/icon/close.svg"

		onClicked: {
			root.removeTask();
		}
	}

	QtObject {
		id: _

		property color cardColor: {
			if(mouseArea.containsMouse){
				return ColorStyle.mainHoverColor;
			}

			return root.state == "check" ?  ColorStyle.secondaryColor:ColorStyle.mainColor;
		}
	}
}
