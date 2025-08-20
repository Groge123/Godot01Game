extends Node2D


@export var all_enemy_num:int=100
@export var generate_speed:float=0.5

@export var enemy_type:Array[PackedScene]
var cur_enemys:Array
var enemy_type_nums:int
var cur_nums=0
var can_add=false

signal finished
func _ready() -> void:
    global_position=Vector2(0,0)
    enemy_type_nums=enemy_type.size()
    finished.connect(_on_level_won)
    pass

func _on_level_won():
    get_tree().change_scene_to_file("res://scenes/begin_scene.tscn")
func _process(delta: float) -> void:
    if cur_nums<all_enemy_num and can_add:
        
        var i=randi_range(0,enemy_type.size()-1)
        var temp=enemy_type[i].instantiate()
        
        temp.global_position.x=randf_range(GlobalData.boundary.x+100,GlobalData.boundary.z-100)
        temp.global_position.y=randf_range(GlobalData.boundary.y+100,GlobalData.boundary.w-100)
        add_child(temp)
        can_add=false
        cur_nums+=1
    if cur_nums>=all_enemy_num:
        finished.emit()

func _on_timer_timeout() -> void:
    can_add=true
