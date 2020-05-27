extends ImmediateGeometry

var material = SpatialMaterial.new()

var point_size = 1
# var line_width = 2
var marker_size = 1.0 / 3.0
var height = 0.01

func _ready():
	self.material.flags_use_point_size = true
	self.material.params_point_size = self.point_size
	self.material.vertex_color_use_as_albedo = true
	self.set_material_override(self.material)

func _process(delta):
	
	clear()
	
	begin(Mesh.PRIMITIVE_LINES)
	set_color(Color(1.0, 0.0, 0.0))
	
	add_vertex(Vector3(-1.0, height, -1.0 + marker_size))
	add_vertex(Vector3(-1.0, height, -1.0))
	
	add_vertex(Vector3(-1.0, height, -1.0))
	add_vertex(Vector3(-1.0 + marker_size, height, -1.0))
	
	add_vertex(Vector3(1.0 - marker_size, height, -1.0))
	add_vertex(Vector3(1.0, height, -1.0))
	
	add_vertex(Vector3(1.0, height, -1.0))
	add_vertex(Vector3(1.0, height, -1.0 + marker_size))
	
	add_vertex(Vector3(1.0, height, 1.0 - marker_size))
	add_vertex(Vector3(1.0, height, 1.0))
	
	add_vertex(Vector3(1.0, height, 1.0))
	add_vertex(Vector3(1.0 - marker_size, height, 1.0))
	
	add_vertex(Vector3(-1.0 + marker_size, height, 1.0))
	add_vertex(Vector3(-1.0, height, 1.0))
	
	add_vertex(Vector3(-1.0, height, 1.0))
	add_vertex(Vector3(-1.0, height, 1.0 - marker_size))
	
	end()
