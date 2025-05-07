
local player_image
local asteroid_spawn
local ast_spawn_intreval
local ast_image
local bullet_image
local game_state
local ast_timer
function love.load()
    love.graphics.newFont(14)
    load_resources()
    load_requirements()


    load_game_scene()
    love.graphics.newFont(30)
    collectgarbage("collect")
    game_state = ""
    num = 0
    ast_timer = 0
end

function love.update(dt)

    --if(collectgarbage("count") > 500)then
        --while collectgarbage("count") >500 do
        --collectgarbage("collect")
        --end
    --end

    ast_timer = ast_timer + dt
    asteroids:upadte(dt)
    bullets:update(dt)
    checkAstBulletCollisions()
    player:update(dt, asteroids)
    

    if(ast_timer >= ast_spawn_intreval)then
       asteroids:addAst(ast_image,love.math.random(math.max(0,player.x-300), math.min(player.x+300, love.graphics.getWidth()-70)),0, 500,0.01)
       ast_timer = 0
    end


end

function love.draw()

    bullets:draw()
    asteroids:draw()
    player:draw()
    health_bar:draw()
    love.graphics.setNewFont(30)
    love.graphics.print("health: "..player.health, 5, 30)
    love.graphics.print("score: "..player.score, 5, 60)
    love.graphics.print("garbage: "..collectgarbage("count"), 5, 90)
    love.graphics.print("num:"..num , 5, 120)

    

end

function load_requirements()
    require "utils"
    require "bullet"
    require "player"
    require "asteroid"
    require "health_bar"
    
    
end

function load_resources()
    player_image = love.graphics.newImage("resources/playerShip.png")
end

function load_game_scene()
    ast_image = love.graphics.newImage("resources/meteor_medium.png")
    bullet_image = love.graphics.newImage("resources/bullet.png")
    player:new(love.graphics.getWidth()/2+player_image:getWidth()/2, love.graphics.getHeight()-player_image:getHeight(), 440, bullet_image)
    health_bar:new(player.health, player.health, 100,20, "green", 5, 10)
    asteroid_spawn = true
    ast_spawn_intreval = 2
end


function checkCollisions(bullet,ast)
    local bullet_top = bullet.y
    local bullet_bottom = bullet.y+bullet.height
    local bullet_right = bullet.x + bullet.width
    local bullet_left = bullet.x

    local ast_top = ast.y
    local ast_bottom = ast.y+ast.height
    local ast_right = ast.x+ast.width
    local ast_left = ast.x

    if bullet_right > ast_left and bullet_left < ast_right and bullet_top < ast_bottom and bullet_bottom > ast_top then
        return true
    else
        return false
    end
end

function checkAstBulletCollisions()
    for i, v in ipairs(bullets) do
        for k, l in ipairs(asteroids) do
            if(checkCollisions(v,l))then
                table.remove(bullets, i)
                table.remove(asteroids, k)
                player.score = player.score + 1

            end
        end
    end
end


