extends Spatial

var data = null
var animation_player = null
var sprite = null

var direction = null
var current_frame = null

signal is_ready


func _ready():
	emit_signal("is_ready")

func _init():
	
	var rng  = RandomNumberGenerator.new()
	rng.randomize()
	
	self.direction = str(rng.randi_range(0, 7))
	self.current_frame = rng.randf_range(0.0, 1.0)
	
	var spatial_material = SpatialMaterial.new()
	spatial_material.params_billboard_mode = SpatialMaterial.BILLBOARD_ENABLED
	spatial_material.params_use_alpha_scissor = true
	spatial_material.params_alpha_scissor_threshold = 0.1
	spatial_material.params_cull_mode = SpatialMaterial.CULL_BACK
	spatial_material.albedo_color = Color(rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0))
	
	self.sprite = Sprite3D.new()
	self.sprite.axis = Vector3.AXIS_Z
	self.sprite.centered = true
	self.sprite.pixel_size = 0.03
	self.sprite.offset = Vector2(0, 23)
	self.sprite.transparent = true
	self.sprite.shaded = false
	self.sprite.double_sided = false
	# self.sprite.alpha_cut = AlphaCutMode.ALPHA_CUT_DISABLED
	self.sprite.visible = true
	self.sprite.material_override = spatial_material
	self.add_child(self.sprite)
	
	self.animation_player = AnimationPlayer.new()
	self.animation_player.playback_speed = 1
	self.add_child(self.animation_player)

func init(id, data):
	self.data = data
	
	self.animation_player.root_node = self.sprite.get_path()
	
	for action_name in self.data["actions"]:
		for direction in self.data["actions"][action_name]["spritesheet"]["rows"]:
			var animation_name = action_name + "_" + str(direction)
			var animation_path = "res://animations/" + id + "_" + animation_name + ".tres"
			var animation = load(animation_path)
			animation.track_set_path(0, ":frame")
		
			self.animation_player.add_animation(animation_name, animation)
	
	self.set_action("walk")

func set_action(action_name):
	var action = self.data["actions"][action_name]
	var spritesheet_resource = "res://images/spritesheets/" + action["spritesheet"]["resource"]
	self.sprite.texture = load(spritesheet_resource)
	self.sprite.vframes = action["spritesheet"]["rows"]
	self.sprite.hframes = action["spritesheet"]["columns"]
	self.animation_player.play(action_name + "_" + self.direction)
	self.animation_player.advance(self.current_frame)
