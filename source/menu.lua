local pd <const> = playdate
local gfx <const> = pd.graphics

--[[ 
This handles the start and game over screens.
Does not handle the score or ammo stock displays. those are in the player class. cus i just dumped it all in there
]]



gfx.setFontFamily(gfx.getFont(gfx.font.kVariantBold))

local spriteTitle = gfx.sprite.new()
local spriteButton = gfx.sprite.spriteWithText("press A to start", 400, 240)

-- create title as an image
local imageSpriteTitle = gfx.image.new(200, 120)

-- draw text on the image (centered)
-- push: save imageSpriteTitle as the current image to draw to, with draw functions
gfx.pushContext(imageSpriteTitle)
gfx.drawTextAligned("pancake 2: vengeance", 100, 60, kTextAlignment.center)
gfx.popContext()  -- release image

 -- scale into a separate image and move
spriteTitle:setImage(imageSpriteTitle:scaledImage(1.6))
spriteTitle:moveTo(200, 80)
spriteButton:moveTo(200, 150)



-- game over messages
local spriteLoser = gfx.sprite.spriteWithText("oh... bested by a stoat ...", 400, 240)
local spriteRetry = gfx.sprite.spriteWithText("press A to try again!", 400, 240)
local spriteFinalScore = nil
spriteLoser:moveTo(200, 120)
spriteRetry:moveTo(200, 160)


-- display/hide functions
-- global though. don't do that later
function showMenu()
    -- add to screen
    spriteTitle:add()
    spriteButton:add()
end

function hideMenu()
    spriteTitle:remove()
    spriteButton:remove()
end

function showGameOver(score)
    spriteFinalScore = gfx.sprite.spriteWithText("score: " .. score, 400, 240)
    spriteFinalScore:setScale(2)
    spriteFinalScore:moveTo(200, 85)
    spriteFinalScore:add()
    spriteLoser:add()
    spriteRetry:add()
end

function hideGameOver()
    if spriteFinalScore ~= nil then
        spriteFinalScore:remove()
    end
    spriteLoser:remove()
    spriteRetry:remove()
end

