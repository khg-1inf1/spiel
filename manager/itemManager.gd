extends Node

var items

func _ready():
	items = read_from_JSON("res://data/items.json")
	for key in items.keys():
		items[key]["key"] = key


func read_from_JSON(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	return data


func get_item_by_key(key):
	if items and items.has(key):
		return items[key].duplicate(true)
