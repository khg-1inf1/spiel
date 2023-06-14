extends SlotContainer

var got_resized : bool = false

func _ready():
	display_item_slots(Inventory.cols, Inventory.rows)
	await get_tree().process_frame
	position = (get_viewport_rect().size - size) / 2
	hide()
	get_viewport().connect("size_changed", _on_viewport_resize)
	get_viewport().get_window().connect("mouse_entered", _resize)

func _on_viewport_resize():
	got_resized = true

func _resize():
	if (got_resized):
		position = (get_viewport_rect().size - size) / 2
		got_resized = false
