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
    -- constructor: new Player object with gfx bullet image
    Player.super.init(self, imagePlayer)

    -- set reference to player
    Player.instance = self

    self.ammoStock = 3
    self.score = 4
    self.isAlive = true

    self:setScale(2)
    self:setZIndex(1)
    self:setCollideRect(4, 4, 45, 50)
    -- self.collisionResponse = gfx.sprite.kCollisionTypeFreeze

    -- self:setCollidesWithGroups(2)

    self:moveTo(playerStartX, playerStartY)

    self:setTag(1)

end

function Player:collisionResponse(other)
    if getmetatable(other).class == Wall then
        return gfx.sprite.kCollisionTypeFreeze
    else
        return gfx.sprite.kCollisionTypeOverlap

    end
end

function Player:destroy()
    self.isAlive = false
    self:remove()
end



function Player:updateScore()
    self.score += 1
end


function Player:update()
    -- update every frame
    Player.super.update(self)


    -- d-pad movement controls
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

    -- spawning bullet

    -- spawn bullet at player's position
    -- three bullet limit, before you need to recharge/reload (crank)
    local isBButtonPressed = pd.buttonJustPressed(pd.kButtonB)
    if isBButtonPressed then
        if self.ammoStock > 0 then
            local bullet = Bullet()
            bullet:spawn(self.x, self.y, 0, -5)
            bullet:add()
            self.ammoStock -= 1
        -- else
        --     self.ammoStock = 3
        end
        print(self.ammoStock)
    end

        local _, _, collisions = self:moveWithCollisions(self.x, self.y)

    for _, collision in pairs(collisions) do
        local other = collision.other
        
        -- if getmetatable(other).class == Wall then
        --     self:collisionResponse(other)
        
        -- end
    end

    -- update ammo stock and score in UI

end
