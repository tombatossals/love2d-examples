local Drop = require('drop')
local Rain = {}
Rain.__index = Rain

setmetatable(Rain, {
    __call = function(cls, ...)
        return cls.create(...)
    end
})

function Rain.create(width, height, numberOfDrops)
    local rain = {
        numberOfDrops = numberOfDrops,
        width = width,
        height = height,
        depth = 20,
        drops = {}
    }
    
    for i = 1, numberOfDrops, 1 do
        rain.drops[i] = Drop.random(width, height, rain.depth)
    end

    return setmetatable(rain, Rain)
end

function Rain:update(drop, index)
    if (drop.finished) then
        self.drops[index] = Drop.random(self.width, self.height, self.depth)
    else
        drop:update(self.height)
    end
end

function Rain:getDrops()
    return self.drops
end

return Rain
