local Drop = {}
Drop.__index = Drop

setmetatable(Drop, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function Drop.create(x, y, z, speed, length, depth)
    local drop = {
        x = x,
        y = y,
        z = z,
        length = length
    }
    drop.speed = Drop.map(z, 0, depth, 4, 10)
    return setmetatable(drop, Drop)
end

function Drop.map(value, low1, high1, low2, high2)
    return math.floor(low2 + (high2 - low2) * ((value - low1) / (high1 - low1)))
end

function Drop:update()
    self.y = self.y + self.speed
    self.speed = self.speed + 0.05
end


function Drop:get(depth)
    local thick = self.map(self.z, 0, depth, 1, 3)
    return self.x, self.y, self.x, self.y + self.length, thick
end


return Drop
