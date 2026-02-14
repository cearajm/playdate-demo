local gfx <const> = playdate.graphics

-- local consts

-- create gfx image from bullet image data
local imageBullet <const> = gfx.image.new(assets.bullet)
class("Bullet").extends(gfx.sprite)  -- subclass


function Bullet:init()
    -- new Bullet object with gfx bullet image
    Bullet.super.init(self, imageBullet)

    self.velocityX = 0
    self.velocityY = 0

    self.collisionResponse = gfx.sprite.kCollisionTypeOverlap  -- prevent shifting on collision
    self:setZIndex(5)
    self:setCollideRect(0, 0, 48, 48)
    self:moveTo(200, 120)
    

end

function Bullet:spawn(posX, posY, velX, velY)
    -- params: players location
    -- add when player spaws a bullet
    self:add()
    self:moveTo(posX, posY)
    self.velocityX = velX
    self.velocityY = velY

end


function Bullet:update()
    -- update position based on velocity
    self:moveBy(self.velocityX, self.velocityY)

end
