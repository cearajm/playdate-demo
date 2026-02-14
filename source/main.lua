import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

import "assets"
import "sprites"
import "menu"

local pd = playdate
local gfx = pd.graphics


-- show test object sprites
local bulletTest = Bullet()

-- local player = Player()
local ticksPerRevolution = 1
local revolutionsCount = 0
local crankTicks = 0


local enemy = Enemy()
-- enemy:moveTo(200, 120)
-- enemy:add()


local function init()


    showMenu()



end





-- game state
local gameState = "stopped"

local score = 0
local player = nil

-- obstacle
-- get image --> turn into sprite --> set collider dimensions
-- place at coords --> add to drawing list
-- local obstacleSpeed = 5
-- local obstacleImage = gfx.image.new("images/rock")
-- local obstacleSprite = gfx.sprite.new(obstacleImage)
-- obstacleSprite.collisionResponse = gfx.sprite.kCollisionTypeOverlap  -- prevent shifting on collision
-- obstacleSprite:setZIndex(5)
-- obstacleSprite:setCollideRect(0, 0, 48, 48)
-- obstacleSprite:moveTo(300, 110)  -- offscreen
-- obstacleSprite:add()

function pd.update()
    gfx.sprite.update()


    
    if gameState == "stopped" and pd.buttonJustPressed(pd.kButtonA) then
        gameState = "active"
        hideMenu()
        hideGameOver()
        player = Player()  -- create a new player each round to reset stats
        player:add()
        enemy:add()
        -- bulletTest:add()
    -- end

    -- update ammo and score in UI 
    elseif gameState == "active" then

        -- reload by performing four full rotations of the crank
        -- only possible when fully out of ammo
        if player.ammoStock == 0 then
            crankTicks = playdate.getCrankTicks(ticksPerRevolution)
            if crankTicks == 1 then
                    revolutionsCount += 1
            end
        else
            revolutionsCount = 0
        end

        -- reset ammo supply
        if revolutionsCount == 4 then
            player.ammoStock = 3
        end

        -- print(revolutionsCount)

        -- update ammo and player's score on screen 
        gfx.drawTextAligned("score: " .. player.score, 15, 205, kTextAlignment.left)
        gfx.drawTextAligned(player.ammoStock .. "/3", 380, 205, kTextAlignment.right)

        
        -- end game when the player dies
        if player.isAlive == false then
            gameState = "stopped"
            showGameOver(player.score)
            print(gameState)
        end




    end

    
    print(gameState)


    -- draw score to screen
    -- top right, text align to keep onscreen
    -- gfx.drawTextAligned("score: " .. score, 390, 10, kTextAlignment.right)

    --  if not sprite, do not pub before draw call



end

init()

