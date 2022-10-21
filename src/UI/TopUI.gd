extends Control

onready var label = $HBoxContainer/Label

func _ready():
	label.text = "0 / 1"

func on_collected():
	label.text = "1 / 1"
