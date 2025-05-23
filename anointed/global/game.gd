extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addMonster("Skeleton")
	addMonster("Goblin")
	addMonster("Mushroom")
	addBossMonster(selectedBoss, "Mushroom")
	addBossMonster(firstBoss, "Skeleton")
	addBossMonster(firstBoss, "Skeleton")
	addBossMonster(skeleton, "Skeleton")
	addBossMonster(mushroom, "Mushroom")
	addBossMonster(goblin, "Goblin")
	addBossMonster(finalBoss, "Skeleton")
	addBossMonster(finalBoss, "Goblin")
	addBossMonster(finalBoss, "Mushroom")
	
	mushroom[0]["Level"] = 3
	goblin[0]["Level"] = 4
	
	finalBoss[0]["Level"] = 7
	finalBoss[1]["Level"] = 7
	finalBoss[2]["Level"] = 7
	
	healthPotions = 3

var dataBaseMonsters = {
	0 : {
		"Name" : "Skeleton",
		"Frame" : 0,
		"Health" : 100,
		"MaxHealth" : 100,
		"Level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defense" : 5,
		"Scene" : preload("res://Monsters/skeleton.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "Bone Bash",
				"Target" : "Monster",
				"Damage" : 14,
				"MaxDamage" : 17,
				"cost" : 2
			},
			1 : {
				"Name" : "Rattle Stab",
				"Target" : "Monster",
				"Damage" : 12,
				"MaxDamage" : 20,
				"cost" : 2
			},
			2 : {
				"Name" : "Grave Slash",
				"Target" : "Monster",
				"Damage" : 15,
				"MaxDamage" : 16,
				"cost" : 2
			}
			
		}
	},
	1 : {
		"Name" : "Goblin",
		"Frame" : 0,
		"Health" : 100,
		"MaxHealth" : 100,
		"Level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defense" : 5,
		"Scene" : preload("res://Monsters/goblin.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "Dagger Jab",
				"Target" : "Monster",
				"Damage" : 10,
				"MaxDamage" : 17,
				"cost" : 2
			},
			1 : {
				"Name" : "Theif Slash",
				"Target" : "Monster",
				"Damage" : 15,
				"MaxDamage" : 16,
				"cost" : 2
			},
			2 : {
				"Name" : "Bleed Poke",
				"Target" : "Monster",
				"Damage" : 10,
				"MaxDamage" : 20,
				"cost" : 2
			}
			
		}
	},
	2 : {
		"Name" : "Mushroom",
		"Frame" : 0,
		"Health" : 100,
		"MaxHealth" : 100,
		"Level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defense" : 5,
		"Scene" : preload("res://Monsters/mushroom.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "Spore Slam",
				"Target" : "Monster",
				"Damage" : 15,
				"MaxDamage" : 17,
				"cost" : 2
			},
			1 : {
				"Name" : "Cap Crush",
				"Target" : "Monster",
				"Damage" : 9,
				"MaxDamage" : 20,
				"cost" : 2
			},
			2 : {
				"Name" : "Zombie",
				"Target" : "Monster",
				"Damage" : 13,
				"MaxDamage" : 18,
				"cost" : 2
			}
			
		}
	}
}

var selectedMonsters = {
	
}

var selectedBossName = ""

var bosses = {0: firstBoss}

var selectedBoss = {

}

var skeleton = {}
var mushroom = {}
var goblin = {}
var firstBoss = {}
var finalBoss = {}

var healthPotions

func addBossMonster(bossName, Name):
	for i in dataBaseMonsters:
		if dataBaseMonsters[i]["Name"] == Name:
			var tempDic = dataBaseMonsters[i].duplicate(true)
			bossName[bossName.size()] = tempDic

func addMonster(Name):
	for i in dataBaseMonsters:
		if dataBaseMonsters[i]["Name"] == Name:
			var tempDic = dataBaseMonsters[i].duplicate(true)
			selectedMonsters[selectedMonsters.size()] = tempDic
			
func addExp(amount):
	for i in selectedMonsters:
		selectedMonsters[i]["Exp"] += amount
		if selectedMonsters[i]["Exp"] >= selectedMonsters[i]["MaxExp"]:
			selectedMonsters[i]["Level"] += 1
			selectedMonsters[i]["Exp"] = 0
			selectedMonsters[i]["MaxExp"] = selectedMonsters[i]["MaxExp"]*1.5
			selectedMonsters[i]["MaxHealth"] *= 1.1
			if selectedMonsters[i]["Health"] != selectedMonsters[i]["MaxHealth"]:
				selectedMonsters[i]["Health"] = selectedMonsters[i]["MaxHealth"]
