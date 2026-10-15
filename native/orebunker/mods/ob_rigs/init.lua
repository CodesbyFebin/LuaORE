local storage=minetest.get_mod_storage()
local tiers={
 cobble={label="Cobblestone Compute Node",hashes=100,price=0},
 amethyst={label="Amethyst ASIC Rig",hashes=1500,price=50},
 ember={label="Quantum Ember Core",hashes=12000,price=400}
}
local function key(name) return "player:"..name end
local function read(name)
 local raw=storage:get_string(key(name))
 local ok,data=pcall(minetest.deserialize,raw)
 if not ok or type(data)~="table" then data={} end
 data.credits=math.max(0,math.floor(tonumber(data.credits) or 0))
 data.nodes=type(data.nodes)=="table" and data.nodes or {cobble=1}
 return data
end
local function save(name,data) storage:set_string(key(name),minetest.serialize(data)) end
local function hashrate(data)
 local n=0
 for tier,info in pairs(tiers) do
  n=n+math.max(0,math.floor(tonumber(data.nodes[tier]) or 0))*info.hashes
 end
 return n
end
minetest.register_chatcommand("obrig",{
 description="Display your virtual rigs, hashing capacity and fictional credits",
 func=function(name)
  local d=read(name)
  return true,"Virtual H/s: "..hashrate(d).." | Credits: "..d.credits..
   " | Cobble: "..(d.nodes.cobble or 0)..
   " | Amethyst: "..(d.nodes.amethyst or 0).." | Ember: "..(d.nodes.ember or 0)
 end
})
minetest.register_chatcommand("obbuy",{
 params="<amethyst|ember>",description="Buy a virtual mining rig with game credits",
 func=function(name,param)
  local tier=tiers[param]
  if not tier or tier.price<=0 then return false,"Choose amethyst or ember" end
  local d=read(name)
  if d.credits<tier.price then return false,"Not enough fictional credits" end
  d.credits=d.credits-tier.price
  d.nodes[param]=(d.nodes[param] or 0)+1
  save(name,d)
  return true,"Purchased "..tier.label
 end
})
-- Server clock drives local fictional production; no device CPU mining or token payouts.
local accum=0
minetest.register_globalstep(function(dt)
 accum=accum+dt
 if accum<10 then return end
 local cycles=math.min(6,math.floor(accum/10));accum=accum-cycles*10
 for _,player in ipairs(minetest.get_connected_players()) do
  local name=player:get_player_name()
  local d=read(name)
  d.credits=d.credits+math.floor(hashrate(d)*cycles/100)
  save(name,d)
 end
end)
