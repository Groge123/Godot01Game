extends Control

@onready var sprite: Sprite2D = $PanelContainer/HBoxContainer/PanelContainer/Sprite2D

@onready var _name: Label = $PanelContainer/HBoxContainer/VBoxContainer/name_ct/_name
@onready var health: Label = $PanelContainer/HBoxContainer/VBoxContainer/health/health
@onready var ap: Label = $PanelContainer/HBoxContainer/VBoxContainer/attack_power/ap
@onready var crit_rate: Label = $PanelContainer/HBoxContainer/VBoxContainer/crit_rate/crit_rate
@onready var speed: Label = $PanelContainer/HBoxContainer/VBoxContainer/speed/speed

func _ready() -> void:
    var data=preload("res://player_data/basic_player.tres")
    set_data(data)
func set_data(data:UnitStats):
    sprite.texture=data.icon
    _name.text=data.nick_name
    health.text=str(data.health_base)
    ap.text=str(data.attack_power_base)
    crit_rate.text=str(data.critical_rate_base)
    speed.text=str(data.move_speed_base)
    
