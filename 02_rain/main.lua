local Scene = require('scene')
local numberOfDrops = 400
local width, height = love.graphics.getDimensions()
local scene = Scene(width, height, numberOfDrops)

function love.load(arg)
    love.graphics.setBackgroundColor(230, 230, 250) -- Purple
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
    
    -- Draw scene
    for index, drop in ipairs(scene:getDrops()) do

        -- Get Drop data
        x1, y1, x2, y2, thick = drop:get(20)

        -- Draw drop
        love.graphics.setColor(138, 43, 226)
        love.graphics.setLineWidth(thick)
        love.graphics.line(x1, y1, x2, y2)

        -- After capturing the current state, update the drop position
        scene:update(drop, index)
    end
end
