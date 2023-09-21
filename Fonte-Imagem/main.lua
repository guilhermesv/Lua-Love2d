

function love.load()
    love.window.setTitle( "Olá Mundinho" )

    font = love.graphics.newImageFont("fonte.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
    love.graphics.setFont(font)
end

function love.update(dt)

end

function love.draw()
    love.graphics.print("This is some awesome text", 0, 0)
end