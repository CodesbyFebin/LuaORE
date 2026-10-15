-- Lumen Vale base nodes for the LuaORE engine.
-- Original game content. Uses the public Lua mod API.

local S = minetest.get_translator("lumen_default")

local function node(name, def)
	def.mod_origin = "lumen_default"
	minetest.register_node("lumen_default:" .. name, def)
end

node("stone", {
	description = S("Lumen Stone"),
	tiles = {"default_stone.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = true,
})

node("dirt", {
	description = S("Lumen Dirt"),
	tiles = {"default_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	is_ground_content = true,
})

node("grass", {
	description = S("Lumen Grass"),
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly = 3, soil = 1, grass = 1},
	drop = "lumen_default:dirt",
	is_ground_content = true,
})

node("crystal", {
	description = S("LuaORE Crystal"),
	tiles = {"default_mineral_mese.png"},
	groups = {cracky = 1, crystal = 1, ore = 1},
	light_source = 6,
	is_ground_content = true,
})

node("ore", {
	description = S("Lumen Ore"),
	tiles = {"default_stone.png^default_mineral_copper.png"},
	groups = {cracky = 2, ore = 1},
	drop = "lumen_default:ore_lump",
	is_ground_content = true,
})

minetest.register_craftitem("lumen_default:ore_lump", {
	description = S("Lumen Lump"),
	inventory_image = "default_copper_lump.png",
	groups = {ore = 1},
})

minetest.register_craftitem("lumen_default:crystal_shard", {
	description = S("Crystal Shard"),
	inventory_image = "default_mese_crystal.png",
	groups = {crystal = 1},
})

minetest.register_craft({
	output = "lumen_default:crystal_shard 4",
	recipe = {{"lumen_default:crystal"}},
})

minetest.register_craft({
	output = "lumen_default:stone",
	recipe = {
		{"lumen_default:ore_lump", "lumen_default:ore_lump"},
		{"lumen_default:ore_lump", "lumen_default:ore_lump"},
	},
})

minetest.register_alias("mapgen_stone", "lumen_default:stone")
minetest.register_alias("mapgen_dirt", "lumen_default:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "lumen_default:grass")
minetest.register_alias("mapgen_water_source", "air")
minetest.register_alias("mapgen_river_water_source", "air")

minetest.register_ore({
	ore_type = "scatter",
	ore = "lumen_default:ore",
	wherein = "lumen_default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 5,
	clust_size = 3,
	y_max = 32,
	y_min = -128,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lumen_default:crystal",
	wherein = "lumen_default:stone",
	clust_scarcity = 18 * 18 * 18,
	clust_num_ores = 3,
	clust_size = 2,
	y_max = -16,
	y_min = -256,
})

minetest.register_biome({
	name = "lumen_vale",
	node_top = "lumen_default:grass",
	depth_top = 1,
	node_filler = "lumen_default:dirt",
	depth_filler = 3,
	node_stone = "lumen_default:stone",
	y_max = 31000,
	y_min = 1,
	heat_point = 52,
	humidity_point = 48,
})

minetest.register_chatcommand("vale", {
	description = S("Print the LuaORE world name"),
	func = function()
		return true, "Lumen Vale — LuaORE"
	end,
})
