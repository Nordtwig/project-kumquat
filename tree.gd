extends StaticBody2D

var _total_time: float = 5.0
var _current_time: float = 0.0
var _units_in_area: int = 0

@onready var timer = $Timer
@onready var progress_bar = $ProgressBar


func _ready() -> void:
	$ChopArea.body_entered.connect(_on_chop_area_body_entered)
	$ChopArea.body_exited.connect(_on_chop_area_body_exited)
	timer.timeout.connect(_on_timer_timeout)

	_current_time = _total_time
	progress_bar.max_value = _total_time


func _process(_delta) -> void:
	progress_bar.value = _current_time
	if _current_time <= 0:
		_tree_chopped()


func _tree_chopped() -> void:
	Game.wood += 100
	queue_free()


func _start_chopping() -> void:
	print("started chopping")
	timer.start()


func _on_chop_area_body_entered(body) -> void:
	if body.is_in_group("units"):
		_units_in_area += 1
		_start_chopping()


func _on_chop_area_body_exited(body) -> void:
	if body.is_in_group("units"):
		_units_in_area -= 1
		if _units_in_area <= 0:
			timer.stop()


func _on_timer_timeout() -> void:
	var chop_speed = 1 * _units_in_area
	_current_time -= chop_speed
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", _current_time, 0.05).set_trans(Tween.TRANS_QUAD)
