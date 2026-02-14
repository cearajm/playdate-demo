import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

import "assets"
import "sprites"
import "menu"
import "game_ui"

local pd = playdate
local gfx = pd.graphics


-- show test object sprites
local bulletTest = Bullet()

local player = Player()
local ticksPerRevolution = 1
local revolutionsCount = 0
local crankTicks = 0


local function init()

    showMenu()
end





-- game state
local gameState = "stopped"
local score = 0

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



    if pd.buttonJustPressed(pd.kButtonA) then
        gameState = "active"
        hideMenu()
        player:add()
        -- bulletTest:add()
    end

    -- update ammo and score in UI 
    if gameState == "active" then

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
        
    end


    -- draw score to screen
    -- top right, text align to keep onscreen
    -- gfx.drawTextAligned("score: " .. score, 390, 10, kTextAlignment.right)

    --  if not sprite, do not pub before draw call


end

init()

