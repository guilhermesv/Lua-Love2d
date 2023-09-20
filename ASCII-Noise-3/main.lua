-- https://love2d.org/wiki/HSL_color
function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h*6, s, l
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return r+m, g+m, b+m, a
end


function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 25
    size = 500 / res
    noise_scale = 0.1
    z = 0
    density = {' ', ' ', ' ', '.', ':', '+', '=', '#', '#', 'N', 'N', '@', '@'}
    start = 0
    limit = res * 10
end

function love.update(dt)
    grid = {}
    for j = 0, res, 1 do
        for i = 0, res, 1 do
            local cell = {}           
            local index = i + j * res
            cell['value'] = love.math.noise( i * noise_scale, j * noise_scale, z )
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
        love.graphics.setColor(HSL(grid[i].value, 1, .6, 1))
        love.graphics.rectangle("fill", grid[i].x, grid[i].y, size, size)
    end

    for i = start, start + limit, 1 do
        love.graphics.setColor(0, 0, 0)      
        love.graphics.print(grid[i].glyphs, grid[i].x, grid[i].y - size * 0.2)
    end
    
end