local gfx <const> = playdate.graphics




-- create gfx image from bullet image data
local imageBullet <const> = gfx.image.new(assets.bullet)
class("Bullet").extends(gfx.sprite)  -- subclass



function Bullet:init()
    -- new Bullet object with gfx bullet image
    Bullet.super.init(self, imageBullet)

    self.velocityX = 0
    self.velocityY = 0

    self:setZIndex(5)
    self:setCollideRect(0, 0, 25, 25)
    
    self.player = Player.instance

end


function Bullet:collisionResponse(other)
    -- sets ?
    -- collision type with every other sprite
    return gfx.sprite.kCollisionTypeOverlap
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
    -- when using moveWithCollisions, add to self x and y
    local _, _, collisions = self:moveWithCollisions(self.x + self.velocityX, self.y + self.velocityY)

    -- idk how this works. go back and learn this
    for _, collision in pairs(collisions) do
        local other = collision.other

        -- print("collided with: ")
        -- print(other)

        -- hit enemy and remove it, then create a new one
        if getmetatable(other).class == Enemy then
            other:destroy()
            self:remove()
            self.player:updateScore()
            local enemy = Enemy()
            enemy:add()
        end
    end

end
