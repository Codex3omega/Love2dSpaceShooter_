health_bar = {}

function health_bar:new(val, max_val, len,height, color, x, y)
    health_bar.value = val
    health_bar.max_value = max_val
    health_bar.len = len
    health_bar.height = height
    health_bar.val_len = len
    health_bar.color = color
    health_bar.x = x
    health_bar.y =y
    
end


function health_bar:update(dt, val)
    health_bar.value = val
    health_bar.val_len = health_bar.len*(health_bar.value/health_bar.max_value)
end

function health_bar:draw()
    love.graphics.rectangle("line",health_bar.x, health_bar.y, health_bar.len, health_bar.height)
    love.graphics.rectangle("fill", health_bar.x, health_bar.y, health_bar.val_len, health_bar.height)
end