extends GridContainer

class_name SlotContainer

@export var ItemSlot: PackedScene

var slots

func display_item_slots(cols, rows):
	columns = cols
	slots = cols * rows
	for index in range(slots):
		var item_slot = ItemSlot.instantiate()
		add_child(item_slot)
		item_slot.display_item(Inventory.items[index])
	Inventory.items_changed.connect(_on_Inventory_items_changed)

func _on_Inventory_items_changed(indexes):
	for index in indexes:
		if index < slots:
			var item_slot = get_child(index)
			item_slot.display_item(Inventory.items[index])
