extends Node

class_name Attribute_Card

const all_weapon_name=[
    "pistol","punch"
]
const ATTR_GROUP={
    "attack":{
            "name":"攻击力",
            "type1":{
                "name":"基础伤害叠加",
                "icon":"res://assets/sprites/Upgrades/12.png"
            },
            "type2":{
                "name":"基础伤害倍数",
                "icon":"res://assets/sprites/Upgrades/9.png"
            },
            "type3":{
                "name":"攻击速度倍增",
                "icon":"res://assets/sprites/Upgrades/10.png"
            },
            "type4":{
                "name":"暴击率",
                "icon":"res://assets/sprites/Upgrades/7.png"
            }
        },
    "defence":{
        "name":"防御",
        "type1":{
            "name":"最大护盾",
            "icon":"res://assets/sprites/Upgrades/3.png"
        }
    },
    "health":{
        "name":"生命",
        "type1":{
            "name":"最大生命叠加",
            "icon":"res://assets/sprites/Upgrades/6.png"
        }
    },
    "weapon":{
        "name":"武器",
        "type1":{
            "name":"拳头",
            "icon":"res://assets/sprites/Weapons/Icons/weapon_punch_icon.png"
        },
        "type2":{
            "name":"手枪",
            "icon":"res://assets/sprites/Weapons/Icons/weapon_pistol_icon.png"
        }
    }
    
}
const ATTR={
    "health_max":{
        "group":ATTR_GROUP.health,
        "type":"type1",
        "range":"1-5",
        "var":"int"
    },
    "shield_max":{
        "group":ATTR_GROUP.defence,
        "type":"type1",
        "range":"1-5",
        "var":"int"
    },
    "cur_crit_rate":{
        "group":ATTR_GROUP.attack,
        "type":"type4",
        "range":"0.1-0.2",
        "var":"float"
    },
    "cur_attack_speed":{
        "group":ATTR_GROUP.attack,
        "type":"type3",
        "range":"1.1-1.5",
        "var":"float"
    },
    #weapon
    "pistol":{
        "group":ATTR_GROUP.weapon,
        "type":"type2",
        "var":"weapon",
        "range":"0-1",
    },
    "punch":{
        "group":ATTR_GROUP.weapon,
        "type":"type1",
        "var":"weapon",
        "range":"0-1",
        
    }
}
