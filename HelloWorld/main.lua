function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 50
    size = 500 / res
    noise_scale = 0.1
    z = 0.001
end

function love.update(dt)
    fills = {}
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            index = i + j * res
            fills[index] = love.math.noise( i * noise_scale, j * noise_scale, z )
        end
    end
    z = z + 0.1
end

function love.draw()
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            index = i + j * res
            x = i * size
            y = j * size
            love.graphics.setColor(fills[index], 0, 0)
            love.graphics.rectangle("fill", x, y, size, size)
        end
    end
    
end