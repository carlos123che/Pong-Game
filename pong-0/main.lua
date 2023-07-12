-- Comments
--[[ Multiline
commens ]]


WINDOW_HEIGHT = 680
WINDOW_WIDTH = 1020


-- love.load runs when the game first starts, only once
-- used to initialize

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    love.graphics.printf(
        'Hello World cche!!! :)',
        0,
        WINDOW_HEIGHT / 2,
        WINDOW_WIDTH,
        'center'
    )
end