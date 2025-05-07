require "utils"
player = {}
function player:new(x,y,speed,bullet_img)

    player.x = x
    player.y = y
    player.speed = speed
    player.texture = love.graphics.newImage("resources/playerShip.png")
    player.width = player.texture:getWidth()
    player.height = player.texture:getHeight()
    player.cooldown = false
    player.cooldown_rate = 0
    player.score = 0
    player.health = 10
    player.dead = false
    player.bullet_img = bullet_img
end

function player:update(dt, ast)
    if(player.cooldown_rate >0)then
        player.cooldown_rate = player.cooldown_rate - dt
    end

    if(love.keyboard.isDown("right"))then
        player.x = player.x + player.speed*dt
        print("spawnedS")
    elseif (love.keyboard.isDown("left")) then
        player.x = player.x -player.speed*dt
        print("spawnedS")
    end

    if(love.keyboard.isDown("space") and self.cooldown_rate <=0)then
        bullets:addBullet(player.bullet_img, player.x + player.width/2, player.y, 500)
        player.cooldown_rate = 0.5
        self.cooldown = true
    end

    for i, v in ipairs(ast) do
        if(utils:distance_to(player.x, player.y, v.x,v.y))then
            if(player:checkCollisions(v))then
                player.health = player.health - 1
                health_bar:update(dt, player.health)
                v.dead = true
            end
        end
    end

    if(player.health <= 0)then
        player.dead = true
    end


end

function player:draw()

    love.graphics.draw(player.texture, player.x, player.y)
    
end

function player:checkCollisions(ast)
    local self_top = self.y
    local self_bottom = self.y+self.height
    local self_right = self.x + self.width
    local self_left = self.x

    local ast_top = ast.y
    local ast_bottom = ast.y+ast.height
    local ast_right = ast.x+ast.width
    local ast_left = ast.x

    if self_right > ast_left and self_left < ast_right and self_top < ast_bottom and self_bottom > ast_top then
        return true
    else
        return false
    end
    

end