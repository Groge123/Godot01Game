extends Resource

class_name weapon_stats

@export var _name=""
@export var basic_damage:int
@export var critical_chance:float

@export var attack_range:int
@export var attack_speed_base:float=1
@export var icon:Texture

var attack_speed:float=0.1


func _init() -> void:
    attack_speed=attack_speed_base
