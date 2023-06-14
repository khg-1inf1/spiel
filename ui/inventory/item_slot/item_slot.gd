extends ColorRect

@onready var item_icon = $ItemIcon
@onready var item_quantity = $ItemQuantity

func display_item(item):
	if item:
		item_icon.texture = load("res://images/%s" % item.icon)
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
	if get_parent() and get_parent().name == "Hotbar":
		if get_index() == Inventory.selected:
			color = "#7b7b7b"
		else:
			color = "#333333"
