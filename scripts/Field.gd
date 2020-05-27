extends Area

var is_selected = false

var selection_marker_scene = preload("res://scenes/SelectionMarker.tscn")
var selection_marker = self.selection_marker_scene.instance()

func _ready():

	self.set_ray_pickable(true)
	self.set_process_input(true)
	self.connect("input_event", self, "_on_input_event")

func toggle_selection_state():
	self.is_selected = not self.is_selected
	self.call(["remove_child", "add_child"][int(self.is_selected)], self.selection_marker)

func _on_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		self.toggle_selection_state()
#	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
#		print("release")
