require "utils"
bullets = {}

function bullets:addBullet(texture,x,y, speed)
    local bullet = {}
    bullet.x = x
    bullet.y = y
    bullet.texture = texture
    bullet.width = bullet.texture:getWidth()
    bullet.height = bullet.texture:getHeight()
    bullet.dead = false
    bullet.speed = speed

    function bullet:update(dt)
        self.y = self.y-self.speed*dt
        --collectgarbage("stop")
        --collectgarbage("collect")
        --collectgarbage("restart")
        if(self.y+self.height < 0)then
            self.dead = true
        end
        
        
    end

    function bullet:draw()
        love.graphics.draw(self.texture, self.x, self.y)
    end

    table.insert(bullets, bullet)
end

function bullets:update(dt)
    for i, v in ipairs(bullets) do
        v:update(dt)
        if(v.dead)then
            table.remove(bullets, i)
            --collectgarbage("collect")
        end
    end
    
end


function bullets:draw()
    for _,v in ipairs(bullets)do
        v:draw()
    end
end
