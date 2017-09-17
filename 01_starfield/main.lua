local StarField = require('starfield')
local numberOfStars = 400
local width, height = love.graphics.getDimensions()
local starfield = StarField(width, height, numberOfStars)

function love.load(arg)
    love.graphics.setBackgroundColor(0, 0, 0) -- Black
end

function love.keypressed(k)
    if k == 'escape' or k == 'q' then
        love.event.quit()
    end

    if k == 'f' then
        if (love.window.getFullscreen()) then
            love.window.setFullscreen(false, 'desktop')
        else 
            love.window.setFullscreen(true, 'desktop')
        end
        width, height = love.graphics.getDimensions()
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.translate(width / 2, height / 2)
    
    -- Draw starfield
    for index, star in ipairs(starfield:getStars()) do

        -- Get Star data
        x, y, r, px, py = star:get(width, height)

        -- Draw star
        love.graphics.setColor(255, 255, 255)
        love.graphics.ellipse('fill', x, y, r, r)

        -- Draw star tail
        if (px) then
            love.graphics.setColor(255, 255, 200)
            love.graphics.setLineWidth(r)
            love.graphics.line(x, y, px, py)
        end

        -- After capturing the current state, update the star position
        starfield:update(star, index)
    end
end
