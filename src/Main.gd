extends Node

const World = preload("res://src/World.tscn")
const GameUI = preload("res://src/UI/GameUI.tscn")

onready var ui = $UI
onready var welcome_message = $UI/FullScreenMessage

var world = null

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0))

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if !world && event.is_action_pressed("ui_accept"):
		start_game()

func start_game():
	welcome_message.queue_free()
	create_world()
	start_game_ui()
	
func create_world():
	world = World.instance()
	get_tree().current_scene.add_child(world)
	get_tree().current_scene.move_child(world, 0)
	
func start_game_ui():
	var game_ui = GameUI.instance()
	ui.add_child(game_ui)
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	game_ui.total_collectibles = collectibles.size()
	for collectible in collectibles:
		collectible.connect("collected", game_ui, "on_collected")
	
