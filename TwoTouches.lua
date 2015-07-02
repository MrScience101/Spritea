function DistanceBetweenTwoTouches(touchesTable)
    local loopCounter = 1
    local distance
    local touch1x, touch1y, touch2x, touch2y = 0, 0, 0, 0
    
    for k,touch in pairs(touchesTable) do

                if loopCounter == 1 then
                    touch1x = touch.x
                    touch1y = touch.y    
                elseif loopCounter == 2 then
                    touch2x = touch.x
                    touch2y = touch.y
                end
                loopCounter = loopCounter + 1
    end
            --Calculate the distance between two points.
    distance = math.sqrt(((touch1x-touch2x)^2) + ((touch1y-touch2y)^2))
    
    return distance
end

function XDistanceBetweenTwoTouches(touchesTable)
    local loopCounter = 1
    local distance
    local touch1x, touch1y, touch2x, touch2y = 0, 0, 0, 0
    
    for k,touch in pairs(touchesTable) do
                if loopCounter == 1 then
                    touch1x = touch.x
                    touch1y = touch.y    
                elseif loopCounter == 2 then
                    touch2x = touch.x
                    touch2y = touch.y
                end
                loopCounter = loopCounter + 1
    end
    
    --Calculate the x distance between two points.
    distance = math.sqrt(((touch1x-touch2x)^2))
    
    return distance
end

function YDistanceBetweenTwoTouches(touchesTable)
    local loopCounter = 1
    local distance
    local touch1x, touch1y, touch2x, touch2y = 0, 0, 0, 0
    
    for k,touch in pairs(touchesTable) do
                if loopCounter == 1 then
                    touch1x = touch.x
                    touch1y = touch.y    
                elseif loopCounter == 2 then
                    touch2x = touch.x
                    touch2y = touch.y
                end
                loopCounter = loopCounter + 1
    end
    
    --Calculate the y distance between two points.
    distance = math.sqrt(((touch1y-touch2y)^2))
    
    return distance
end
    