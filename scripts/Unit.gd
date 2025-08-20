extends Node2D
class_name Unit
@export var basic_data:UnitStats

@onready var sprite: Sprite2D = $Visuals/Sprite
@onready var visuals: Node2D = $Visuals
@onready var anim: AnimationPlayer = $AnimationPlayer
var cur_health:int
var move_speed:int
var health_max:int
var icon:Texture
