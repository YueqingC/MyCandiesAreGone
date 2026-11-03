
extends Control

signal dialogue_finished

@onready var name_label = $Panel/VBoxContainer/NameLabel
@onready var dialog_text = $Panel/VBoxContainer/DialogText
@onready var next_button = $Panel/VBoxContainer/NextButton

var dialog_lines: Array[String] = []
var current_line: int = 0


func _ready():
	hide()

	next_button.pressed.connect(next_line)


func start_dialog(speaker: String, lines: Array[String]):

	if lines.is_empty():
		hide()
		dialogue_finished.emit()
		return

	name_label.text = speaker
	dialog_lines = lines
	current_line = 0

	show_line()
	show()


func show_line():

	if current_line < dialog_lines.size():

		dialog_text.text = dialog_lines[current_line]

	else:

		hide()
		dialogue_finished.emit()


func next_line():

	current_line += 1
	show_line()
