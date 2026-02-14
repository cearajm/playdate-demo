import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "assets"
import "sprites"
import "menu"

local pd = playdate
local gfx = pd.graphics


-- show test object sprites
local bulletTest = Bullet()

local player = Player()


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
        hideMenu()
        player:add()
        bulletTest:add()
    end


    -- draw score to screen
    -- top right, text align to keep onscreen
    gfx.drawTextAligned("score: " .. score, 390, 10, kTextAlignment.right)

    --  if not sprite, do not pub before draw call

end

init()

