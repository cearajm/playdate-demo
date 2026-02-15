local pd <const> = playdate
local gfx <const> = pd.graphics



-- create gfx image from enemy image data
local imageEnemy <const> = gfx.image.new(assets.enemy)
class("Enemy").extends(gfx.sprite)

local sfx_hit_enemy = pd.sound.sampleplayer.new(audio.hit_enemy)


function Enemy:init()
    -- construct enemy
    Enemy.super.init(self, imageEnemy)

    self.velocityX = 0
    self.velocityY = 1.5
    self.spawnX = math.random(50, 350)  -- spawn from top, with randomized x


    self:setScale(2)
    local w, h = self:getSize()

    self:setCollideRect(4, 4, w - 6, h - 4)
    self:moveTo(self.spawnX, -50)
end


function Enemy:collisionResponse(other)
    return gfx.sprite.kCollisionTypeOverlap
end


function Enemy:destroy()
    sfx_hit_enemy:play()
    self:remove()
end

function Enemy:update()
    self.player = Player.instance

    -- get top left coordinates and end the game if the enemy leaves the screen
    local w, h = self:getSize()
    if  (self.y - (h/2)) > 240 then
        self.player:destroy()
        self:remove()
    end

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