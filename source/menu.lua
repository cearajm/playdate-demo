local pd <const> = playdate
local gfx <const> = pd.graphics

local spriteTitle = gfx.sprite.new()
local spriteButton = gfx.sprite.spriteWithText("ok press A to start", 400, 240)

gfx.setFontFamily(gfx.getFont(gfx.font.kVariantBold))

-- create title as an image
local imageSpriteTitle = gfx.image.new(200, 120)

-- draw text on the image (centered)
-- push: save imageSpriteTitle as the current image to draw to, with draw functions
gfx.pushContext(imageSpriteTitle)
gfx.drawTextAligned("cool game", 100, 60, kTextAlignment.center)
gfx.popContext()  -- release image


spriteTitle:setImage(imageSpriteTitle:scaledImage(2)) -- scale into a separate image

-- coordinate position
spriteTitle:moveTo(200, 100)
spriteButton:moveTo(200, 170)


-- game over messages
local spriteLoser = gfx.sprite.spriteWithText("oh... you failed ...", 400, 240)
local spriteRetry = gfx.sprite.spriteWithText("press A to try again!", 400, 240)
local spriteFinalScore = nil
spriteLoser:moveTo(200, 115)
spriteRetry:moveTo(200, 150)


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
    spriteFinalScore:setScale(1.5)
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

