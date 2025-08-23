extends Unit

class_name Player


var Data:UnitStats
# 玩家的移动方向向量（通常为归一化向量，如Vector2.RIGHT表示向右）
var move_dir: Vector2
# 玩家当前的移动速度向量（包含方向和速率信息）
var cur_velocity: Vector2
# 摇杆输入的方向向量（用于控制玩家移动方向）
var joystick_dir: Vector2
signal upgrade(level:int)
