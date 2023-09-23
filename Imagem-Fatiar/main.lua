-- https://love2d.org/wiki/Tutorial:Animation

function love.load()
    love.window.setTitle( "Olá Mundinho" )
    fatias = gerar_fatias(love.graphics.newImage('img.png'), 40, 40) 
end

function love.update(dt)

end

function love.draw()
    -- https://love2d.org/wiki/love.graphics.draw
    love.graphics.draw(fatias.imagem, fatias.quads[1], 0, 0, 0, 1)
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