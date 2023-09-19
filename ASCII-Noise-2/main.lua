function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 40
    size = 500 / res
    noise_scale = 0.1
    z = 0
    density = {' ', ' ', ' ', '.', ':', '+', '=', '#', '#', 'N', 'N', '@', '@'}
end

function love.update(dt)
    grid = {}
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            local cell = {}           
            local index = i + j * res
            cell['noise'] = love.math.noise( i * noise_scale, j * noise_scale, z )
            cell['glyphs'] = density[math.floor( cell['noise'] * #density)]
            cell['x'] = i * size
            cell['y'] = j * size
            grid[index] = cell
        end
    end
    z = z + 0.01
end

function love.draw()
    
    for i = 0, #grid, 1 do
        
        love.graphics.print(grid[i], grid[i].x, grid[i].y - size * 0.2)
    end
    
end