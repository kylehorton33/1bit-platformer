extends Control

onready var label = $VBoxContainer/Label

var text = "default" setget udpate_text

func udpate_text(value):
	text = value
	label.text = text
	
