local Droplet = require('droplet')
local Drop = {}
Drop.__index = Drop

setmetatable(Drop, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function Drop.create(x, y, z, height, speed, length, depth)
    local drop = {
        x = x,
        y = y,
        z = z,
        splash = false,
        droplets = Drop.createDroplets(x, height, z, 5),
        length = length
    }
    drop.speed = Drop.map(z, 0, depth, 4, 10)
    return setmetatable(drop, Drop)
end

function Drop.random(width, height, depth)
    local x = math.random(0, width)
    local y = math.random(-500, -50)
    local z = math.random(0, depth)
    local speed = math.random(5, 10)
    local length = math.random(10, 20)
    return Drop(x, y, z, height, speed, length, depth)
end


function Drop.map(value, low1, high1, low2, high2)
    return math.floor(low2 + (high2 - low2) * ((value - low1) / (high1 - low1)))
end

function Drop.createDroplets(x, y, z, number)
    local droplets = {}
    for i = 1, number, 1 do
        local xspeed = math.random(-5, 5)
        local yspeed = math.random(0, -5)
        local radius = math.random(0.1, 3)
        droplets[i] = Droplet(x, y - 5, z, xspeed, yspeed, radius, 30)
    end
    return droplets
end

function Drop:update(height)
    if (not self.splash) then
        self.y = self.y + self.speed
        self.speed = self.speed + 0.05
        if (self.y > height) then
            self.splash = true
        end
    else
        local finished = 0
        for _, droplet in ipairs(self.droplets) do
            finished = finished + droplet:update()
        end
        self.finished = #self.droplets <= finished
    end
end


function Drop:get(depth)
    local thick = self.map(self.z, 0, depth, 1, 3)
    local droplets = self.splash and self.droplets or nil
    return self.x, self.y, self.x, self.y + self.length, thick, droplets
end


return Drop
