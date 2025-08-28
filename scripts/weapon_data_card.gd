extends Control


@onready var _name: Label = $MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/_name
@onready var critical_rate: Label = $MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/critical_rate
@onready var attack_speed: Label = $MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/attack_speed
@onready var base_damage: Label = $MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/base_damage
@onready var icon: TextureRect = $MarginContainer/HBoxContainer/PanelContainer/icon



func set_data(data:weapon_stats):
    _name.text=data._name
    attack_speed.text=tr("attack_speed")+":"+str(data.attack_speed)
    base_damage.text=tr("base_attack")+":"+str(data.basic_damage)
    critical_rate.text=tr("critical_rate")+str(data.critical_chance)
    icon.texture=data.icon
    
    
    
