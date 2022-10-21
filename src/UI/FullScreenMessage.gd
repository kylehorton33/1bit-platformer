extends Control

onready var label = $VBoxContainer/Label
onready var player = $AudioStreamPlayer

var text = "default" setget update_text

func update_text(value):
	text = value
	label.text = text
	
func play_win():
	player.play()
