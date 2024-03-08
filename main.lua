#include "sources/environment.lua"
#include "sources/player.lua"
#include "sources/utils.lua"
#include "sources/world.lua"
#include "sources/prefab.lua"
#include "sources/vehicle/vehicle.lua"
#include "sources/registry.lua"
#include "sources/particles.lua"
#include "sources/debug.lua"
#include "sources/spawn.lua"
#include "settings.lua"

local dp;

if MOD.DEBUG then
    dp = Debug:new(nil)
else
    print("Debug is disabled. local dp is nil.")
end

function init()
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::   INIT SCIDOWN MOD    :::::::")
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::::::::::::::::::::::::::::::::")

    --setUpTest()
    -- CreateEnvironmentByPrefab(Environment.space1)
    PlayerInit()
    -- CreateDynamicPlanet()
    -- CreateXMLPrefab(Prefabs.moon2, true)
    -- CreateXMLPrefab(Prefabs.moon3Voxbox, true)
    -- SpawnPrefab(Prefabs.moon2)
    -- SpawnPrefab(Prefabs.moon3Voxbox)
    -- SpawnSafeHouse()


    -- SpawnObjectAccordingPlayerPos(Prefabs.moon2, 40, 70, 80)
    -- SpawnObjectAccordingPlayerPos(Prefabs.planet1, 70, 20, 20)
    -- SpawnVehicle(Vehicle.spaceship)
    -- SpawnCelestialBody(CelestialBodies.PLANET, true)
    PopulateSpace()
end

function tick()
    if dp ~= nil then
        dp:worldDebug()
   end
    -- local pos = "3.0 134.0 0.9"
    -- RandomSpawnPosition(pos)
    -- playerPos = VecAdd(GetPlayerTransform().pos, Vec(0, 1, 0))
    -- print("Player pos 1: " .. VecStr(playerPos))

    PlayerTick()
    -- VehicleTick()
    -- PrintRegistryKeys("game.player.tool")
    -- AddParticleEffect() 
end

function update(dt)
   if dp ~= nil then
        dp:flyMode()
   end
    -- PlayerDebugInfo()
    PlayerUpdate(dt)
end

function draw(dt)
    if dp ~= nil then
        dp:UIDebug()
    end
end
