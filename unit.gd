class_name Unit
extends CharacterBody2D

@export var selected: bool = false

var follow_cursor: bool = false
var speed: float = 50

@onready var box = get_node("Box")
@onready var anim = get_node("AnimationPlayer")
@onready var target: Vector2 = position


func _ready() -> void:
	input_event.connect(on_unit_input_event)


func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false


func _physics_process(delta) -> void:
	if follow_cursor:
		if selected:
			target = get_global_mouse_position()
			anim.play("walk_down")

	velocity = position.direction_to(target) * speed

	if position.distance_to(target) > 15:
		move_and_slide()
	else:
		anim.stop()


func set_selected(value: bool) -> void:
	selected = value
	box.visible = value


func on_unit_input_event(viewport, event, shape_idx):
	pass