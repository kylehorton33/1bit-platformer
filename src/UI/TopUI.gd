extends Control

onready var label = $HBoxContainer/Label

func on_collected():
	label.text = "1 / 1"
