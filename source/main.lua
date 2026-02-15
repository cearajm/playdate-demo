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

player = Player()
local enemy = Enemy()
local ticksPerRevolution = 1
local revolutionsCount = 0
local crankTicks = 0




local function init()
    showMenu()
    setWalls()
end


-- game state
local gameState = "stopped"

function pd.update()
    gfx.sprite.update()

    -- display title, press A to start the game
    if gameState == "stopped" and pd.buttonJustPressed(pd.kButtonA) then
        gameState = "active"
        hideMenu()
        hideGameOver()
        player = Player()  -- create a new player and enemy each round to reset
        enemy = Enemy()
        player:add()
        enemy:add()

    -- update ammo and score in UI 
    elseif gameState == "active" then
        -- reload by performing four full rotations of the crank
        -- only possible when fully out of ammo
        if player.ammoStock == 0 then
            crankTicks = playdate.getCrankTicks(ticksPerRevolution)
            player.canMove = false
            if crankTicks == 1 then
                    revolutionsCount += 1
            end
        else
            revolutionsCount = 0  -- prevent reloading if not yet out of ammo
        end

        -- reset ammo supply
        if revolutionsCount == 4 then
            player.ammoStock = 3
            player.canMove = true
        end

        -- print(revolutionsCount)

        -- update ammo and player's score on screen 
        gfx.drawTextAligned("score: " .. player.score, 15, 205, kTextAlignment.left)
        gfx.drawTextAligned(player.ammoStock .. "/3", 380, 205, kTextAlignment.right)


        -- if enemy.y > 220 then
        --     print("die")
        -- end
        
        -- end game when the player dies
        if player.isAlive == false then
            gameState = "stopped"
            enemy:remove()
            showGameOver(player.score)
            -- print(gameState)
        end




    end

    
    -- print(gameState)


    -- draw score to screen
    -- top right, text align to keep onscreen
    -- gfx.drawTextAligned("score: " .. score, 390, 10, kTextAlignment.right)

    --  if not sprite, do not pub before draw call



end

init()

