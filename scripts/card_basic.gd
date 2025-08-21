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
    show_player_card.set_data(data)
    
    
    
    print(data._name)
