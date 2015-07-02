--The project has to already exist for this to work.  
--If you try to export to a project that does not exist it will crash.
--I create a project called 'temp' for all my testing.
--Then I duplicate it to something else if I want to keep it.

function Export()
    local spriteTab
    local nameNoWhiteSpace
    
    spriteTab = readProjectTab("SpriteTemplate")

    spriteTab = string.gsub(spriteTab,"--%[%[","")
    spriteTab = string.gsub(spriteTab,"--%]%]","")
    
    
    saveProjectTab(nameOfProject .. ":Sprite", spriteTab)
    
    local mainTab = {}
    local mainString
    
    table.insert(mainTab,"function setup()\n\n")
    
    --setup each of the sprites in the scene using the following format:
    --spriteName = Sprite(uniqueName, spriteName, storageName, x, y, z, angle, width, height)
    for i, v in ipairs(spriteTable) do
        
        --Get rid of whitespace in names
        nameNoWhiteSpace = string.gsub(v.name,"%s+","")
       -- print(v.name)
        
        
        --print(v.personalClass)
        if v.personalClass == false then
            
            table.insert(mainTab, nameNoWhiteSpace .. "= Sprite(\""..v.name.."\", \"" .. v.spriteName .. "\", \"" .. v.storageLocation .. "\", " .. v.x .. ", " .. v.y .. ", " .. v.z .. ", ".. v.angle ..", "..v.width..", "..v.height..")\n")
    
        else --personalClass == true, create a seperate tab for it.
            
            spriteTab = string.gsub(spriteTab, "Sprite", nameNoWhiteSpace)
            saveProjectTab(nameOfProject .. ":" .. nameNoWhiteSpace, spriteTab)
            --***put a table.insert here.
            table.insert(mainTab, nameNoWhiteSpace .. "= "..nameNoWhiteSpace.."(\""..v.name.."\", \"" .. v.spriteName .. "\", \"" .. v.storageLocation .. "\", " .. v.x .. ", " .. v.y .. ", " .. v.z .. ", ".. v.angle ..", "..v.width..", "..v.height..")\n")
        end 
            
            
    
    end
    
    table.insert(mainTab, "\nend\n\n")
    
    
    --Write the Draw Function
    table.insert(mainTab, "function draw()\n\n")
    
    --set the background color
    table.insert(mainTab, "background(" .. backgroundColor.r ..", "..backgroundColor.g..", "..backgroundColor.b..", "..backgroundColor.a.. ")\n")
    
    --draw each of the sprites using the following format:
    --spriteName:Draw()
    for i, v in ipairs(spriteTable) do
        nameNoWhiteSpace = string.gsub(v.name,"%s+","")
        table.insert(mainTab, nameNoWhiteSpace .. ":Draw()\n")
    end
    
    table.insert(mainTab, "\nend\n\n")
    
    mainString =  table.concat(mainTab)
    
    print(mainString)
    saveProjectTab(nameOfProject..":Main", mainString)

end