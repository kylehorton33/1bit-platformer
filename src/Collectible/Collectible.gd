extends Node2D

signal collected

onready var animation_player = $AnimationPlayer

func _on_Area2D_area_entered(_area):
	animation_player.play("collect")
	call_deferred("emit_signal", "collected")
  
