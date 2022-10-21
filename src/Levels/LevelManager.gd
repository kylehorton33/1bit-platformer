extends Node

export(Array, PackedScene) var levels

var id = 0 setget change_level
var level

const GameUI = preload("res://src/UI/GameUI.tscn")

signal level_won

func start():
	level = levels[id].instance()
	add_child(level)
	level.connect("collected_all", self, "on_win")

func change_level(value):
	id = value
	remove_child(level)

func on_win():
	if id + 1 < levels.size():
		emit_signal("level_won")
	else:
		print("final win state")
	
func is_playing():
	return get_children().size()
