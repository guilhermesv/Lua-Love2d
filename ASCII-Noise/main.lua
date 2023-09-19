function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 40
    size = 500 / res
    noise_scale = 0.1
    z = 0
    density = {' ', ' ', ' ', '.', ':', '+', '=', '#', '#', 'N', 'N', '@', '@'}
end

function love.update(dt)
    fills = {}
    glyphs = {}
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            local index = i + j * res
            local noise = love.math.noise( i * noise_scale, j * noise_scale, z )
            fills[index] = noise
            glyphs[index] = density[math.floor( noise * #density)]
        end
    end
    z = z + 0.01
end

function love.draw()
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            index = i + j * res
            x = i * size
            y = j * size
            --love.graphics.setColor(fills[index], 0, 0)
            --love.graphics.rectangle("fill", x, y, size, size)
            if glyphs[index] ~= nil then
                love.graphics.print(glyphs[index], x, y - size * 0.2)
            end
        end
    end
    
end