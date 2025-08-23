extends Node

func _ready() -> void:
    var s="attack_add"
    print(s)
    var new=s.trim_suffix("_add")
    print(new)
