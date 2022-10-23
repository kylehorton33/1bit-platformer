extends Node2D

onready var ui = $CanvasLayer/GameUI
onready var end_timer = $EndTimer

var n_collectibles = 0
var n_collected = 0

signal collected_all

func _ready():
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	n_collectibles = collectibles.size()
	ui.total_collectibles = n_collectibles
	for collectible in collectibles:
		collectible.connect("collected", self, "on_collected")

func on_collected():
	n_collected += 1
	ui.collected = n_collected
	if (n_collected >= n_collectibles):
		end_timer.start(0.5)

func _on_EndTimer_timeout():
	emit_signal("collected_all")
