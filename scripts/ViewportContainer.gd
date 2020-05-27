extends ViewportContainer

onready var viewport = get_node("Viewport")

func _ready():
	self.rect_size = viewport.size
	self.mouse_filter = MOUSE_FILTER_IGNORE
