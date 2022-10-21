extends Node

const GameWorld = preload("res://src/Levels/Level_01.tscn")
const FullScreenMessage = preload("res://src/UI/FullScreenMessage.tscn")
const GameUI = preload("res://src/UI/GameUI.tscn")

onready var ui = $UI
onready var background_music = $BackgroundMusic

var world = null

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0))
	welcome_message()
	background_music.play()

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if !world && event.is_action_pressed("start"):
		start_game()

func welcome_message():
	var welcome_message = FullScreenMessage.instance()
	ui.add_child(welcome_message)
	welcome_message.text = "Press SPACE to start\n\nPress Q to quit"

func start_game():
	delete_children(ui)
	create_world()
	start_game_ui()
	
func create_world():
	world = GameWorld.instance()
	get_tree().current_scene.add_child(world)
	get_tree().current_scene.move_child(world, 0)
	
func start_game_ui():
	var game_ui = GameUI.instance()
	ui.add_child(game_ui)
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	game_ui.total_collectibles = collectibles.size()
	game_ui.connect("collected_all", self, "on_win")
	for collectible in collectibles:
		collectible.connect("collected", game_ui, "on_collected")

func delete_children(node):
	for n in node.get_children():
		n.queue_free()
		
func on_win():
	get_tree().current_scene.remove_child(world)
	world = null
	delete_children(ui)
	win_message()
	
func win_message():
	var win_message = FullScreenMessage.instance()
	ui.add_child(win_message)
	win_message.text = "YOU WIN!\n\nPress SPACE to play next level\n\nPress Q to quit"
	win_message.play_win()
	
