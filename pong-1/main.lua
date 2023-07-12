-- Comments
--[[ Multiline
commens ]]


-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
-- new require
push = require 'push'


WINDOW_HEIGHT = 680
WINDOW_WIDTH = 1020
-- new contants
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- love.load runs when the game first starts, only once
-- used to initialize 

function love.load()
    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })

    -- new
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

--[[ all functionm is new
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
         -- function LÖVE gives us to terminate application
        love.event.quit()
    end
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    --new: begin rendering at virtual resolution
    push:apply('start')

    -- chance window_height and with for the new virtual value
    love.graphics.printf(
        'Hello World cche!!! :)',
        0,
        VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 
        'center'
    )

    -- new: end rendering at virtual resolution
    push:apply('end')

end