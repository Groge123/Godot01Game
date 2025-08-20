extends CanvasLayer

class_name Upgrade_page


@export var property_card:PackedScene
@onready var cur_coin_num: Label = $MarginContainer/HBoxContainer/VSplitContainer/coins_text_show/HBoxContainer/cur_coin_num
@onready var cards: GridContainer = $MarginContainer/HBoxContainer/VSplitContainer/VSplitContainer/cards_show/cards
@onready var refresh: Button = $MarginContainer/HBoxContainer/VSplitContainer/VSplitContainer/refrash_/refresh

var card_nums=4
var player=Basic_Player
func _ready() -> void:
    visible=false
    player=get_tree().get_first_node_in_group("player")
    add_cards()
    
func _process(delta: float) -> void:
    if visible==false or player==null:
        return
    get_tree().paused=true
    if player:
        cur_coin_num.text=str(player.coin_num)
    card_nums=cards.get_child_count()
    if card_nums==0:
        #_on_confirm_pressed()
        refresh.visible=false
func _on_confirm_pressed() -> void:
    visible=false
    card_nums=4
    refresh.visible=true
    add_cards()
    get_tree().paused=false

func _on_refresh_pressed() -> void:
    if player==null or player.coin_num<2:
        return
    player.coin_num-=2
    if cards.get_child_count()>0:
        for c in cards.get_children():
            c.generate_card()
    else:
        add_cards()
        
    
    
func add_cards():
    for i in range(card_nums):
        var _card:=property_card.instantiate()
        cards.add_child(_card)
        _card.generate_card()
