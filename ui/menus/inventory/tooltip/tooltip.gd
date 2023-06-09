extends ColorRect

@onready var margin_container = $MarginContainer
@onready var item_name = $MarginContainer/ItemName

func _process(_delta):
	position = get_global_mouse_position() + Vector2.ONE * 4

func display_info(item):
	item_name.text = item.name
	await get_tree().process_frame
	margin_container.size = Vector2()
	size = margin_container.size

func _ready():
	hide()
