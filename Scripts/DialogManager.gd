
extends CanvasLayer

const DIALOG_SCENE = preload("res://Scenes/UI/dialogue 1.tscn")

var dialog_box
var is_playing: bool = false


func _ready():

	dialog_box = DIALOG_SCENE.instantiate()
	add_child(dialog_box)

	dialog_box.hide()


func play_dialog(speaker: String, lines: Array[String]):

	# Prevent overlapping conversations
	if is_playing:
		return

	is_playing = true

	dialog_box.start_dialog(speaker, lines)

	# Wait until the conversation ends
	await dialog_box.dialogue_finished

	is_playing = false


func skip_dialog():

	if is_playing:
		dialog_box.next_line()
