local Star = require('star')
local StarField = {}
StarField.__index = StarField

setmetatable(StarField, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function StarField.getRandomStar(width, height)
    local x = math.random(-width/4, width/4)
    local y = math.random(-height/2, height/2)
    local z = math.random(width)
    local speed = math.random(1, 6)
    return Star(x, y, z, speed)
end

function StarField.create(width, height, numberOfStars)
    local starfield = {
        numberOfStars = numberOfStars,
        width = width,
        height = height,
        stars = {}
    }
    
    for i = 1, numberOfStars, 1 do
        starfield.stars[i] = StarField.getRandomStar(width, height)
    end

    return setmetatable(starfield, StarField)
end

function StarField:update(star, index)
    if (star.z <= star.speed) then
        self.stars[index] = StarField.getRandomStar(self.width, self.height)
    else
        star:update()
    end
end

function StarField:getStars()
    return self.stars
end

return StarField
