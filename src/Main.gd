extends Node

onready var top_ui = $CanvasLayer/TopUI

func _ready():
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in collectibles:
		collectible.connect("collected", top_ui, "on_collected")
