-- https://love2d.org/forums/viewtopic.php?t=9395

function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 25
    size = 500 / res
    noise_scale = 0.1
    z = 0
    density = {'.', '.', '.', ':', '+', '=', '#', '#', 'N', 'N', '@', '@'}
    start = 0
    limit = res * 10
    font = love.graphics.newFont(20)
    love.graphics.setFont(font)
end

function love.update(dt)
    grid = {}
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            local cell = {}           
            local index = i + j * res
            cell['value'] = love.math.noise( i * noise_scale, j * noise_scale, z )
            cell['background'] = {1, 0, 0, 1}
            cell['foreground'] = {0, 1, 0, 1}
            if cell.value > 0.3 then
                cell['background'] = {0, 1, 0, 1}
                cell['foreground'] = {0, 0, 1, 1}
            end
            if cell.value > 0.6 then
                cell['background'] = {0, 0, 1, 1}
                cell['foreground'] = {1, 0, 0, 1}
            end
            cell['glyphs'] = density[math.floor( cell.value * #density)]
            cell['x'] = i * size
            cell['y'] = j * size
            grid[index] = cell
        end
    end
    z = z + 0.01
    start = start + 2
    if start >= #grid - limit then
        start = 0
    end
end

function love.draw()

    for i = 0, #grid, 1 do
        love.graphics.setColor(grid[i].background)
        love.graphics.rectangle("fill", grid[i].x, grid[i].y, size, size)
    end

    for i = 0, #grid, 1 do
        love.graphics.setColor(grid[i].foreground)
        if grid[i].glyphs ~= nil then
            love.graphics.print(grid[i].glyphs, grid[i].x, grid[i].y - size * 0.2)
        end 
    end
    
end