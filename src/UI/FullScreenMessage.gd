extends Control

onready var label = $VBoxContainer/Label
onready var player = $AudioStreamPlayer

var text = "default" setget udpate_text

func udpate_text(value):
	text = value
	label.text = text
	
func play_win():
	player.play()
