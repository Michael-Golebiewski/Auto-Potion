--[[
        NAME: [BD] Auto Potions
        DESCRIPTION: Uses a potion (Mana / Health) when it reaches the amount you want
        AUTHOR: Bandit
        VERSION: 2.0
]]

HPotUsed = false -- False since we dont want any Pots used by default
MPotUsed = false -- False since we dont want any Pots used by default

manaLimit = 0.375 -- Dont Change this
healthLimit = 0.375 -- Dont Change this
LastTimeHPot = 0 -- Dont Change this
LastTimeMPot = 0 -- Dont Change this
version = "2.0" -- Dont Change this

-- Upon entering the game, This function runs
function OnLoad()
    -- To make sure the script loaded fine, Print this text to the chat so we know its loaded in
    PrintChat("<font color='#FA58F4'>Name:</font><font color='#FFFFFF'> [BD] Auto Potion</font>  <font color='#FA58F4'>VERSION:</font><font color='#FFFFFF'> " .. version .. "</font>  <font color='#FA58F4'>STATUS:</font><font color='#00FF00'> ENABLED</font>")
end

-- Upon unloading the script (No reason for this to happen, just an extra precussion)
function OnUnload()
    -- To make sure the script unloaded fine, Print this text to the chat so we know its unloaded
    PrintChat("<font color='#FA58F4'>Name:</font><font color='#FFFFFF'> [BD] Auto Potion</font>  <font color='#FA58F4'>VERSION:</font><font color='#FFFFFF'> " .. version .. "</font>  <font color='#FA58F4'>STATUS:</font><font color='#FF0000'> DISABLED</font>")
end

function OnTick()
    local player = GetMyHero() -- Gets the champion you are playing
    local manaPercent = player.mana/player.maxMana -- Gets the percentage of mana
    local healthPercent = player.health/player.maxHealth -- Gets the percentage of health
    
    local ItemSlot = {ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6}
    
    -- Auto Health
    for i=1, 6, 1 do
        if player:getInventorySlot(ItemSlot[i]) == 2003 and healthLimit >= healthPercent and HPotUsed == false then -- 2003 == HP Potion
            FinalItemslotH = ItemSlot[i] -- Looks for the health potion
            CastSpell(FinalItemslotH) -- Automaticly uses the item
            HPotUsed = true -- Sets the health pot to be used
            
            lastTimeHPot = GetTickCount() -- Gets the amount of time the potion was used
        end
        
        if GetTickCount() - LastTimeHPot > 15000 then
            HPotUsed = false
        end
        
    end
    
    -- Auto Mana
    for i=1, 6, 1 do
        if player:getInventorySlot(ItemSlot[i]) == 2004 and manaLimit >= manaPercent and MPotUsed == false then -- 2004 == MP Potion
            FinalItemslotM = ItemSlot[i] -- Looks for the mana potion
            CastSpell(FinalItemslotM) -- Automaticly uses the item
            MPotUsed = true -- Sets the mana pot to be used
            
            LastTimeMPot = GetTickCount() -- Gets the amount of time the potion was used
        end
  			
	if GetTickCount() - LastTimeMPot > 15000 then
		MPotUsed = false
	end		
				
    end
end
