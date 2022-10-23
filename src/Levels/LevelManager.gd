extends Node

export(Array, PackedScene) var levels

var id = 0 setget change_level
var current_level

const GameUI = preload("res://src/UI/GameUI.tscn")

signal level_won
signal game_won

func start():
	current_level = levels[id].instance()
	add_child(current_level)
	current_level.connect("collected_all", self, "on_win")

func change_level(value):
	id = value
	remove_child(current_level)

func on_win():
	if id + 1 < levels.size():
		emit_signal("level_won")
	else:
		emit_signal("game_won")
	
func is_playing():
	return get_children().size()
