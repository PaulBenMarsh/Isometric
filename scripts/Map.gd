extends Spatial

func _ready():
	var field_scene = preload("res://scenes/Field.tscn")
	
	var x_size = 16
	var z_size = 16
	
	for z in z_size:
		for x in x_size:
			var field = field_scene.instance()
			field.set_translation(Vector3(x * 2, 0.0, z * 2))
			self.add_child(field)

func test():
	var params = PhysicsShapeQueryParameters.new()
	params.set_collide_with_areas(true)
	params.set_collide_with_bodies(false)
	
	var rect = BoxShape.new()
	
	var size = Vector3(0.5, 1, 0.5)
	rect.set_extents(size)
	params.set_shape(rect)
	params.set_transform(Transform(Vector3.RIGHT, Vector3.UP, Vector3.BACK, Vector3(0, 0, 0) + size))
	
	var result = get_world().get_direct_space_state().intersect_shape(params)
	if result.empty():
		print("empty")
	else:
		for obj in result:
			print(obj.collider.get_name())
	