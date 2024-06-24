extends Node

var wood: int = 0

@onready var spawn_unit_scene = preload("res://UI/spawn_unit.tscn")


func spawn_unit() -> void:
	var ui_path = get_tree().get_root().get_node("World/UI")
	var spawn_unit_instance = spawn_unit_scene.instantiate()
	ui_path.add_child(spawn_unit_instance)
