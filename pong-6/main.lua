-- Comments
--[[ Multiline
commens ]]
 

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
--  require
push = require 'push' 
 
-- new Requrie Class to make classes easier
-- require Padle and ball
Class = require 'class' 
require 'Paddle'
require 'Ball'


WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--  constant paddle_speed  
PADDLE_SPEED = 150

-- love.load runs when the game first starts, only once
-- used to initialize 

function love.load()
    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })

    --  add a filter to the letters and images
    -- instead of bilinear(default) this 'nearest'
    -- makes images more like bit like older games


    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title for our app
    love.window.setTitle('Pong-CCHE')

    --  settear numeros random con hora del sistema
    math.randomseed(os.time())


    --  more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    --  score font
    scoreFont = love.graphics.newFont('font.ttf', 32)

    --  set LÖVE2D's active font to the smallFont obect
    love.graphics.setFont(smallFont)

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize players paddles
    player1 = Paddle(10,30, 5, 25)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 35, 5, 25)

    -- initialize ball
    ball = Ball(VIRTUAL_WIDTH /2 -2 , VIRTUAL_HEIGHT /2 - 2, 5, 5)

    gameState = 'start'
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
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then 
            gameState = 'play'
        else
            gameState = 'start'

            -- Reset ball position
            ball:reset()
        end
    end
end



--[[new:
     Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else 
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else 
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end


-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    --begin rendering at virtual resolution
    push:apply('start')

    --set background color
    love.graphics.clear(51/255, 14/255, 80/255, 0.8)
 

    -- render paddles
    player1:render()
    player2:render()

    -- render ball
    ball:render() --using class and method of class


    love.graphics.setFont(smallFont)
    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end


    -- SCORE
    -- -- set scoreFont
    -- love.graphics.setFont(scoreFont)
    -- love.graphics.print(  tostring(player1Score), VIRTUAL_WIDTH/2 - 50, VIRTUAL_HEIGHT / 3  )
    -- love.graphics.print(  tostring(player2Score), VIRTUAL_WIDTH/2 + 30, VIRTUAL_HEIGHT / 3  )
    
    -- new function to see how fps works
    displayFPS()

    --  end rendering at virtual resolution
    push:apply('end')

end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(238/255, 130/255, 238/255, 0.9)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end