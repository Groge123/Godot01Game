extends Panel

class_name Property_Card

@onready var icon: TextureRect = $VBoxContainer/MarginContainer/HBoxContainer/icon
@onready var group: Label = $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/group
@onready var _name: Label = $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/_name
@onready var data: Label = $VBoxContainer/property/ScrollContainer/VBoxContainer/data

@onready var anim: AnimationPlayer = $AnimationPlayer

var cur_name:String
var cur_value:Variant
var is_select=false
func _ready() -> void:
    generate_card()

func generate_card():
    $VBoxContainer.modulate.a=1
    scale=Vector2(1,1)
    var attrs=Attribute_Card.ATTR.keys()
    var cur=randi_range(0,attrs.size()-1)
    cur_name=attrs[cur]
    var now_card=Attribute_Card.ATTR[cur_name]
    icon.texture=load(now_card.group[now_card.type].icon)
    group.text=str(now_card.group.name)
    _name.text=str(now_card.group[now_card.type].name)
    
    var range=now_card.range    
    var parts = range.split("-")
    var min=parts[0].to_float()
    var max=parts[1].to_float()
    

    match now_card.var:
        "int":
            cur_value=randi_range(min,max)
        "float":
            cur_value=randf_range(min,max)
            cur_value=round(cur_value * 100) / 100
        "weapon":
            cur_value=1    
    data.text=tr(cur_name)+"+"+str(cur_value)
    

func _on_mouse_entered() -> void:
    if is_select:
        return
    var tw=create_tween()
    tw.tween_property(self,'scale',Vector2(1.1,1.1),0.1)


func _on_mouse_exited() -> void:
    if is_select:
        return
    var tw=create_tween()
    tw.tween_property(self,'scale',Vector2(1,1),0.1)

func _on_gui_input(event: InputEvent) -> void:
    if is_select:
        return
    if event is InputEventScreenTouch or event.is_pressed():
        is_select=true
        var player=get_tree().get_first_node_in_group("player")
    
        if player:
            
            if cur_name in Attribute_Card.all_weapon_name:
                player.add_weapon(cur_name)
            else :
                player[cur_name]+=cur_value
        anim.play("fade_out")
        await anim.animation_finished
        queue_free()
