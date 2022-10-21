extends Node

const FullScreenMessage = preload("res://src/UI/FullScreenMessage.tscn")

onready var ui = $UI
onready var background_music = $BackgroundMusic
onready var level_manager = $LevelManager

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0))
	welcome_message()
	background_music.play()
	level_manager.connect("level_won", self, "on_win")

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if !level_manager.is_playing() && event.is_action_pressed("start"):
		start_game()

func welcome_message():
	var welcome_message = FullScreenMessage.instance()
	ui.add_child(welcome_message)
	welcome_message.text = "Press SPACE to start\n\nPress Q to quit"

func start_game():
	delete_children(ui)
	level_manager.start()


func delete_children(node):
	for n in node.get_children():
		n.queue_free()
		
func on_win():
	level_manager.id += 1
	win_message()
	
func win_message():
	var win_message = FullScreenMessage.instance()
	ui.add_child(win_message)
	win_message.text = "YOU WIN!\n\nPress SPACE to play next level\n\nPress Q to quit"
	win_message.play_win()
	
