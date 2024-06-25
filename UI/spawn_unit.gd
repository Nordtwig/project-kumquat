extends Node2D

var house_position: Vector2 = Vector2(100, 100)

@onready var unit_scene = preload("res://unit.tscn")


func _ready() -> void:

	get_node("%Yes").pressed.connect(on_yes_pressed)
	get_node("%No").pressed.connect(on_no_pressed)


func on_yes_pressed() -> void:
	var rng_seed = RandomNumberGenerator.new()
	rng_seed.randomize()
	var random_position = Vector2(rng_seed.randi_range(-50, 50), rng_seed.randi_range(-50, 50))

	var unit_path = get_tree().get_root().get_node("World/Units")
	var world_path = get_tree().get_root().get_node("World") as World
	var unit1 = unit_scene.instantiate()

	unit1.position = house_position + random_position
	unit_path.add_child(unit1)
	world_path.get_units()


func on_no_pressed() -> void:
	queue_free()
