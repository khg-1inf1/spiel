extends Node

class_name uiManager

@onready var hotbar = $CanvasLayer/Hotbar # Jan + Jonas S
@onready var inventory_menu = $CanvasLayer/InventoryMenu # Jan + Jonas S
@onready var drag_preview = $CanvasLayer/DragPreview # Jan + Jonas S
@onready var tooltip = $CanvasLayer/Tooltip

signal invOpen(is_open : bool)
signal toggle_game_paused(is_paused : bool) # Lea

# Lea
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

# Lea
var hotvis : bool = true:
	get:
		return hotvis
	set(value):
		hotvis = value
		hotbar.set_visible(value)

# Lea
func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		game_paused =! game_paused
		inventory_menu.set_visible(false) # Jan + Jonas S
		emit_signal("invOpen", false)

# Jan + Jonas S
func _unhandled_input(event):
	if !game_paused:
		if event.is_action_pressed("ui_menu"):
			if inventory_menu.visible and drag_preview.get_dragged_item(): return
			hotbar.visible = !hotbar.visible
			inventory_menu.visible = !inventory_menu.visible
			emit_signal("invOpen", inventory_menu.visible)
			hide_tooltip()

# Jan + Jonas S
func _ready():
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.gui_input.connect(_on_ItemSlot_gui_input.bind(index))
		item_slot.mouse_entered.connect(show_tooltip.bind(index))
		item_slot.mouse_exited.connect(hide_tooltip)

#Jan + Jonas S
func _on_ItemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if inventory_menu.visible:
				drag_item(index)
				hide_tooltip()
			elif hotbar.visible:
				select_item(index)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if inventory_menu.visible:
				split_item(index)
				hide_tooltip()
# Jan + Jonas S
func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.get_dragged_item()
	# pick item
	if inventory_item and dragged_item == {}:
		drag_preview.set_dragged_item(Inventory.remove_item(index))
	# drop item
	elif inventory_item == {} and dragged_item:
		drag_preview.set_dragged_item(Inventory.set_item(index, dragged_item))
	elif inventory_item and dragged_item:
		# stack items
		if inventory_item.key == dragged_item.key and inventory_item.stackable:
			Inventory.set_item_quantity(index, dragged_item.quantity)
			drag_preview.set_dragged_item({})
		# swap items
		else:
			drag_preview.set_dragged_item(Inventory.set_item(index, dragged_item))
# Jan
func split_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.get_dragged_item()
	if inventory_item == {} or !inventory_item.stackable: return
	var split_amount = ceil(inventory_item.quantity / 2.0)
	if dragged_item and inventory_item.key == dragged_item.key:
		var item = inventory_item.duplicate()
		item.quantity = split_amount + drag_preview.get_dragged_item().quantity
		drag_preview.set_dragged_item(item)
		Inventory.set_item_quantity(index, -split_amount)
	if dragged_item == {}:
		var item = inventory_item.duplicate()
		item.quantity = split_amount
		drag_preview.set_dragged_item(item)
		Inventory.set_item_quantity(index, -split_amount)
# Jan
func select_item(index):
	if !game_paused:
		Inventory.set_selected(index)
# Jan
func show_tooltip(index):
	var inventory_item = Inventory.items[index]
	if inventory_item and drag_preview.get_dragged_item() == {}:
		tooltip.display_info(inventory_item)
		tooltip.show()
	else:
		tooltip.hide()
# Jan
func hide_tooltip():
	tooltip.hide()


func _on_outdoor_pressed():
	pass # Replace with function body.

# Jan + Lea
func hide():
	$CanvasLayer.hide()
# Jan + Lea
func show():
	$CanvasLayer.show()
