function love.load()
    love.window.setTitle( "Olá Mundinho" )
    fatias = gerar_fatias(love.graphics.newImage('img.png'), 40, 40)
    window_width, window_height = 800, 800
    z = 0
end

function love.update(dt)
    grid_A = noise_grid_generate(window_width, 40, 0.05, #fatias.quads)
    grid_B = noise_grid_generate(window_width, 20, 0.05, #fatias.quads)
    grid_C = noise_grid_generate(window_width, 10, 0.05, #fatias.quads)
end

function love.draw()

    love.graphics.setBlendMode('alpha')
    local scale = (window_width / grid_A.res) / 40
    for i = 0, #grid_A, 1 do
        -- love.graphics.setColor(grid_A[i].background)
        -- love.graphics.rectangle("fill", grid_A[i].x, grid_A[i].y, grid_A[i].size,grid_A[i].size)

        love.graphics.draw(fatias.imagem, fatias.quads[grid_A[i].quad_index], grid_A[i].x, grid_A[i].y, 0, scale)
    end
    
    -- love.graphics.setBlendMode('screen')
    scale = (window_width / grid_B.res) / 40
    for i = 0, #grid_B, 1 do
        if grid_B[i].value > 0.4 then
            love.graphics.draw(fatias.imagem, fatias.quads[grid_B[i].quad_index], grid_B[i].x, grid_B[i].y, 0, scale)
        end
    end

    scale = (window_width / grid_C.res) / 40
    for i = 0, #grid_C, 1 do
        if grid_C[i].value > 0.6 then
            love.graphics.draw(fatias.imagem, fatias.quads[grid_C[i].quad_index], grid_C[i].x, grid_C[i].y, 0, scale)
        end
    end 
end

function gerar_fatias(imagem, quadro_largura, quadro_altura)
    local fatias = {}
    fatias.imagem = imagem;
    fatias.quads = {}

    for y = 0, imagem:getHeight() - quadro_altura, quadro_altura do
        for x = 0, imagem:getWidth() - quadro_largura, quadro_largura do
            table.insert(fatias.quads, love.graphics.newQuad(x, y, quadro_largura, quadro_altura, imagem:getDimensions()))
        end
    end

    return fatias
end

function noise_grid_generate(size, res, noise_scale, quads_qtd)
    local grid = {}
    grid.res = res
    local size = size / res
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            local cell = {}           
            local index = i + j * res
            cell.value = love.math.noise( i * noise_scale, j * noise_scale, z )
            cell.quad_index = math.floor(cell.value * quads_qtd)
            cell.background = {1, 0, 0, 1}
            cell.foreground = {0, 1, 0, 1}
            if cell.value > 0.3 then
                cell.background = {0, 1, 0, 1}
                cell.foreground = {0, 0, 1, 1}
            end
            if cell.value > 0.6 then
                cell.background = {0, 0, 1, 1}
                cell.foreground = {1, 0, 0, 1}
            end
            cell.x = i * size
            cell.y = j * size
            cell.size = size
            grid[index] = cell
        end
    end
    z = z + 0.005
    return grid
end