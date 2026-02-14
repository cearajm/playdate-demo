local pd <const> = playdate
local gfx <const> = pd.graphics

-- create gfx image from enemy image data
local imageEnemy <const> = gfx.image.new(assets.enemy)
class("Enemy").extends(gfx.sprite)

function Enemy:init()
    -- construct enemy
    Enemy.super.init(self, imageEnemy)

    self.velocityX = 0
    self.velocityY = 0

    self:setCollideRect(4, 4, 56, 40)
    self:moveTo(200, 120)

end


function Enemy:collisionResponse(other)
    return gfx.sprite.kCollisionTypeOverlap
end



function Enemy:destroy()
    self:remove()
end

function Enemy:update()
    -- get the player
    -- local player = Player.instance

    local _, _, collisions = self:moveWithCollisions(self.x + self.velocityX, self.y + self.velocityY)

    -- kill player upon collision
    for _, collision in pairs(collisions) do
        local other = collision.other
        if getmetatable(other).class == Player then
            self:remove()
            other:destroy()
        end
    end

end