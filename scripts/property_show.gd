extends Panel

@onready var data_show: HFlowContainer = $MarginContainer2/VBoxContainer/MarginContainer/SplitContainer/VBoxContainer/data_show

var player:Basic_Player

func _ready() -> void:
    player=get_tree().get_first_node_in_group("player")
    player=GlobalData.cur_Player
    show_attr()
    
func show_attr():
    for data in data_show.get_children():
        data_show.remove_child(data)
    
    if player:
        
        for i in GlobalData.Property["player"]:
            var power=Label.new()
            power.text=tr(i)+":"+str(player[i])
            data_show.add_child(power)
func _process(delta: float) -> void:
    show_attr()
        
