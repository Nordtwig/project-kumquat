extends Node2D


@onready var unit_scene = preload("res://unit.tscn")


func _ready() -> void:
	get_node("%Yes").pressed.connect(on_yes_pressed)
	get_node("%No").pressed.connect(on_no_pressed)


func on_yes_pressed() -> void:
	var unit_path = get_tree().get_root().get_node("World/Units")
	var unit1 = unit_scene.instantiate()
	unit1.position = Vector2(200, 200)
	unit_path.add_child(unit1)


func on_no_pressed() -> void:
	queue_free()
