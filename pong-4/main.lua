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
 
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280
--  contants
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--  constant paddle_speed 
PADDLE_SPEED = 200

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

    
    -- new: settear numeros random
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

    -- initialize score variables, used for rendering on the screen and keeping
    -- track of the winner
    player1Score = 0
    player2Score = 0

    -- paddle positions on the Y axis (they can only move up or down)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    -- new: ball positio
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- new:  math.random returns a random value between the left and right number
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- new: we will use this to determine behavior during render and update
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

            -- start ball's position in the middle of the screen
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
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
        -- add negative paddle speed to curren Y scaled by delta time
        -- Less Y, it moves up
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- add positite paddle speed  to current Y scaled by delta time
        -- More Y, it moves down
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end


-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    --begin rendering at virtual resolution
    push:apply('start')

    -- new clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original Pong
    love.graphics.clear(51/255, 14/255, 80/255, 0.8)

    -- new render a rectangle first paddle(left side), now using player1Y
    love.graphics.rectangle('line', 10, player1Y, 5, 25)

    -- new render a rectangel second right side, now using payer2Y
    love.graphics.rectangle('line', VIRTUAL_WIDTH - 10, player2Y , 5, 25)

    -- new render ball
    love.graphics.rectangle('fill', ballX, ballY , 5, 5)
    -- chance virtual hegiht to move text to the top
    
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
    


    --  end rendering at virtual resolution
    push:apply('end')

end