extends Sprite2D

var got_resized
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2 
	get_viewport().connect("size_changed", _on_viewport_resize)
	get_viewport().get_window().connect("mouse_entered", _resize)

func _on_viewport_resize():
	got_resized = true

func _resize():
	if (got_resized):
		position.x = get_viewport_rect().size.x / 2
		position.y = get_viewport_rect().size.y / 2 
		got_resized = false
