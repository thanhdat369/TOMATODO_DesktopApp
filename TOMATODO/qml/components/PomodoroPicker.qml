import QtQuick 2.15
import QtQuick.Layouts 1.15
import "../style"

Rectangle {
	id: root
	color: ColorStyle.backgroundColor
	border.color: ColorStyle.mainColor
	border.width: 3
	implicitWidth: 400
	implicitHeight: 250
	radius: 20

	property string taskName: "Task Name Can Edit"
	property int taskMode: PomodoroPicker.TaskMode.Edit

	enum TaskMode{
		Create,
		Edit
	}

	Text {
		id: title
		anchors.top: root.top
		anchors.left: root.left
		anchors.topMargin: 20
		anchors.leftMargin: 20

		font.family: FontStyle.ubuntuMonoBold.name
		font.pixelSize: 30
		font.styleName: "normal"

		color: ColorStyle.mainColor

		text: internal.title
	}

	ColumnLayout {
		anchors.centerIn: root
		spacing: 20

		RowLayout {
			Layout.alignment: Qt.AlignCenter
			spacing: 10

			NumberRoundedBox{
				id: firstMinField

			}

			NumberRoundedBox{
				id: secondMinField
			}

			Rectangle {
				implicitWidth: 10
				implicitHeight: 50
				color: "transparent"

				Text {
					anchors.centerIn: parent
					text: ":"
					color: ColorStyle.mainColor
					font.pixelSize: 30
				}
			}

			NumberRoundedBox{
				id: firstSecField
			}

			NumberRoundedBox{
				id: secondSecField
			}
		}

		Text {
			id: taskLabel
			Layout.alignment: Qt.AlignCenter

			font.family: FontStyle.ubuntuMonoBold.name
			font.pixelSize: 24
			color: ColorStyle.mainColor

			text: root.taskName
		}
	}

	RowLayout {
		id: buttonLayout
		spacing: 10

		anchors.right: root.right
		anchors.bottom: root.bottom

		anchors.rightMargin: 20
		anchors.bottomMargin: 20

		Layout.fillWidth: true

		RoundedButton {
			id: okButton
			text: "OK"
		}

		RoundedButton {
			style: RoundedButton.ButtonStyle.CancelButton
			text: "Cancel"
		}
	}

	QtObject {
		id: internal

		property string title: {
			if (root.taskMode === PomodoroPicker.TaskMode.Edit) {
				return qsTr("Edit Task");
			} else if (root.taskMode === PomodoroPicker.TaskMode.Create) {
				return qsTr("Create Task");
			}

			return qsTr("Title");
		}
	}
}
