extends Area2D

@export var value:=1:
    set(val):
        value=val
    get():
        return value
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
     
@export var pick_size:Vector2=Vector2(80,80)
signal pick_up(amount)

func _ready() -> void:
    if collision_shape_2d.shape is RectangleShape2D:
        var shape=RectangleShape2D.new()
        shape.size=pick_size
        collision_shape_2d.shape=shape
        
func picked(player:Node2D):
    $CollisionShape2D.call_deferred("set_disabled",true)
    var tween=get_tree().create_tween()
    tween.parallel()
    tween.tween_property($"Sprite2D","global_position",player.global_position,0.2)
    tween.tween_property($Sprite2D,"modulate:a",0,0.2)
    await tween.finished
    pick_up.emit(value)
    
    queue_free()


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("player"):
        picked(area)
