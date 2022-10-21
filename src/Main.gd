extends Node

const World = preload("res://src/World.tscn")

onready var top_ui = $CanvasLayer/TopUI
onready var welcome_message = $CanvasLayer/FullScreenMessage

var world = null

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0))
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in collectibles:
		collectible.connect("collected", top_ui, "on_collected")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if !world && event.is_action_pressed("ui_accept"):
		start_game()

func start_game():
	world = World.instance()
	get_tree().current_scene.add_child(world)
	get_tree().current_scene.move_child(world, 0)
	welcome_message.queue_free()
