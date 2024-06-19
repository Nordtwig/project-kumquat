extends Node2D


var units: Array[Node]


func _ready() -> void:
	get_node("Camera").area_selected.connect(on_area_selected)
	units = get_tree().get_nodes_in_group("units")
	print(units)


func get_units_in_area(area: Array) -> Array:
	var u = []
	for unit in units:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x):
			if (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
				u.append(unit)
	
	return u


func on_area_selected(object) -> void:
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut  = get_units_in_area(area)
	for u in ut:
		u.set_selected(!u.selected)
