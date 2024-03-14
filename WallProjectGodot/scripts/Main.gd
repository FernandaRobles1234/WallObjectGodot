extends Node3D

#Initialize
var target_position = Vector3.ZERO
var input_enabled = true

var ray_collisions: Dictionary

var default_cursor = null
var open_eye_cursor = preload("res://assets/Cursors/OpenEye.png") # Replace with the path to your custom cursor image
var closed_eye_cursor = preload("res://assets/Cursors/ClosedEye.png") # Replace with the path to your custom cursor image

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$WallObject2.set_surface_material_override_albedo("res://assets/Textures/Brick/material.jpg")
	$WallObject2.set_pass_surface_material_override_albedo(1, "res://assets/WallArt/Grafffiti_Rat_v1.png")
	$WallObject2.set_surface_material_override(1, "res://assets/Textures/Brick/")
	$WallObject2.set_camera_position(Vector3(0, 0, 0))
	
	$WallObject.set_surface_material_override_albedo("res://assets/Textures/Brick/material.jpg")
	$WallObject.set_pass_surface_material_override_albedo(1, "res://assets/WallArt/Poster_Macrus.png")
	$WallObject.set_surface_material_override(1, "res://assets/Textures/Brick/")
	$WallObject.set_camera_position(Vector3(0, 0, 0))
	
	$Camera3D.position = Vector3(-0.5, 0.0, 0.5) # Set the start position of the camera
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_custom_mouse_cursor(open_eye_cursor)


func _process(delta):
	ray_collisions= $Camera3D.intersect_ray()
	if ray_collisions and ray_collisions.has("collider"):
		if ray_collisions.collider is StaticBody3D:
			Input.set_custom_mouse_cursor(closed_eye_cursor)
	else:
		Input.set_custom_mouse_cursor(open_eye_cursor)
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		ray_collisions= $Camera3D.intersect_ray()
		if ray_collisions and ray_collisions.has("collider"):
			if ray_collisions.collider is StaticBody3D:
				var collider = ray_collisions.collider
				if collider:
					var root_node = collider.get_tree().current_scene
					var camera_position= root_node.find_node("CameraPosition", true, false)
					$Camera3D.position = camera_position.position
						

