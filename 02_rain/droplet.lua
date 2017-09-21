local Droplet = {}
Droplet.__index = Droplet

setmetatable(Droplet, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function Droplet.map(value, low1, high1, low2, high2)
    return math.floor(low2 + (high2 - low2) * ((value - low1) / (high1 - low1)))
end

function Droplet.create(x, y, z, xspeed, yspeed, radius, depth)
    local droplet = {
        x = x,
        inity = y + 20,
        y = y,
        z = z,
        radius = radius,
        xspeed = xspeed,
        yspeed = yspeed,
        finished = false
    }
    
    --droplet.xspeed = Droplet.map(xspeed, 0, depth, 4, 10)
    --droplet.yspeed = Droplet.map(yspeed, 0, depth, 4, 10)
    return setmetatable(droplet, Droplet)
end

function Droplet:update()
    self.x = self.x + self.xspeed
    self.y = self.y + self.yspeed
    self.yspeed = self.yspeed + 0.3
    return self.y > self.inity and 1 or 0
end


function Droplet:get(depth)
    return self.x, self.y, self.radius
end


return Droplet
