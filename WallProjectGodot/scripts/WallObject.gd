extends Node3D

#Constants for the wall object
var surface_index: int= 0

func _ready():
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
		print("A new material was created and set in pass"  + str(idx_pass))
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

	
	material = StandardMaterial3D.new()  # Create a new StandardMaterial3D
	$MeshInstance3D.set_surface_override_material(surface_index, material)
	print("A new material was created and set as the override material.")

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
			material.heightmap_scale= 5
			material.heightmap_texture = heightMap
			print("The height map was loaded.")
		else:
			print("The height map could not be loaded")
			
		if ambientOcclusionMap:
			material.ao_enabled= true
			material.ao_light_affect = 2
			material.ao_texture = ambientOcclusionMap
			print("The ambient occlusion map was loaded.")
		else:
			print("The ambient occlusion map could not be loaded")
			
		if normalMap:
			material.normal_enabled= true
			material.normal_texture = normalMap
			material.normal_scale= 5
			print("The normal map was loaded.")
		else:
			print("The normal map could not be loaded")
			
		if specularMap:
			material.metallic_texture = specularMap
			print("The specular map was loaded.")
		else:
			print("The specular map could not be loaded")
			
		material = material.get_next_pass()
