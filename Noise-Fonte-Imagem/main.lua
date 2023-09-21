function love.load()
    love.window.setTitle( "Olá Mundinho" )
    res = 28
    size = 560 / res
    noise_scale = 0.05
    z = 0
    font = love.graphics.newImageFont("fonte.png", "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&*#=[]")
    density = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', '!', '?', '-', '+', '/', '(', ')', ':', ';', '%', '&', '*', '#', '=', '[', ']' }
    -- font = love.graphics.newImageFont('fonte.png', 'ẘẙàÀáÁâÂÃãäÄåÅæÆçÇÈéÉêÊëËìÌíîÎïÏðÐñÑòÒóÓôÔõÕöÖØùÙúÚûÛüÜÝýþÞßāĀăĂĄąćĆĉĈĊċČčĎďđĐēĒĕĔĖėęĘěĚĝĜġĠģĢĥĤħĦĩĨīĪĬĭįĮİiIĵĴĶķĸĺĹĻļľĽLlŁńŅņŇōŌŏŎőŐŒŔŖŗřŘŝŜşŞ1234567')
    -- density = {'ẘ', 'ẙ', 'à', 'À', 'á', 'Á', 'â', 'Â', 'Ã', 'ã', 'ä', 'Ä', 'å', 'Å', 'æ', 'Æ', 'ç', 'Ç', 'È', 'é', 'É', 'ê', 'Ê', 'ë', 'Ë', 'ì', 'Ì', 'í', 'î', 'Î', 'ï', 'Ï', 'ð', 'Ð', 'ñ', 'Ñ', 'ò', 'Ò', 'ó', 'Ó', 'ô', 'Ô', 'õ', 'Õ', 'ö', 'Ö', 'Ø', 'ù', 'Ù', 'ú', 'Ú', 'û', 'Û', 'ü', 'Ü', 'Ý', 'ý', 'þ', 'Þ', 'ß', 'ā', 'Ā', 'ă', 'Ă', 'Ą', 'ą', 'ć', 'Ć', 'ĉ', 'Ĉ', 'Ċ', 'ċ', 'Č', 'č', 'Ď', 'ď', 'đ', 'Đ', 'ē', 'Ē', 'ĕ', 'Ĕ', 'Ė', 'ė', 'ę', 'Ę', 'ě', 'Ě', 'ĝ', 'Ĝ', 'ġ', 'Ġ', 'ģ', 'Ģ', 'ĥ', 'Ĥ', 'ħ', 'Ħ', 'ĩ', 'Ĩ', 'ī', 'Ī', 'Ĭ', 'ĭ', 'į', 'Į', 'İ', 'i', 'I', 'ĵ', 'Ĵ', 'Ķ', 'ķ', 'ĸ', 'ĺ', 'Ĺ', 'Ļ', 'ļ', 'ľ', 'Ľ', 'L', 'l', 'Ł', 'ń', 'Ņ', 'ņ', 'Ň', 'ō', 'Ō', 'ŏ', 'Ŏ', 'ő', 'Ő', 'Œ', 'Ŕ', 'Ŗ', 'ŗ', 'ř', 'Ř', 'ŝ', 'Ŝ', 'ş', 'Ş', '1', '2', '3', '4', '5', '6', '7'}
    love.graphics.setFont(font)
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

    -- for i = 0, #grid, 1 do
    --     love.graphics.setColor(grid[i].background)
    --     love.graphics.rectangle("fill", grid[i].x, grid[i].y, size, size)
    -- end

    for i = 0, #grid, 1 do
        -- love.graphics.setColor(grid[i].foreground)
        if grid[i].glyphs ~= nil then
            love.graphics.print(grid[i].glyphs, grid[i].x, grid[i].y - size * 0.2)
        end 
    end
    
end