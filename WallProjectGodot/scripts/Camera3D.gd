extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Perform a raycast every frame to check if the cursor is in front of a mesh
func intersect_ray():
	var from = project_ray_origin(get_viewport().get_mouse_position())
	var to = from + project_ray_normal(get_viewport().get_mouse_position()) * 1000
	var space_state = get_world_3d().direct_space_state

	var parameters = PhysicsRayQueryParameters3D.create(from, to)
	parameters.collision_mask = 1  # Ensure this matches the collision layer of your meshes

	var result = space_state.intersect_ray(parameters)
	
	return result
