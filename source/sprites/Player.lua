local pd <const> = playdate
local gfx <const> = pd.graphics

-- create gfx image from bullet image data
local imagePlayer <const> = gfx.image.new(assets.player)
class("Player").extends(gfx.sprite)

-- attributes
local playerStartX = 100
local playerStartY = 120
local playerSpeed = 3

function Player:init()
    -- new Player object with gfx bullet image
    Player.super.init(self, imagePlayer)


    self:setZIndex(1)
    self:setCollideRect(4, 4, 56, 40)
    self:moveTo(playerStartX, playerStartY)


end

function Player:update()
    -- update every frame
    Player.super.update(self)


    -- d-pad move controls
    if pd.buttonIsPressed(pd.kButtonUp) then
        self:moveBy(0, -playerSpeed)
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        self:moveBy(0, playerSpeed)
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self:moveBy(-playerSpeed, 0)
    end
    if pd.buttonIsPressed(pd.kButtonRight) then
        self:moveBy(playerSpeed, 0)
    end
end
