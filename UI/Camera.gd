extends Camera2D

signal area_selected
signal start_move_selection

@export_category("Camera Controls")
@export var _speed: float = 20.0
@export var _zoom_speed: float = 20.0
@export var _zoom_margin: float = 0.1
@export var _zoom_min: float = 0.5
@export var _zoom_max: float = 3.0

var zoom_factor = 1.0
var zoom_position = Vector2()
var is_zooming = false

var mousePos: Vector2 = Vector2()
var mousePosGlobal: Vector2 = Vector2()

var start: Vector2 = Vector2()
var startV: Vector2 = Vector2()
var end: Vector2 = Vector2()
var endV: Vector2 = Vector2()

var isDragging: bool = false


@onready var box = get_node("../UI/Panel")


func _process(delta) -> void:
	var input_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var input_y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	position.x = lerp(position.x, position.x + input_x * _speed * zoom.x, _speed * delta)
	position.y = lerp(position.y, position.y + input_y * _speed * zoom.y, _speed * delta)

	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, _zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, _zoom_speed * delta)

	zoom.x = clamp(zoom.x, _zoom_min, _zoom_max)
	zoom.y = clamp(zoom.y, _zoom_min, _zoom_max)

	if not is_zooming:
		zoom_factor = 1.0


	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true

	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			isDragging = false
			draw_area(false)


func _input(event):
	if abs(zoom_position.x - get_global_mouse_position().x) > _zoom_margin:
		zoom_factor = 1.0
	if abs(zoom_position.y - get_global_mouse_position().y) > _zoom_margin:
		zoom_factor = 1.0
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_zooming = true
			if event.is_action("WheelDown"):
				zoom_factor -= 0.01 * _zoom_speed
				zoom_position = get_global_mouse_position()
			if event.is_action("WheelUp"):
				zoom_factor += 0.01 * _zoom_speed
				zoom_position = get_global_mouse_position()
	else:
		is_zooming = false

	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()


func draw_area(s = true) -> void:
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)


