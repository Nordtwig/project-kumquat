extends CanvasLayer


@onready var label = $Label


func _process(delta) -> void:
	label.text = str(Game.wood)
