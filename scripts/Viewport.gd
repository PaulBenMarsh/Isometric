extends Viewport

func _ready():
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	
	self.size = Vector2(width, height)
	# self.set_process_input(true)
	# self.set_process_unhandled_input(true)

# func _input(event):
# 	pass
	# input(event)

# func _unhandled_input(event):
# 	pass
	# unhandled_input(event)
