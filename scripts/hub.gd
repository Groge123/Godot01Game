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
        icon.texture=player.Data.icon
        show_data()
        
func show_data():
    var max_health=player.Data.health_base+player.Data.health_add
    var max_shield=player.Data.shield_base+player.Data.shield_add
   
    ex.max_value=player.Data.exp_max
    ex.value=player.Data.cur_exp
    coins.text=str(player.Data.coins)
    hp_bar.max_value=max_health
    hp_bar.value=player.Data.health   
    hp.text=str(player.Data.health)+"/"+str(max_health)
    lv.text="LV: "+str(int(player.Data.level))
    
    shield.text=str(player.Data.shield)+"/"+str(max_shield)
    shield_bar.max_value=max_shield
    shield_bar.value=player.Data.shield
func _process(delta: float) -> void:
    if player:
        show_data()
