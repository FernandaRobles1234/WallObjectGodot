extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$WallObject.set_surface_material_override_albedo("res://assets/Textures/Brick/material.jpg")
	$WallObject.set_pass_surface_material_override_albedo(1, "res://assets/WallArt/Macrus.png")
	$WallObject.set_pass_surface_material_override_albedo(2, "res://assets/WallArt/Grafffiti_Rat_v1.png")
	$WallObject.set_pass_surface_material_override_albedo(3, "res://assets/WallArt/Grafffiti_Yolande_v2.png")
	$WallObject.set_surface_material_override(3, "res://assets/Textures/Brick/")
	
	$WallObject2.set_surface_material_override_albedo("res://assets/Textures/Brick/material.jpg")
	$WallObject2.set_pass_surface_material_override_albedo(1, "res://assets/WallArt/Grafffiti_Rat_v1.png")
	$WallObject2.set_surface_material_override(1, "res://assets/Textures/Brick/")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
