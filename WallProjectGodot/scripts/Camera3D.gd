extends Camera3D

var original_position: Vector3= Vector3(0, 0, 1.3)
var original_rotation: Vector3= Vector3(0, 0.5, 0)

	
# Perform a raycast every frame to check if the cursor is in front of a mesh
func intersect_ray():
	var from = project_ray_origin(get_viewport().get_mouse_position())
	var to = from + project_ray_normal(get_viewport().get_mouse_position()) * 1000
	var space_state = get_world_3d().direct_space_state

	var parameters = PhysicsRayQueryParameters3D.create(from, to)
	parameters.collision_mask = 1

	var result = space_state.intersect_ray(parameters)
	
	return result

func go_to_original():
	$".".position= original_position
	$".".rotation= original_rotation
	
func go_to(global_position:Vector3, global_rotation:Vector3):
	$".".position= global_position
	$".".rotation= global_rotation
	
	
