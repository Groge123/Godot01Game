extends Control

@onready var sprite: Sprite2D = $PanelContainer/HBoxContainer/PanelContainer/Sprite2D

@onready var _name: Label = $PanelContainer/HBoxContainer/VBoxContainer/name_ct/_name
@onready var health: Label = $PanelContainer/HBoxContainer/VBoxContainer/health/health
@onready var ap: Label = $PanelContainer/HBoxContainer/VBoxContainer/attack_power/ap
@onready var crit_rate: Label = $PanelContainer/HBoxContainer/VBoxContainer/crit_rate/crit_rate
@onready var speed: Label = $PanelContainer/HBoxContainer/VBoxContainer/speed/speed

func _ready() -> void:
    var data=preload("res://player_data/basic_player.tres")
    set_tex(data.icon)
    _set_name(data.nick_name)
    _set_crit_rate(data.critical_rate)
    _set_health(data.health)
    _set_speed(data.move_speed)
    _set_ap(data.attack_power)



func set_tex(tex:Texture):
    sprite.texture=tex
    
func _set_name(text:String):
    _name.text=text

func _set_health(hx:int):
    health.text=str(hx)
func _set_ap(a:int):
    ap.text=str(a)
    
func _set_speed(sp:int):
    speed.text=str(sp)
    
func _set_crit_rate(ct:float):
    crit_rate.text=str(ct*100)
    
