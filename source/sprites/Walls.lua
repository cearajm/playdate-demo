local pd <const> = playdate
local gfx <const> = pd.graphics

-- class ("Walls").extends(gfx.sprite)
-- local spriteWall <const> = gfx.sprite.new()

-- function Walls:init()

--         Walls.


-- local wallTop <const> = gfx.sprite.new()
local wall <const> = gfx.sprite.new()
-- local wallLeft <const> = gfx.sprite.new()
-- local wallRight<const> = gfx.sprite.new()
-- local wallBottom <const> = gfx.sprite.new()
-- local wallTop <const> = gfx.image.new(assets.player)
-- local wallTop <const> = gfx.image.new(assets.player)
-- local wallTop <const> = gfx.image.new(assets.player)
class("Wall").extends(gfx.sprite)

function Wall:init(size)

    Wall.super.init(self, wall)

    -- self:setCollideRect(4, 4, 45, 50)
    -- self:setSize(size)
    -- self:setCollideRect(0, 0, self:getSize())
    -- self:moveTo(200, 100)
end

function Wall:collisionResponse(other)
    return gfx.sprite.kCollisionTypeFreeze
end

function Wall:setWall()
    self:add()
end

function setWalls()
    local wallTop = Wall()
    local wallBottom = Wall()
    local wallLeft = Wall()
    local wallRight = Wall()
    
    wallTop:setCollideRect(0, 0, 400, 20)
    wallTop:moveTo(0, 0)
    wallTop:add()
    
    wallBottom:setCollideRect(0, 0, 400, 20)
    wallBottom:moveTo(0, 220)
    wallBottom:add()


    wallLeft:setCollideRect(0, 0, 20, 240)
    wallLeft:moveTo(0, 0)
    wallLeft:add()


    wallRight:setCollideRect(0, 0, 20, 240)
    wallRight:moveTo(380, 0)
    wallRight:add()

end

function Wall:update()

    local _, _, collisions = self:checkCollisions(self.x, self.y)

    for _, collision in pairs(collisions) do
        local other = collision.other
        local collisionTag = other:getTag()

        if collisionTag == 1 then
            print("collided")
            self.collisionResponse = gfx.sprite.kCollisionTypeFreeze
        
        end
    end
end
