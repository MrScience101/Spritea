-- Spritea

--Problem:  Most of my time is spent sizing and placing sprites.
--Goal: Spritea used as a way to rapidly design a scene.
--All sprites located in dropbox are listed on the left.
--Pick the ones you want, place them, resize them, then export
--Click the export button to generate code.
--Hopefully this allows for rapid development of placing sprites.
--Spritea is shamlessly stolen from the same type of name Codea is.
--Sprite + Idea = Spritea, just like Code + Idea = Codea

--Additions needed:
--1. The ability to move whole view with three touches.
--2. The ability to add animated sprites.
--3. Collision detection.
--4. Physics
--5. Paths (eg tweens)

-- Use this function to perform your initial setup
function setup() 
    
    ListSprites()
    lastSelectedSprite = nil
    currentlySelectedSprite = nil
    
    distanceBetweenTwoTouches = 0
    distanceBetweenTwoTouchesInitial = 0
    deltaDistanceBetweenTwoTouches = 0
    
    xDistanceBetweenTwoTouches = 0
    xDistanceBetweenTwoTouchesInitial = 0
    xDeltaDistanceBetweenTwoTouches = 0
    
    yDistanceBetweenTwoTouches = 0
    yDistanceBetweenTwoTouchesInitial = 0
    yDeltaDistanceBetweenTwoTouches = 0
    
    backgroundColor = color(127,127,127,255)
    
    spriteTable = {}
    spriteCounter = 0
    
    --currently only dropbox is supported. 
    --with a little tweaking you could modify it to use documents.
    --storageName = "Dropbox"
    storageName = "Platformer Art"
    nameOfProject = "temp"

    touchCount = 0
    touches = {}
    
end

function draw() --60 times a second if possible, it is called.
    
    background(backgroundColor)
    
        for i, v in ipairs(spriteTable) do
            v:Draw()
        end
    
end

function touched(touch) 
    
    local numSelected = 0  
    local touchedSprite = false
    local distance

    if touch.state == ENDED then
        -- When any touch ends, remove it from the table
        for i, v in pairs(spriteTable) do
            v:DeSelect()
        end

        touches[touch.id] = nil
        touchCount = touchCount - 1    
        numSelected = 0
        
    elseif touch.state == BEGAN then
    
        touches[touch.id] = touch
        touchCount = touchCount + 1

        --cycle through the sprites and select the one touched if any.
        if touchCount == 1 then
            for i, v in pairs(spriteTable) do
                touchedSprite = v:Touched(touch)
                if touchedSprite == true and numSelected == 0 then
                    v.selected = true 
                    numSelected = numSelected + 1
                    currentlySelectedSprite = v  
                
                elseif  touchedSprite == true and numSelected == 1 then
                    --save the currently selected sprite
                    lastSelectedSprite = currentlySelectedSprite
                
                     --figure out which one should be selected
                    currentlySelectedSprite = SelectTopSprite(lastSelectedSprite,v)
                    currentlySelectedSprite.selected = true
                end
            end 
        
        
            if currentlySelectedSprite ~= nil and currentlySelectedSprite.selected == true then
                SetupSpriteParameters(currentlySelectedSprite.name)
            end
        
        end
        

        if touchCount == 2 then
            --Calculate the initial distance
            if currentlySelectedSprite.lockAspectRatio == true then
                distanceBetweenTwoTouchesInitial = DistanceBetweenTwoTouches(touches)
            else
                xDistanceBetweenTwoTouchesInitial = XDistanceBetweenTwoTouches(touches)
                yDistanceBetweenTwoTouchesInitial = YDistanceBetweenTwoTouches(touches)
            end
    
        end
            
    else --state == moving
        
        touches[touch.id] = touch
        
        if touchCount == 1 then
            for i, v in ipairs(spriteTable) do
                  v:Touched(touch)
            end
        end
        
        if touchCount == 2 then
        --drawing doesn't work here????  ellipse(touch.x,touch.y,100)
        
            --If the aspect ratio is locked
            if currentlySelectedSprite.lockAspectRatio == true then
                
                distanceBetweenTwoTouches = DistanceBetweenTwoTouches(touches)
                deltaDistanceBetweenTwoTouches = distanceBetweenTwoTouches - distanceBetweenTwoTouchesInitial
                SetWidth(currentlySelectedSprite.width+deltaDistanceBetweenTwoTouches)
                distanceBetweenTwoTouchesInitial = distanceBetweenTwoTouches
                
            else --If the aspect ratio is not locked
                --Handle the x distance change.
                xDistanceBetweenTwoTouches = XDistanceBetweenTwoTouches(touches)
                xDeltaDistanceBetweenTwoTouches = xDistanceBetweenTwoTouches - xDistanceBetweenTwoTouchesInitial
                SetWidth(currentlySelectedSprite.width+xDeltaDistanceBetweenTwoTouches)
                xDistanceBetweenTwoTouchesInitial = xDistanceBetweenTwoTouches
                --Handle the y distance change.
                yDistanceBetweenTwoTouches = YDistanceBetweenTwoTouches(touches)
                yDeltaDistanceBetweenTwoTouches = yDistanceBetweenTwoTouches - yDistanceBetweenTwoTouchesInitial
                SetHeight(currentlySelectedSprite.height+yDeltaDistanceBetweenTwoTouches)
                yDistanceBetweenTwoTouchesInitial = yDistanceBetweenTwoTouches     
            end
        end
    end
end

function ListSprites()
    
    lastSelectedSprite = nil
    parameter.clear()
    --dropBoxList = spriteList( "Dropbox" )
   dropBoxList = spriteList( "Platformer Art" )
    
    parameter.action("EXPORT", SetupExport)
    parameter.color("backgroundColor", backgroundColor, ChangeBackgroundColor)
    
    for i,v in pairs(dropBoxList) do
        parameter.action( v, CreateSprite)
    end

end

function SetupExport()
    parameter.clear()
    parameter.action("Back", ListSprites)
    parameter.text("Name Of Existing Project", nameOfProject, SetProjectName)
    parameter.action("EXPORT NOW", Export)
end

function SetProjectName(name)
    nameOfProject = name
end
    

function ChangeBackgroundColor(colorChosen)
    backgroundColor = colorChosen
end
        

function CreateSprite(spriteName)
    
    spriteCounter = spriteCounter + 1
    
    output.clear()
    print(spriteName)
    spriteTable[spriteCounter] = Sprite(spriteName..spriteCounter,spriteName, storageName, WIDTH/2, HEIGHT/2, 0, 0,false, 350, 19, 20, 30) --added true for animation
    
    currentlySelectedSprite = spriteTable[spriteCounter]
    SetupSpriteParameters(spriteName) 
end

function SetupSpriteParameters(spriteName)   
    parameter.clear()
    parameter.action("Back", ListSprites)
    parameter.text(currentlySelectedSprite.spriteName, currentlySelectedSprite.name, SetSpriteName)
    parameter.action("Move Left", MoveLeft)
    parameter.action("Move Right", MoveRight)
    parameter.action("Move Up", MoveUp)
    parameter.action("Move Down", MoveDown)
    parameter.number("Depth", -10, 10, currentlySelectedSprite.z, SetDepth)
    parameter.boolean("Personal Class?", currentlySelectedSprite.personalClass,SetPersonalClass)
    parameter.boolean("Lock Aspect Ratio", currentlySelectedSprite.lockAspectRatio, LockAspectRatio)
    parameter.text("Width", currentlySelectedSprite.width, SetWidth)
    parameter.text("Height", currentlySelectedSprite.height, SetHeight)
    parameter.text("Angle", currentlySelectedSprite.angle, SetAngle)
    parameter.action("DELETE", DeleteSprite)
end

function SetSpriteName(spriteName)
    currentlySelectedSprite.name = spriteName
end

function LockAspectRatio(trueFalse)
    currentlySelectedSprite.lockAspectRatio = trueFalse
end

function SetPersonalClass(trueFalse)
    currentlySelectedSprite.personalClass = trueFalse
end    

function MoveLeft()
    currentlySelectedSprite.x = currentlySelectedSprite.x -1
end
function MoveRight()
    currentlySelectedSprite.x = currentlySelectedSprite.x + 1
end
function MoveUp()
    currentlySelectedSprite.y = currentlySelectedSprite.y + 1
end
function MoveDown()
    currentlySelectedSprite.y = currentlySelectedSprite.y - 1
end

function SelectBottomSprite(a,b)
    if a.z < b.z then
        return a   
    else
        return b
    end
end

function SelectTopSprite(a,b)
    if a.z > b.z then
        b.selected = false
        return a
    else
       a.selected = false
        return b
    end
end

function SetWidth(width)
--There is a bug where if the width is negative you cannot select the sprite anymore.
--Cannot figure out how to convert width to a number or you could just return if width < 1.
--Because width is a string if you try it throws an error.

    if width == "" then 
        return
    end  

   if currentlySelectedSprite.lockAspectRatio == true then
        currentlySelectedSprite.height = width / currentlySelectedSprite.aspectRatio
   end
    
   currentlySelectedSprite.width = width    
end

function SetHeight(height)

    if height == "" then 
        return
    end
    
   if currentlySelectedSprite.lockAspectRatio == true then
        currentlySelectedSprite.width = height * currentlySelectedSprite.aspectRatio
    end
     
   currentlySelectedSprite.height = height    
end

function SetAngle(angle)
    
    if angle == "" then
        return
    end
    
    currentlySelectedSprite.angle = angle
end

function SetDepth(depth)
    if currentlySelectedSprite ~= nil then
        currentlySelectedSprite.z = depth
        --Move the sprite to its proper drawing order, lowest(first) to highest(last)
        BubbleSort(spriteTable)
    end
end

--Lua does not have arrays, just tables, in order to treat a table like
--an array we can't have nils in the middle of it or #array won't work.
function DeleteSprite()
    
    currentlySelectedSprite.z = 101
    BubbleSort(spriteTable)
    --find the sprite with a z value of 101 and set it to nil.
    --It should be the last sprite in the array.
    for i, v in ipairs(spriteTable) do
        if v.z == 101 then
            spriteTable[i]= nil --should be at the end of the array
            spriteCounter = spriteCounter - 1
        end
    end
    
    ListSprites()
end
    
