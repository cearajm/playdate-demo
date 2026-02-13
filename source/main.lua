

import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

-- player

local playerStartX = 40
local playerStartY = 120
local playerSpeed = 3
local playerImage = playdate.graphics.image.new("images/capybara")  -- object
local playerSprite = gfx.sprite.new(playerImage)
playerSprite:setCollideRect(4, 4, 56, 40)
playerSprite:moveTo(playerStartX, playerStartY)
playerSprite:add()


-- game state
local gameState = "stopped"
local score = 0

-- obstacle
-- get image --> turn into sprite --> set collider dimensions
-- place at coords --> add to drawing list
local obstacleSpeed = 5
local obstacleImage = gfx.image.new("images/rock")
local obstacleSprite = gfx.sprite.new(obstacleImage)
obstacleSprite.collisionResponse = gfx.sprite.kCollisionTypeOverlap  -- prevent shifting on collision
obstacleSprite:setCollideRect(0, 0, 48, 48)
obstacleSprite:moveTo(450, 240)  -- offscreen
obstacleSprite:add()

function pd.update()
    gfx.sprite.update()
    
    -- ** movement **
    if gameState == "stopped" then
        gfx.drawTextAligned("press A to start", 200, 40, kTextAlignment.center)
        if pd.buttonJustPressed(pd.kButtonA) then
            gameState = "active"
            score = 0
            obstacleSpeed = 5  -- reset speed
            playerSprite:moveTo(playerStartX, playerStartY)
            obstacleSprite:moveTo(450, math.random(40, 200))
        end
    elseif gameState == "active" then
        local crankPosition = pd.getCrankPosition()  -- crank pos -> angle 0-359
        if crankPosition <= 90 or crankPosition >= 270 then  -- upper half: up
            playerSprite:moveBy(0, -playerSpeed)
        else
            playerSprite:moveBy(0, playerSpeed)  -- lower half: down
        end

        -- move obstacles left
        -- collisions = collision data list; length = len of list
        local actualX, actualY, collisions, length = obstacleSprite:moveWithCollisions(obstacleSprite.x - obstacleSpeed, obstacleSprite.y)
        if obstacleSprite.x < -20 then
            obstacleSprite:moveTo(450, math.random(40, 200))
            score += 1  -- one point per obstacle
            obstacleSpeed += 0.2
        end

        if length > 0 or playerSprite.y > 270 or playerSprite.y < -30 then
            gameState = "stopped"
        end
    end

    -- draw score to screen
    -- top right, text align to keep onscreen
    gfx.drawTextAligned("score: " .. score, 390, 10, kTextAlignment.right)

    --  if not sprite, do not pub before draw call

end

