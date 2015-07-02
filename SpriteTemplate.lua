--[[
--This is what is exported as the Sprite class.  Modify as you want.
Sprite = class()

function Sprite:init(name, spriteName, storageLocation, x, y, z, angle, width, height)
    -- you can accept and set parameters here
  
    self.x = x
    self.y = y
    self.z = z
    self.angle = angle
    self.xOffset = 0
    self.yOffset = 0
      --it needs to be a unique name everytime 
    --or the export will export two of the same name.
    self.name = name
    self.spriteName = spriteName
    self.storageLocation = storageLocation
    self.selected = nil
    self.lockAspectRatio = true
    self.width, self.height = width, height
    self.aspectRatio = self.width / self.height
    
end

function Sprite:Draw()

    pushMatrix()
    translate(self.x,self.y)
    rotate(self.angle)
    sprite(self.storageLocation..":"..self.spriteName,0,0,self.width,self.height)
    popMatrix()
    
end

function Sprite:Touched(touch)
    --Small sprites are hard to touch
    --Consider adding a 30 pixel buffer around it.
    if touch.x >= self.x - self.width/2 and touch.x <= self.x + self.width/2 then
        if touch.y>=self.y - self.height/2 and touch.y<= self.y + self.height/2 then

                if touch.state == BEGAN then
                    --add your code here for when the sprite is first touched
                elseif touch.state == MOVING and self.selected == true then 
                    --add your code here for when the touch moves across the sprite.
                end
            
            return true
        end
    end         
end

function Sprite:DeSelect()
    self.selected = nil
end

function Sprite:Select()
    self.selected = true
end

function Sprite:SelectionState()
    return self.selected
end


--]]

