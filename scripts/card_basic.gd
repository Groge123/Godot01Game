extends Control
class_name card
@onready var texture_rect: TextureRect = $PanelContainer/TextureRect

@onready var show_player_card: Control = $"../../../show_player_card"

@export var data:UnitStats

func _ready() -> void:
    texture_rect.texture=data.icon
    
func _on_button_pressed() -> void:
    GlobalData.cur_player_name=data._name
    print(GlobalData.cur_player_name)
    show_player_card.set_tex(data.icon)
    show_player_card._set_name(data.nick_name)
    show_player_card._set_crit_rate(data.critical_rate)
    show_player_card._set_health(data.health)
    show_player_card._set_speed(data.move_speed)
    show_player_card._set_ap(data.attack_power)
    
    
    
    print(data._name)
