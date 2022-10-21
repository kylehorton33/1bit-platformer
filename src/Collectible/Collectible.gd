extends Node2D

onready var animation_player = $AnimationPlayer

func _on_Area2D_area_entered(area):
	animation_player.play("collect")
