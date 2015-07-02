Sprite = class()


function Sprite:init(name, spriteName, storageLocation, x, y, z, angle, animated, frames, rows, columns, fps)
    -- you can accept and set parameters here
   -- print(name)
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
    self.width, self.height = spriteSize(self.storageLocation..":"..self.spriteName)
    self.aspectRatio = self.width / self.height
    
    --animation variables
    self.animated = animated
    
    if self.animated == true then
        self.frames = frames
        self.rows = rows
        self.columns = columns
        self.fps = fps
        self.frameWidth = self.width / columns
        self.frameHeight = self.height / rows
        self.imageTable = {}
        self.currentFrame = 1
        self:InitImages()
        self.width = self.frameWidth
        self.height = self.frameHeight
        self.frameTimer = 0
        
    end 
    
    
    
    --these are variables not included in the template
    self.personalClass = false
    self.viewOffsetX = 0
end

function Sprite:InitImages()
    print("initimages")
    
   --local tempImage = readImage(self.storageLocation..":"..self.spriteName)
   local tempImage = readImage("Dropbox:korg")

print(self.width)
  --  print(self.rows)
--    print(self.columns)
print (self.frameWidth)
print (self.frameHeight)


    local j = 1
    for i=self.rows-1 , 0, -1 do
        for k=0, self.columns-1 do
            --self.imageTable[j] = tempImage:copy(k * self.frameWidth, i * self.frameHeight, self.frameWidth, self.frameHeight)
            self.imageTable[j] = tempImage:copy(k * self.frameWidth, i * self.frameHeight, self.frameWidth, self.frameHeight)
            --print(j)
        j = j + 1
            if j>self.frames-1 then
                return
            end
        end
    end
    
end

function Sprite:Draw()
    -- Codea does not automatically call this method
    
    
    if self.animated == false then
        pushMatrix()
        translate(self.x,self.y)
        rotate(self.angle)
        sprite(self.storageLocation..":"..self.spriteName,0,0,self.width,self.height)
        popMatrix()
    else
    pushMatrix()
    translate(self.x,self.y)
    rotate(self.angle)
    --sprite(self.imageTable[self.currentFrame],0,0,self.frameWidth,self.frameHeight)
    sprite(self.imageTable[self.currentFrame],0,0,self.width,self.height)
    --sprite(self.imageTable[2],0,0,self.frameWidth,self.frameHeight)
      
-- print(self.currentFrame)
    popMatrix()
    
     if self.frameTimer == 2 then
        
        self.currentFrame = self.currentFrame + 1
            
                if self.currentFrame>self.frames-1 then
                    self.currentFrame = 1
                end
         
        end
        
        
        self.frameTimer = self.frameTimer + 1
        
        if self.frameTimer >=3 then
            self.frameTimer = 0
        end
        
    end
        
    
    
    if self.selected == true then
        stroke(255,0,0,125)
        strokeWidth(5)
        rectMode(CENTER)
        noFill()
        rect(self.x,self.y,self.width+100,self.height+100)
        
    end
    
end

function Sprite:Touched(touch)

    if touch.x >= self.x - self.width/2 - 50 and touch.x <= self.x + self.width/2 + 50 then
        if touch.y>=self.y - self.height/2 - 50 and touch.y<= self.y + self.height/2 + 50 then

                if touch.state == BEGAN then
                    self.xOffset = self.x - touch.x
                    self.yOffset = self.y - touch.y
                elseif touch.state == MOVING and self.selected == true then 
                    self.x = touch.x + self.xOffset
                    self.y = touch.y + self.yOffset        
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


