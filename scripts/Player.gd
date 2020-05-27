extends Spatial

var is_drawing_selection = false
var selection_begin = null
var selection_end = null
onready var camera = self.get_node("../World/Camera")

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pass
		# var result = self.camera.project_position(event.position)
		# print(result)
#		var from = self.camera.project_ray_origin(event.position)
#		var to = from + self.camera.project_ray_normal(event.position)
#		print(from, to)
#		if event.is_pressed() and not self.is_drawing_selection:
#			self.is_drawing_selection = true
#			self.selection_begin = to
#			# print(self.selection_begin)
#		elif not event.is_pressed() and self.is_drawing_selection:
#			self.is_drawing_selection = false
#			self.selection_end = to
#			# print(self.selection_end)
