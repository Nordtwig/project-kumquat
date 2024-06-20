extends StaticBody2D


func _ready() -> void:
	$ChopArea.body_entered.connect(on_chop_area_body_entered)
	$ChopArea.body_exited.connect(on_chop_area_body_exited)


func on_chop_area_body_entered(body) -> void:
	print(body.name + " entered")


func on_chop_area_body_exited(body) -> void:
	print(body.name + " left")
