extends StaticBody2D

var is_mouse_entered: bool = false
var selected: bool = false

@onready var selected_box = get_node("Selected")


func _process(_delta) -> void:
	selected_box.visible = selected


func _ready() -> void:
	mouse_entered.connect(on_barb_house_mouse_entered)
	mouse_exited.connect(on_barb_house_mouse_exited)


func _input(event):
	if event.is_action_pressed("LeftClick"):
		if is_mouse_entered:
			print("mouse is entered")
			print(selected)
			selected = !selected
			if selected:
				print("thing is selected and should spawn unit")
				Game.spawn_unit()


func on_barb_house_mouse_entered() -> void:
	print("mouse entered")
	is_mouse_entered = true


func on_barb_house_mouse_exited() -> void:
	print("mouse exited")
	is_mouse_entered = false
