extends Line2D

@export var point_nums=10
@export var is_spawn=false
@export var target:Node2D
@export var color:Color=Color(1,1,1,0.5)
func _ready() -> void:
    default_color=color
func _physics_process(delta: float) -> void:
    if is_spawn and target:
        if get_point_count()>point_nums:
            remove_point(0)
        draw_point()
    else:
        if get_point_count()>0:
            remove_point(0)
func draw_point():
    add_point(target.global_position)
