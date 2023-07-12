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


WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280
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

    -- new: add a filter to the letters and images
    -- instead of bilinear(default) this 'nearest'
    -- makes images more like bit like older games

    love.graphics.setDefaultFilter('nearest', 'nearest')

     --new  more "retro-looking" font object we can use for any text
     smallFont = love.graphics.newFont('font.ttf', 8)

     -- new set LÖVE2D's active font to the smallFont obect
     love.graphics.setFont(smallFont)

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

--[[
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
    --begin rendering at virtual resolution
    push:apply('start')

    -- new clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original Pong
    love.graphics.clear(51/255, 14/255, 80/255, 0.8)

    -- new render a rectangle first paddle(left side)
    love.graphics.rectangle('line', 10, 35, 5, 25)

    -- new render a rectangel second right side
    love.graphics.rectangle('line', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 25)

    -- new render ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH /2 - 2, VIRTUAL_HEIGHT / 2 - 4 , 5, 5)
    -- chance virtual hegiht to move text to the top
    love.graphics.printf(
        'Hello World cche!!! :)',
        0,
        20,
        VIRTUAL_WIDTH, 
        'center'
    )

    --  end rendering at virtual resolution
    push:apply('end')

end