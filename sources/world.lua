#include "sources/prefab.lua"
#include "sources/utils.lua"

World = {
    size = {
        width = 300,
        height = 100,
        depth = 300
    }
}

PREFAB_COLORS = {
    RED = "0.5 0.5 0.5",
    BLUE = "0.0 1.0 0.93"
}

CelestialBodies = {

    --[[
    STAR HAS MANY TYPES:
    RED_GIANT:
        - BIG SIZE;
        - COLOR: RED;
        - HIGH GRAVITY EFFECT;
        - HAS PARTICLE EFFECT;

    BLUE_SUPER_GIANT: 
        - VERY BIG SIZE; 
        - COLOR: BLUE;
        - HIGH GRAVITY EFFECT;
        - HAS PARTICLE EFFECT;

    BROWN_DWARF:
        - SMALL SIZE; 
        - COLOR: WHITE;
        - VERY HIGH GRAVITY EFFECT;
        - NO_LIGHT.
        - NO PARTICLE EFFECT;
    ]]--


    STAR = { -- DEFAULT CONFIGURATION
        name = 'STAR',
        type = 'RED_GIANT'; 
        emitsLight = true, 
        gravitStrength = 30,
        allowRotation = false, -- After spawn / For Animation
        spawnChance = 70,  -- Calls before Spawn
        prefab = Prefabs.star
    },

    --[[
    GASEOUS PLANETS:
        - particles effects; 
        - can be toxic; 
        - not solid at all;
        - low density;
        - big scale;
        - HIGH moon count;

    ROCKY PLANETS: 
        - are solid; 
        - not have particles effects;
        - lower moon count;

    OCEAN PLANETS:
        - just water in a sphere;

    ]]--

    PLANET = {
        name = 'PLANET',
        moonCount = 0,
        type = 'GASEOUS', -- GASEOUS, ROCKY OR OCEAN
        gravitStrength = 30,
        allowRotation = true,
        allowMovement = true, -- allow translation movement
        spawnChance = 100,
    },

    ASTEROID = {
        name = 'ASTEROIRD',
        type = 'ASTEROID_DEFAULT',
        allowRotation = true,
        allowMovement = true,
        velocity = 50,
        spawnChance = 100,
    },

    NATURAL_SATELLITE = {
        name = 'NATURAL_SATELLITE',
        type = 'NATURAL_SATELLITE_DEFAULT',
        gravitStrength = 30,
        allowRotation = true,
        allowMovement = true,
        velocity = 50,
    },

        --[[
    BLACK HOLES:
        - INFINITE (HIGH) density;
        - Absorves bodies (and the player) and delete it
    ]]--

    BLACK_HOLE = {
        name = 'BLACK_HOLE',
        type = 'MASSIVE',
        gravitStrength = 100,
        allowRotation = true,
    }
}

--[[

Create a custom celestial body with Random Properties

]]--


function SetupCustomCelestialBody(object, debug)

    -- Check type of param entered
    assert(type(object)=="table", DebugPrint("[>] Nice: Param is a table."))

    if (object.name == 'STAR') then
        DebugPrint('STAR')
        
        CreateCelestialBody(object, debug)
        
    elseif (object == 'PLANET') then
        DebugPrint('PLANET')

    elseif (object == 'ASTEROID') then
        DebugPrint('ASTEROID')

    elseif (object == 'NATURAL_SATELLITE') then
        DebugPrint('NATURAL_SATELLITE')

    elseif (object == 'BLACK_HOLE') then
        DebugPrint('BLACK_HOLE')

    else
        DebugPrint("[x] Error in CreateCustomCelestialBody(type)")
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
    -- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- :::::::::::::::::::     STAR     :::::::::::::::::::::::::::::
    -- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    if (prefabProperties.name == string.lower(properties.name)) then 
        if (properties.type == 'RED_GIANT') then --
            prefabProperties = _StarConfiguration(prefabProperties, properties)
        end
        if (properties.type == 'ASTEROID_DEFAULT') then
            
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
    
    -- Check if the object has CREATED (shape and body) and gives a feedback if debug is active
    if debug then
        local handleShape = FindShape(prefabProperties.tags, true)
        local handleBody = FindBody(prefabProperties.tags, true)
        
        DebugPrint("Handled body: " .. tostring(handleBody))
        DebugPrint("Handled shape: " .. tostring(handleShape))
    
        if handleShape ~= 0 then
            DebugPrint(":::: [" .. string.upper(prefabProperties.name)  .. "] CREATED ::::")
            DebugPrint("[+] OBJECT TRANSFORM: " .. prefabProperties.pos)
            DebugPrint(base)
            DebugPrint(":::::::::::::::::::::::::::::::::::::::::::::")
        else
            DebugPrint("XXXXXXXXXXXXX OBJECT [" .. string.upper(prefabProperties.name)  .. "] NOT CREATED XXXXXXXXXXXXX")
        end
    end
end


function CreateTableStringForXML(table)
    local strAux;

    if #table == 3 then -- Check if table size == 3 beacause the Vec() is a function that only accepts 3 values
        strAux = table[1] .. " " .. 
                table[2] .. " " ..
                table[3]
        --DebugPrint("POS STRING: " .. strAux)
        return strAux
    else
        return ''
    end
end

-- Pseudo private method to configure prefab properties and more options
function _StarConfiguration(prefabProperties, properties)
    -- Configure object properties if a type is given (objects properties are optionals)
    -- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- :::::::::::::::::::     STAR     :::::::::::::::::::::::::::::
    -- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        prefabProperties.desc = "A Glorious Red Giant. 222"
        prefabProperties.tags = "star_red_giant" -- Tag must by one only and not have spaces to work properly
        prefabProperties.brush = "MOD/assets/models/star_redgiant.vox"
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
        return prefabProperties
end