extends Control

onready var label = $HBoxContainer/Label

var collected = 0 setget update_collected
var total_collectibles = 1 setget update_total_collectibles

func update_total_collectibles(value):
	total_collectibles = value
	update_label()
	
func update_collected(value):
	collected = value
	update_label()

func on_collected():
	self.collected += 1

func update_label():
	label.text = str(collected) + " / " + str(total_collectibles)
