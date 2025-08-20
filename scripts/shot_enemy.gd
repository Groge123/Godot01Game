extends Enemy

class_name Shot_Enemy

@onready var shot_pos: Node2D = $Visuals/Sprite/shot_pos
@onready var wait_time: Timer = $wait_time

@export var bullet:PackedScene
var attack_state=false

func _ready() -> void:
    super._ready()
    
func _process(delta: float) -> void:
    super._process(delta)
    

func shoot():
    var player=GlobalData.cur_Player
    var bt:Bullet=bullet.instantiate()
    bt.target_group=bt.groups.player
    print(bt.target_group)
    bt.global_position=shot_pos.global_position
    get_tree().root.add_child(bt)
    bt.shoot(player,basic_data.attack_power,false)
    pass
func _on_vision_area_area_entered(area: Area2D) -> void:
    if area.is_in_group("player"):
        attack_state=true
        can_move=false
        wait_time.start()


func _on_vision_area_area_exited(area: Area2D) -> void:
    if area.is_in_group("player"):
        attack_state=false
        can_move=true
        wait_time.stop()

func _on_wait_time_timeout() -> void:
    if attack_state:
        shoot()
    
