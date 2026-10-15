local modname = minetest.get_current_modname()
local mode = minetest.settings:get("orebunker_mode") or "survival"
local function texture(color) return "[fill:16x16:" .. color end
local function block(id, title, tint, hardness, score, scarcity)
 minetest.register_node(modname .. ":" .. id, {
  description = title, tiles = {texture(tint)},
  groups = {cracky = hardness, stone = 1},
  sounds = nil,
  _orebunker_score = score,
 })
 if scarcity then
  minetest.register_ore({
   ore_type="scatter", ore=modname..":"..id, wherein=modname..":stone",
   clust_scarcity=scarcity, clust_num_ores=3, clust_size=3,
   y_min=-31000, y_max=-4
  })
 end
end
block("stone","Stone","#737985",3,1,nil)
block("coal","Coal","#323943",3,3,8*8*8)
block("diamond","Diamond","#5dcde0",2,25,16*16*16)
block("ore","ORE Emblem Crystal (game resource)","#e89c27",2,25,12*12*12)
block("solana","Solana Emblem Crystal (game resource)","#705edd",2,25,14*14*14)
minetest.register_node(modname..":dirt",{
 description="Dirt",tiles={texture("#776247")},groups={crumbly=3,soil=1}
})
minetest.register_node(modname..":grass",{
 description="Grass-covered Dirt",tiles={texture("#5d9956"),texture("#776247"),
 texture("#5d9956")},groups={crumbly=3,soil=1}
})
minetest.register_node(modname..":water",{
 description="Water",drawtype="liquid",tiles={texture("#2870a5")},
 special_tiles={texture("#2870a5")},paramtype="light",
 walkable=false,pointable=false,diggable=false,buildable_to=true,
 liquidtype="source",liquid_alternative_flowing=modname..":water",
 liquid_alternative_source=modname..":water",liquid_viscosity=1,
 groups={water=3,liquid=3}
})
for from,to in pairs({
 mapgen_stone=modname..":stone",
 mapgen_dirt=modname..":dirt",
 mapgen_dirt_with_grass=modname..":grass",
 mapgen_sand=modname..":dirt",
 mapgen_water_source=modname..":water",
 mapgen_river_water_source=modname..":water"
}) do minetest.register_alias(from,to) end
minetest.register_tool(modname..":pickaxe",{
 description="OreBunker Diamond Pickaxe (virtual tool)",
 inventory_image=texture("#3fb9d3"),
 tool_capabilities={full_punch_interval=0.6,max_drop_level=3,
  groupcaps={cracky={times={[1]=1.4,[2]=0.7,[3]=0.3},uses=100,maxlevel=3}},
  damage_groups={fleshy=3}}
})
minetest.register_on_newplayer(function(player)
 player:get_inventory():add_item("main",modname..":pickaxe")
end)
minetest.register_chatcommand("obmode",{
 description="Show current OreBunker game mode",
 func=function() return true,"OreBunker mode: "..mode.." | Fictional resources only" end
})
