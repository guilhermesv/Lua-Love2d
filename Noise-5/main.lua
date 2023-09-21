
function noise_grid_generate(size, res, noise_scale)
    local grid = {}
    local size = 500 / res
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
            cell['x'] = i * size
            cell['y'] = j * size
            cell['size'] = size
            grid[index] = cell
        end
    end
    z = z + 0.01
    return grid
end

function love.load()
    love.window.setTitle( "Olá Mundinho" )
    z = 0
end

function love.update(dt)
    grid_A = noise_grid_generate(500, 25, 0.1)
    grid_B = noise_grid_generate(500, 10, 0.1)
    grid_C = noise_grid_generate(500, 4, 0.5)
end

function love.draw()

    love.graphics.setBlendMode('alpha')
    for i = 0, #grid_A, 1 do
        love.graphics.setColor(grid_A[i].background)
        love.graphics.rectangle("fill", grid_A[i].x, grid_A[i].y, grid_A[i].size,grid_A[i].size)
    end
    
    love.graphics.setBlendMode('screen')
    for i = 0, #grid_B, 1 do
        love.graphics.setColor(grid_B[i].foreground)
        local r = grid_B[i].size / 2
        love.graphics.ellipse("fill", grid_B[i].x + r, grid_B[i].y + r, r, r)
    end

    for i = 0, #grid_C, 1 do
        love.graphics.setColor(grid_C[i].background)
        local r = grid_C[i].size / 2
        love.graphics.ellipse("fill", grid_C[i].x + r, grid_C[i].y + r, r, r)
    end
    
end