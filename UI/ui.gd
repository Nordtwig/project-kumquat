extends CanvasLayer


@onready var label = $Label


func _process(_delta) -> void:
	label.text = str(Game.wood)
	print("Wood is " + label.text)
