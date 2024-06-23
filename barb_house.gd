extends StaticBody2D

var is_mouse_entered: bool = false
var selected: bool = false

@onready var selected_box = get_node("Selected")