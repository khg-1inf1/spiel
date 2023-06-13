extends Control

var dragged_item = {}

@onready var item_icon = $ItemIcon
@onready var item_quantity = $ItemQuantity

func _process(_delta):
	if dragged_item:
		position = get_global_mouse_position()

func set_dragged_item(item):
	dragged_item = item
	if dragged_item:
		item_icon.texture = load("res://images/%s" % dragged_item.icon)
		if item.stackable:
			if item.quantity > 1:
				item_quantity.text = str(item.quantity)
			else:
				item_quantity.text = ""
		else:
			item_quantity.text = ""
	else:
		item_icon.texture = null
		item_quantity.text = ""

func get_dragged_item():
	return dragged_item
