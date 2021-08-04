dofile("data/scripts/director_helpers.lua")
dofile("data/scripts/biomes/mountain/mountain.lua")

dofile("data/scripts/lib/utilities.lua")
dofile("mods/Ride Minecart/files/utilities.lua")

--------------------- This forecefully sets the set item as a Portal trigger or Portal!

g_cartlike = {
	total_prob = 0,
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,
		offset_x    = 0,
		entity 	= "data/entities/props/statues/statue_rock_01.xml"
	},
}

local MineStrength = ModSettingGet("Ride Minecart.ui_Break")

GamePrint(MineStrength)

if MineStrength == "max" then
	g_cartlike = {
		total_prob = 0,
		{
			prob   		= 1,
			min_count	= 1,
			max_count	= 1,
			offset_y 	= 0,
			offset_x    = 0,
			entity 	= "mods/Ride Minecart/files/Minecart/modded_minecart_unbreakable.xml"
		},
	}
else
    g_cartlike = {
		total_prob = 0,
		{
			prob   		= 1,
			min_count	= 1,
			max_count	= 1,
			offset_y 	= 0,
			offset_x    = 0,
			entity 	= "mods/Ride Minecart/files/Minecart/modded_minecart_breakable.xml"
		},
	}
end

--------------------- This sets portal position

function spawn_crate(x, y)
	spawn(g_cartlike,x,y) 
end
