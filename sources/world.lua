#include "sources/prefab.lua"
#include "sources/utils.lua"
#include "sources/commons/colors.lua"
#include "sources/commons/constants.lua"


CelestialBodies = {
    STAR = { -- DEFAULT CONFIGURATION
        name = 'STAR',
        type = 'RED_GIANT'; 
        emitsLight = true, 
        gravitStrength = 30,
        allowRotation = false, -- After spawn / For Animation
        spawnChance = 70,  -- Calls before Spawn
        hasParticles = true,
        prefab = Prefabs.star
    },

    PLANET = {
        name = 'PLANET',
        moonCount = 0,
        type = 'GASEOUS_PLANET', -- GASEOUS_PLANET, ROCKY OR OCEAN
        gravitStrength = 30,
        allowRotation = true,
        allowMovement = true, -- allow translation movement
        spawnChance = 100,
        prefab = Prefabs.planet -- can be a solid prefab or particle
    },

    ASTEROID = {
        name = 'ASTEROID',
        type = 'RANDOM',
        allowRotation = true,
        allowMovement = true,
        hasParticles = true,
        velocity = 50,
        spawnChance = 100,
        prefab = Prefabs.asteroid
    },

    NATURAL_SATELLITE = {
        name = 'NATURAL_SATELLITE',
        type = 'NATURAL_SATELLITE_DEFAULT',
        gravitStrength = 30,
        allowRotation = true,
        spawnChance = 100,
        velocity = 50,
        prefab = Prefabs.naturalSatellite
    },

    BLACK_HOLE = {
        name = 'BLACK_HOLE',
        type = 'MASSIVE',
        gravitStrength = 100,
        allowRotation = true,
        spawnChance = 5,
    },

    NEBULOSA = {
        name = 'NEBULOSA',
        type = 'NEBULOSA_DEFAULT',
        spawnChance = 10,
        prefab = Prefabs.Particles.nebulosa
    },

    GIANT_STAR = {
        name = 'GIANT_STAR',
        type = 'GIANT_STAR_DEFAULT',
        spawnChance = 10,
        prefab = Prefabs.Particles.giantStar
    }
}

--[[

Create a custom celestial body with Random (or not) Properties

]]--


function SetupCustomCelestialBody(object, debug)
    -- Check type of param entered
    --assert(type(object)=="table", print("[>] SetupCustomCelestialBody: Param is a table."))

    if (object ~= nil) then
        CreateCelestialBody(object, debug)
    else
        print("[x] CreateCustomCelestialBody: OBJECT IS NIL")
    end
end

function CreateCelestialBody(properties, debug) 
    -- Table values
    -- This values are special beacause they need to be converted to a table
    local prefabProperties = properties.prefab; -- Separete prefab properties

    local pos, rot; 
    -- local color, size;
    local posValues, rotValues;
    -- local colorValues, sizeValues;

    -- Its important to have disponible this values as vector or integer
    -- because we gone use later in this function
    posValues = GetTableValuesFromProperties(prefabProperties, 'pos')
    rotValues = GetTableValuesFromProperties(prefabProperties, 'rot')
    -- colorValues = GetTableValuesFromProperties(prefabProperties, 'color')
    -- sizeValues = GetTableValuesFromProperties(prefabProperties, 'size')

    pos = CreateTableStringForXML(posValues)
    rot = CreateTableStringForXML(rotValues)
    -- color = CreateTableStringForXML(colorValues)  -- not used yet
    -- size = CreateTableStringForXML(sizeValues) -- not used yet

    -- Configure object properties if a type is given (objects properties are optionals)
    -- Check if the prefab name matches with property name
    if (prefabProperties.name == string.lower(properties.name)) then 
        if (prefabProperties.name == string.lower('STAR')) then --
            _StarConfiguration(prefabProperties, properties)

        elseif (prefabProperties.name == string.lower('ASTEROID')) then
            _AsteroidConfiguration(prefabProperties, properties)
            
        elseif (prefabProperties.name == string.lower('PLANET')) then
            _PlanetConfiguration(prefabProperties, properties)
            -- TODO: Need to check the moonCount to spawn in planets orbits
            --if (properties.moonCount > 0) then
                --_NaturalSatelliteConfiguration(prefabProperties, properties)
            --end
        end
    end
    local base = "<voxbox name=" .. "'".. prefabProperties.name .. "'" .. " " ..
            "tags=" .. "'".. prefabProperties.tags .. "'" .. " " ..
            "pos=" .. "'".. pos .. "'" .. " " ..
            "rot=" .. "'".. rot .. "'" .. " " ..
            "desc=" .. "'".. prefabProperties.desc .. "'" .. " " ..
            "texture=" .. "'".. prefabProperties.texture .. "'" .. " " ..
            "blendtexture=" .. "'".. prefabProperties.blendtexture .. "'" .. " " ..
            "density=" .. "'".. prefabProperties.density .. "'" .. " " ..
            "strength=" .. "'".. prefabProperties.strength .. "'" .. " " ..
            "collide=" .. "'".. prefabProperties.collide .. "'" .. " " ..
            "prop=" .. "'".. prefabProperties.prop .. "'" .. " " ..
            "size=" .. "'".. prefabProperties.size .. "'" .. " " ..
            "brush=" .. "'".. prefabProperties.brush .. "'" .. " " ..
            "material=" .. "'".. prefabProperties.material .. "'" .. " " ..
            "pbr=" .. "'".. prefabProperties.pbr .. "'" .. " " ..
            "color=" .. "'" .. prefabProperties.color .. "'" .. " " ..
            "/>"
    -- local xml = "<voxbox size='10 10 10' prop='false' material='wood'/>"
    -- if the object dont have the 'pos' property

    -- Sets an default spawn position maybe its a good idea make a method for that
    local t
    if pos == '' then
        t = Transform(Vec(10, 10, 0)) -- Default position spawn (make later some logic)
    else
        t = Transform(Vec(pos[1], pos[2], pos[3]))
    end
	Spawn(base, Transform(t))

    local handleShape = FindShape(prefabProperties.tags, true)
    -- local handleBody = FindBody(prefabProperties.tags, true) -- For some reason, the body is not created

    -- Do finals configurations like:
    --  > INCREASE EMISSION LIGHT;
    --  > ADD PARTICLES EFFECT;

    IncreaseEmissiveScale(prefabProperties.tags, properties.emitsLight)
        
    -- Check if the object has CREATED (shape and body) and gives a feedback if debug is active
    if debug then
        if handleShape ~= 0 then
            print(":::::::::::::: PREFAB [" .. string.upper(prefabProperties.name)  .. "] CREATED :::::::::::::::::::")
            print(base)
            print(":::::::::::::::::::::::::::::::::::::::::::::::::")
        else
            print("XXXXXXXXXXXXX PREFAB [" .. string.upper(prefabProperties.name)  .. "] NOT CREATED XXXXXXXXXXXXX")
        end
    end
end
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- :::::::::::::::::::     CELESTIAL BODIES     :::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- Pseudo private method to configure prefab properties and more options
function _StarConfiguration(prefabProperties, properties)
    -- Configure object properties if a type is given (objects properties are optionals)
    if (properties.type == CONSTANTS.CELESTIALBODY_TYPE.STAR.RED_GIANT) then
        prefabProperties.desc = "A Glorious Red Giant."
        prefabProperties.tags = "star_red_giant" -- Tag must by one only and not have spaces to work properly
        prefabProperties.brush = CONSTANTS.VOX.WORLD.STARS.STAR_REDGIANT
        prefabProperties.size = "160 160 156"
        if (properties.gravitStrength > 50) then
            prefabProperties.density = "100"
            prefabProperties.strength = "100"
        else
            prefabProperties.density = "10"
            prefabProperties.strength = "10"
        end
        if (properties.emitsLight) then
            prefabProperties.pbr = "0 0 0 20"
        else
            prefabProperties.pbr = "1 1 1 0"
        end
        prefabProperties.color = PREFAB_COLORS.RED
    end
        return prefabProperties
end

--
function _AsteroidConfiguration(prefabProperties, properties)
    -- Configure object properties if a type is given (objects properties are optionals)
    if (properties.type == CONSTANTS.CELESTIALBODY_TYPE.ASTEROID.RANDOM) then
        prefabProperties.desc = "A normal and boring asteroid."
        prefabProperties.tags = "asteroid_default" -- Tag must by one only and not have spaces to work properly
        prefabProperties.brush = CONSTANTS.VOX.WORLD.ASTEROIDS.ASTEROID1
        prefabProperties.size = "20 24 24"
        prefabProperties.texture = RandomPrefabProperty('texture')
        prefabProperties.blendtexture = RandomPrefabProperty('blendtexture')
        prefabProperties.color = PREFAB_COLORS.RED
    end
        return prefabProperties
end

function _PlanetConfiguration(prefabProperties, properties)
    -- Configure object properties if a type is given (objects properties are optionals)
    if (properties.type == CONSTANTS.CELESTIALBODY_TYPE.PLANET.GASEOUS) then
        prefabProperties.desc = "A Gaseous Planet."
        prefabProperties.tags = "gaseous_planet"
    
    elseif (properties.type == CONSTANTS.CELESTIALBODY_TYPE.PLANET.ROCKY) then
        prefabProperties.desc = "A Rocky Planet."
        prefabProperties.tags = "rocky_planet"

    elseif (properties.type == CONSTANTS.CELESTIALBODY_TYPE.PLANET.OCEAN) then
        prefabProperties.desc = "A Ocean Planet."
        prefabProperties.tags = "ocean_planet"
    
    elseif (properties.type == CONSTANTS.CELESTIALBODY_TYPE.PLANET.RANDOM) then
        local rot = GetTableValuesFromProperties(prefabProperties, 'rot')
        prefabProperties.tags = "random_planet"
        prefabProperties.desc = "A Random Planet."
        prefabProperties.rot = ''
        
    end
        return prefabProperties
end


-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- ::::::::::::::   COMPLEMENTARY FUNCTIONS     :::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- Need to be call after spawn
function IncreaseEmissiveScale(tag, emitsLight)
    local shape = FindShape(tag)
    if (shape ~= 0) then
        if (emitsLight) then
            local scale = math.sin(GetTime()) * 1.0 + 1.0
            SetShapeEmissiveScale(shape, scale)
        end
    else 
        print("[X] Error: The shape doesn't exists.")
    end
end


function CreateTableStringForXML(table)
    local strAux;
    if #table == 3 then -- Check if table size == 3 beacause the Vec() is a function that only accepts 3 values
        strAux = table[1] .. " " .. 
                table[2] .. " " ..
                table[3]
        return strAux
    else
        return ''
    end
end
