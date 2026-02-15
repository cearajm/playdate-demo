import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

import "assets"
import "sprites"
import "menu"

local pd <const> = playdate
local gfx <const> = pd.graphics




-- declare entities/values
local player = Player()
local enemy = Enemy()

local ticksPerRevolution = 1
local revolutionsCount = 0
local crankTicks = 0

-- game state
local gameState = "stopped"

local sfx_start = pd.sound.sampleplayer.new(audio.start)
local sfx_reload = pd.sound.sampleplayer.new(audio.reload)



local function init()
    showMenu()
    setWalls()
end


function pd.update()
    gfx.sprite.update()

    -- display title, press A to start the game
    if gameState == "stopped" and pd.buttonJustPressed(pd.kButtonA) then
        hideMenu()
        hideGameOver()
        gameState = "active"
        sfx_start:play()

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
            sfx_reload:play()
        end

        -- print(revolutionsCount)

        -- update ammo and player's score on screen 
        gfx.drawTextAligned("score: " .. player.score, 15, 205, kTextAlignment.left)
        gfx.drawTextAligned(player.ammoStock .. "/3", 380, 205, kTextAlignment.right)


        -- end game when the player dies
        if player.isAlive == false then
            gameState = "stopped"
            enemy:remove()
            showGameOver(player.score)
            -- print(gameState)
        end
    end


end


init()

