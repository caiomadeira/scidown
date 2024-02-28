#include "sources/enviroment.lua"
#include "sources/player.lua"
#include "sources/utils.lua"
#include "sources/world.lua"
#include "sources/prefab.lua"
#include "sources/vehicle.lua"
#include "sources/registry.lua"
#include "sources/particles.lua"
--#include "tests.lua"

function init()
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::   INIT SCIDOWN MOD    :::::::")
    print("::::::::::::::::::::::::::::::::::::::::")
    print("::::::::::::::::::::::::::::::::::::::::")

    --setUpTest()
    loadCustomEnvironment(1, false)
    PlayerInit()
    -- CreateDynamicPlanet()
    -- CreateXMLPrefab(Prefabs.moon2, true)
    -- CreateXMLPrefab(Prefabs.moon3Voxbox, true)
    -- SpawnPrefab(Prefabs.moon2)
    -- SpawnPrefab(Prefabs.moon3Voxbox)
    -- SpawnSafeHouse()


    --SpawnObjectAccordingPlayerPos(Prefabs.moon2, 40, 70, 80)
    --SpawnObjectAccordingPlayerPos(Prefabs.planet1, 70, 20, 20)
    -- SpawnSpaceShip(Vehicles.SpaceshipSmall1)
    SetupCustomCelestialBody(CelestialBodies.STAR, true)
    SetupCustomCelestialBody(CelestialBodies.ASTEROID, true)
    local n = math.random(-34, 34)
    print("random number: " .. tostring(n))
    local objectPos = { 200.0, 134.0, 0.9 }
    local dummyWordLength = { 
        CONSTANTS.WORLD.SIZE.WIDTH - 100,
        CONSTANTS.WORLD.SIZE.HEIGHT - 40,
        CONSTANTS.WORLD.SIZE.DEPTH - 100
    }
    local time = GetTime() -- Time for API
    CalcSpawnPosWithOffset(objectPos, dummyWordLength, time)
    print("Finish init main.lua")
end

function tick()
    --local pos = "3.0 134.0 0.9"
    --RandomSpawnPosition(pos)
    --playerPos = VecAdd(GetPlayerTransform().pos, Vec(0, 1, 0))
    --print("Player pos 1: " .. VecStr(playerPos))

    PlayerTick()
    VehicleTick()
    -- PrintRegistryKeys("game.player.tool")
    --AddParticleEffect() 
    --SpaceShipCameraMovement()
end

function update(dt)
    -- DebugPlayer()
    PlayerUpdate(dt)
end