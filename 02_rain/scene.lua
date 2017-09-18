local Drop = require('drop')
local Scene = {}
Scene.__index = Scene

setmetatable(Scene, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function Scene.getRandomDrop(width, height, depth)
    local x = math.random(0, width)
    local y = math.random(-500, -50)
    local z = math.random(0, depth)
    local speed = math.random(5, 10)
    local length = math.random(10, 20)
    return Drop(x, y, z, speed, length, depth)
end

function Scene.create(width, height, numberOfDrops)
    local scene = {
        numberOfDrops = numberOfDrops,
        width = width,
        height = height,
        depth = 20,
        drops = {}
    }
    
    for i = 1, numberOfDrops, 1 do
        scene.drops[i] = Scene.getRandomDrop(width, height, scene.depth)
    end

    return setmetatable(scene, Scene)
end

function Scene:update(drop, index)
    if (drop.y > self.height) then
        self.drops[index] = Scene.getRandomDrop(self.width, self.height, self.depth)
    else
        drop:update()
    end
end

function Scene:getDrops()
    return self.drops
end

return Scene
