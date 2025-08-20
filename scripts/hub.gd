extends Control
@onready var icon: TextureRect = $MarginContainer/HBoxContainer/VBoxContainer2/Icon
@onready var shield: Label = $MarginContainer/HBoxContainer/VBoxContainer/shield_bar/shield
@onready var shield_bar: ProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/shield_bar

@onready var ex: ProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/EX
@onready var coins: Label = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/coins
@onready var hp_bar: ProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/hp_bar
@onready var hp: Label = $MarginContainer/HBoxContainer/VBoxContainer/hp_bar/hp
@onready var lv: Label = $MarginContainer/HBoxContainer/VBoxContainer2/LV

var player:Basic_Player
   
func _ready() -> void:
    player=get_tree().get_first_node_in_group("player")
    if player:
        icon.texture=player.icon
        show_data()
        
func show_data():
    ex.max_value=player.cur_exp_max
    ex.value=player.cur_exp
    coins.text=str(player.coin_num)
    hp_bar.max_value=player.health_max
    hp_bar.value=player.cur_health        
    
    hp.text=str(player.cur_health)+"/"+str(player.health_max)
    lv.text="LV: "+str(player.level)
    
    shield.text=str(player.cur_shield)+"/"+str(player.shield_max)
    shield_bar.max_value=player.shield_max
    shield_bar.value=player.cur_shield    
func _process(delta: float) -> void:
    if player:
        show_data()
