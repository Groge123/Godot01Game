extends Area2D

class_name Bullet

var damage:int
var is_critical:bool
var direction:Vector2


@export var speed:=800
var groups:={
    "player":"player",
    "enemy":"enemy"
}
@export var target_group:String="enemy"
@onready var survival_time: Timer = $survival_time
func _ready() -> void:
    survival_time.start()

func _process(delta: float) -> void:
    global_position+=direction*speed*delta

func shoot(enemy,hurt_num:int,is_crit:bool):
    damage=hurt_num
    is_critical=is_crit
    direction=(enemy.global_position-global_position).normalized()
func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group(target_group):
        area.hurt(damage,is_critical)
        queue_free()
    elif area.is_in_group("wall"):
        queue_free()
        print("enter a wall then pop")


func _on_survival_time_timeout() -> void:
    queue_free()
