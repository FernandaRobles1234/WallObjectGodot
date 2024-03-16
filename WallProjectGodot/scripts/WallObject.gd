extends Node3D

#Constants for the wall object
var surface_index: int= 0
var camera_node: Node3D

func _ready():
	var static_body_3d= StaticBody3D.new()
	$MeshInstance3D.add_child(static_body_3d)

	var collision_shape_3d: CollisionShape3D= CollisionShape3D.new()
	static_body_3d.add_child(collision_shape_3d)
	collision_shape_3d.shape = BoxShape3D.new()
	var vector_2= $MeshInstance3D.mesh.size
	collision_shape_3d.shape.size= Vector3(vector_2.x, vector_2.y, 0.01)
	
	camera_node= Node3D.new()
	camera_node.name = "CameraNode"
	camera_node.position.z= 0.4
	static_body_3d.add_child(camera_node)
	pass

func _process(delta):
	pass

func set_pass_surface_material_override_albedo(idx_pass: int, texture_path: String):
	var material = $MeshInstance3D.get_surface_override_material(surface_index)
	var nextPass= material.get_next_pass()
	var previousMaterial= material
	var texture = load(texture_path)
	
	for i in range(idx_pass - 1):
		previousMaterial= nextPass
		nextPass= nextPass.get_next_pass()
		
	if nextPass == null:
		nextPass= StandardMaterial3D.new()
		previousMaterial.set_next_pass(nextPass)
	else:
		print("A material already exists in pass"  + str(idx_pass))
		
	if texture:
		nextPass.render_priority = previousMaterial.render_priority + 1
		nextPass.flags_transparent = true
		nextPass.albedo_texture = texture
	else:
		print("The texture could not be loaded.")


func set_surface_material_override_albedo(texture_path: String):
	var material: StandardMaterial3D = $MeshInstance3D.get_surface_override_material(surface_index)
	var texture = load(texture_path)
	var texture_size = texture.get_size()
	
	var mesh_scale = Vector3(texture_size.x / 1000, texture_size.y / 1000, 1)
	$".".scale= mesh_scale
	
	material = StandardMaterial3D.new()  # Create a new StandardMaterial3D
	$MeshInstance3D.set_surface_override_material(surface_index, material)

	if texture:
		material.flags_transparent = true
		material.albedo_texture = texture
	else:
		print("The texture could not be loaded.")

func set_surface_material_override(idx_pass:int, material_path: String):
	var heightMap= load(material_path + "heightMap.png")
	var ambientOcclusionMap = load(material_path + "ambientOcclusionMap.png")
	var normalMap = load(material_path + "normalMap.png")
	var specularMap = load(material_path + "specularMap.png")
	
	var material =$MeshInstance3D.get_surface_override_material(surface_index)
	
	for i in range(idx_pass + 1):
		if heightMap:
			material.heightmap_enabled = true
			material.heightmap_scale= 1
			material.heightmap_texture = heightMap
		else:
			print("The height map could not be loaded")
			
		if ambientOcclusionMap:
			material.ao_enabled= true
			material.ao_light_affect = 0
			material.ao_texture = ambientOcclusionMap
		else:
			print("The ambient occlusion map could not be loaded")
			
		if normalMap:
			material.normal_enabled= true
			material.normal_texture = normalMap
			material.normal_scale= 1
		else:
			print("The normal map could not be loaded")
			
		if specularMap:
			material.metallic= 1
			material.metallic_specular= 0.5
			material.metallic_texture = specularMap
		else:
			print("The specular map could not be loaded")
			
		material = material.get_next_pass()
