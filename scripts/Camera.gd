extends Camera

var zoom_sizes = [4, 8, 16, 32]
var current_zoom_index = 2
var border_size_px = 128
var panning_multiplier = 0.5
onready var viewport = get_viewport()

func update_zoom():
	self.size = self.zoom_sizes[self.current_zoom_index]

func _ready():
	self.current = true
	self.projection = Camera.PROJECTION_ORTHOGONAL
	self.near = 0.05
	self.far = 100.0
	self.transform = Transform()
	
	self.update_zoom()
	self.transform.origin = Vector3(8.0, 8.0, 8.0)
	self.rotation_degrees = Vector3(-30.0, 45.0, 0.0)
	
	self.environment = get_node("../WorldEnvironment").environment

func on_camera_zoom_in():
	if self.current_zoom_index > 0:
		self.current_zoom_index -= 1
		self.update_zoom()

func on_camera_zoom_out():
	if self.current_zoom_index + 1 < len(self.zoom_sizes):
		self.current_zoom_index += 1
		self.update_zoom()

func _process(delta):
	var mouse_position_global = self.viewport.get_mouse_position()
	var in_border_x = mouse_position_global.x <= self.border_size_px or mouse_position_global.x >= self.viewport.size.x - self.border_size_px
	var in_border_y = mouse_position_global.y <= self.border_size_px or mouse_position_global.y >= self.viewport.size.y - self.border_size_px
	if in_border_x or in_border_y:
		var mouse_position_local = (mouse_position_global - (self.viewport.size / 2))
		var normalized = mouse_position_local.normalized()
		
		var max_mouse_bounding_box = Vector2(self.viewport.size.y, self.viewport.size.y)
		
		var max_mouse_distance = max_mouse_bounding_box.length() / 2
		var mouse_distance = mouse_position_local.clamped(max_mouse_bounding_box.x).length()
		# print(mouse_distance)
		
		var mouse_distance_ratio = mouse_distance / max_mouse_distance
		# print(mouse_distance_ratio)

		var origin_offset = Vector3(normalized.x, 0.0, normalized.y).rotated(Vector3.UP, deg2rad(45)) * mouse_distance_ratio / 4

		self.transform.origin += origin_offset
