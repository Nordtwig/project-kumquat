class_name Unit
extends CharacterBody2D

@export var selected: bool = false


@onready var box = get_node("Box")


func _ready() -> void:
	input_event.connect(on_unit_input_event)


func set_selected(value: bool) -> void:
	box.visible = value


func on_unit_input_event(viewport, event, shape_idx):
	pass