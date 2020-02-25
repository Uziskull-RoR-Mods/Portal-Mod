-- Made by Uziskull
local blueGun = Sprite.load("pgun_blue", "sprites/item/pgun_blue", 2, 12, 15)
local orangeGun = Sprite.load("pgun_orange", "sprites/item/pgun_orange", 2, 12, 15)

local soundEnter = Sound.find("sound_enter")
local soundBlue = Sound.find("sound_blue")
local soundOrange = Sound.find("sound_orange")

local item = Item("Portal Gun")
item.pickupText = "Start thinking with them."
item.sprite = blueGun
item.isUseItem = true
item.useCooldown = 1
item:setTier("use")

local didInitialSetup = false

local portalColor = 0
local portalTurn = 1

-- debug
--registercallback("onPlayerInit", function(player)
    --player.useItem = Item.find("Portal Gun")
--end)

registercallback("onStageEntry", function()
    if not didInitialSetup then
        local chells = 0
        for _, player in ipairs(misc.players) do
            if player:isValid() then
                if player:getSurvivor().displayName == "Chell" then
                    chells = chells + 1
                end
            end
        end
        
        if chells == 1 then
            portalColor = 2
        end
        didInitialSetup = true
    end
    
end)

item:addCallback("use", function(player, embryo)
    local gamepad = input.getPlayerGamepad(player)
    local holdingUp = false
    local holdingDown = false
    local holdingLeft = false
    local holdingRight = false
    if gamepad == nil then
        if player:control("up") == input.HELD then
            holdingUp = true
        end
        if player:control("down") == input.HELD then
            holdingDown = true
        end
        if player:control("left") == input.HELD then
            holdingLeft = true
        end
        if player:control("right") == input.HELD then
            holdingRight = true
        end
    else
        if input.getGamepadAxis("lv", gamepad) < -0.3 or 
            input.checkGamepad("padu", gamepad) == input.HELD then
            holdingUp = true
        end
        if input.getGamepadAxis("lv", gamepad) > 0.3 or 
            input.checkGamepad("padd", gamepad) == input.HELD then
            holdingDown = true
        end
        if input.getGamepadAxis("lh", gamepad) < -0.3 or 
            input.checkGamepad("padl", gamepad) == input.HELD then
            holdingLeft = true
        end
        if input.getGamepadAxis("lh", gamepad) > 0.3 or 
            input.checkGamepad("padr", gamepad) == input.HELD then
            holdingRight = true
        end
    end
    
    local playerDirection = player:getFacingDirection()
    if holdingRight or holdingLeft or holdingUp or holdingDown then
        if holdingUp then
            if holdingRight then
                playerDirection = 45
            elseif not holdingLeft then
                playerDirection = 90
            else
                playerDirection = 135
            end
        elseif holdingDown then
            if holdingLeft then
                playerDirection = 225
            elseif not holdingRight then
                playerDirection = 270
            else
                playerDirection = 315
            end
        end
    end
    
    raytraceBullet(player.x, player.y, playerDirection, 1000, portalColor, portalTurn)
    
    if portalTurn == 1 then
        soundBlue:play(0.8 + math.random() * 0.2)
        item.sprite = orangeGun
        player:setItemSprite(item, item.sprite)
        portalTurn = 2
    else
        soundOrange:play(0.8 + math.random() * 0.2)
        item.sprite = blueGun
        player:setItemSprite(item, item.sprite)
        portalTurn = 1
    end
end)

item:setLog{
	group = "use",
	description = "Creates &b&colored&!& &or&portals&!& that defy space laws.",
	story = "Made by the man who is going to burn your house down with combustible lemons.",
	destination = "Cave Johnson's Basement,\nAperture Science",
	date = "yesterday"
}