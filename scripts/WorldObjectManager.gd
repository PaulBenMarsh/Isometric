extends Spatial

var data = null
var type_lookup = 	{
	"unit": "res://scenes/Unit.tscn"
}

func _ready():
	pass

func _init():
	var file = File.new()
	file.open("res://data/game_objects.json", File.READ)
	var content = file.get_as_text()
	
	var parse_result = JSON.parse(content)
	if parse_result.error != OK:
		print("error:", parse_result.error)
		print("line:", parse_result.error_line)
		print("string:", parse_result.error_string)
		return
	self.data = parse_result.result
	
	self.create_animation_resources("000")
	
	for y in 16:
		for x in 16:
			self.create("000", Vector2(x, y))

func create_animation_resources(id):
	var object_data = self.data[id]
	for action_name in object_data["actions"]:
		var action = object_data["actions"][action_name]
		for direction in action["spritesheet"]["rows"]:
			
			var animation = Animation.new()
			animation.add_track(Animation.TYPE_VALUE, 0)
			animation.track_set_path(0, "")
			animation.track_set_interpolation_type(0, Animation.INTERPOLATION_LINEAR)
			animation.value_track_set_update_mode(0, Animation.UPDATE_CONTINUOUS)
			animation.track_insert_key(0, 0.0, action["spritesheet"]["columns"] * direction)
			animation.track_insert_key(0, 1.0, action["spritesheet"]["columns"] * (direction+1) - 1)
			animation.set_loop(true)
		
			ResourceSaver.save("res://animations/" + id + "_" + action_name + "_" + str(direction) + ".tres", animation)

func create(id, position):
	var object_data = self.data[id]
	
	var object = load(self.type_lookup[object_data["type"]]).instance()
	object.connect("is_ready", object, "init", [id, object_data])
	object.translate(Vector3(position.x * 2, 0, position.y * 2))
	self.add_child(object)

#func _input(event):
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
#		if event.pressed:
#	if event is InputEventKey:
#		if event.pressed and event.scancode == KEY_ESCAPE:
#			self.get_node("../Map").test()
