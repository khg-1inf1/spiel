extends Node

signal items_changed(indexes)
signal selected_changed

@export var cols = 9
@export var rows = 3
var slots = cols * rows
var items = []
var selected = 0

func _ready():
	for i in range(slots):
		items.append({})
	items[1] = ItemManager.get_item_by_key("sword")
	items[8] = ItemManager.get_item_by_key("potion")

func broadcast_signal(indexes):
	emit_signal("items_changed", indexes)
	for index in indexes:
		if index == selected:
			emit_signal("selected_changed")

func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	broadcast_signal([index])
	return previous_item

func remove_item(index):
	var previous_item = items[index].duplicate()
	items[index].clear()
	broadcast_signal([index])
	return previous_item

func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		broadcast_signal([index])

func set_selected(new_selected):
	var _last_selected = selected
	selected = new_selected
	broadcast_signal([selected, _last_selected])

func get_selected():
	return items[selected]

func save():
	var save_dict = {
		"items" : items
	}
	return save_dict

func load_items(data):
	items = data
	for n in 26:
		items[n] = data[n]
		broadcast_signal(n)
