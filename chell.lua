-- Made by Uziskull

local chell = Survivor.new("Chell")

------------------------------
-- Sprites, Objects, Sounds --
------------------------------

local jumpPad = Object.find("Geyser")
local jumpPadSound = Sound.find("Geyser")

local explosionSound = Sound.find("ExplosiveShot")

local stageWidth, stageHeight

local sprites = {
	idle = Sprite.load("chell_idle", "sprites/chell/idle", 1, 3, 10),
	walk = Sprite.load("chell_walk", "sprites/chell/walk", 8, 4, 10),
	jump = Sprite.load("chell_jump", "sprites/chell/jump", 1, 5, 11),
	climb = Sprite.load("chell_climb", "sprites/chell/climb", 2, 4, 7),
	death = Sprite.load("chell_death", "sprites/chell/death", 8, 48, 13),
	decoy = Sprite.load("chell_decoy", "sprites/chell/decoy", 1, 9, 18),
    
    skills = Sprite.load("chell_skills", "sprites/chell/skills", 5, 0, 0),
    loadoutSelect = Sprite.load("chell_select", "sprites/chell/select", 4, 2, 0),
	shoot = Sprite.load("chell_shoot", "sprites/chell/shoot", 2, 4, 11),
    
    portalMask = Sprite.load("portal_mask", "sprites/colors/portal_mask", 1, 7, 9),
    
    colorSet = {
        normal = {
            portal1 = Sprite.load("portal_normal_blue", "sprites/colors/portal_normal_blue", 4, 7, 9),
            portal2 = Sprite.load("portal_normal_orange", "sprites/colors/portal_normal_orange", 4, 7, 9),
            bullet1 = Sprite.load("bullet_normal_blue", "sprites/colors/bullet_normal_blue", 4, 10, 8),
            bullet2 = Sprite.load("bullet_normal_orange", "sprites/colors/bullet_normal_orange", 4, 10, 8),
            iconSet = Sprite.load("icons_normal", "sprites/colors/icons_normal", 2, 0, 0)
        },
        atlas = {
            portal1 = Sprite.load("portal_atlas_blue", "sprites/colors/portal_atlas_blue", 4, 7, 9),
            portal2 = Sprite.load("portal_atlas_orange", "sprites/colors/portal_atlas_orange", 4, 7, 9),
            bullet1 = Sprite.load("bullet_atlas_blue", "sprites/colors/bullet_atlas_blue", 4, 10, 8),
            bullet2 = Sprite.load("bullet_atlas_orange", "sprites/colors/bullet_atlas_orange", 4, 10, 8),
            iconSet = Sprite.load("icons_atlas", "sprites/colors/icons_atlas", 2, 0, 0)
        },
        pbody = {
            portal1 = Sprite.load("portal_pbody_blue", "sprites/colors/portal_pbody_blue", 4, 7, 9),
            portal2 = Sprite.load("portal_pbody_orange", "sprites/colors/portal_pbody_orange", 4, 7, 9),
            bullet1 = Sprite.load("bullet_pbody_blue", "sprites/colors/bullet_pbody_blue", 4, 10, 8),
            bullet2 = Sprite.load("bullet_pbody_orange", "sprites/colors/bullet_pbody_orange", 4, 10, 8),
            iconSet = Sprite.load("icons_pbody", "sprites/colors/icons_pbody", 2, 0, 0)
        }
    }
}

local objects = {
    hep = {
        orb = Sprite.load("hep_orb", "sprites/objects/hep_orb", 4, 4, 4),
        splash = Sprite.load("hep_splash", "sprites/objects/hep_splash", 4, 10, 6),
        popup = Sprite.load("hep_fizzled_popup", "sprites/objects/hep_fizzled_popup", 1, 22, 3)
    },
    ccube = {
        cube = Sprite.load("ccube_cube", "sprites/objects/ccube_cube", 1, 4, 4),
        explosion = Sprite.load("ccube_explosion", "sprites/objects/ccube_explosion", 9, 4, 11),
        detonateIcon = Sprite.load("ccube_detonate_icon", "sprites/objects/ccube_detonate_icon", 1, 0, 0)
    },
    turret = {
        normal = Sprite.load("turret_normal", "sprites/objects/turret_normal", 5, 4, 10),
        opera = Sprite.load("turret_opera", "sprites/objects/turret_opera", 5, 6, 10),
        animalKing = Sprite.load("turret_animal_king", "sprites/objects/turret_animal_king", 8, 9, 26)
    }
}

local sounds = {
    radio = Sound.load("sound_radio", "sound/radio"),
    fizzler = Sound.load("sound_fizzler", "sound/fizzler"),
    portal = {
        enter = Sound.load("sound_enter", "sound/portal_sound_enter"),
        blue = Sound.load("sound_blue", "sound/portal_sound_blue"),
        orange = Sound.load("sound_orange", "sound/portal_sound_orange")
    },
    hep = {
        nyoom = Sound.load("sound_hep_nyoom", "sound/hep_nyoom"),
        bounce = Sound.load("sound_hep_bounce", "sound/hep_bounce"),
        boom = Sound.load("sound_hep_boom", "sound/hep_boom")
    },
    metal = {
        floor1 = Sound.load("sound_metal_impact_1", "sound/metal_impact_1"),
        floor2 = Sound.load("sound_metal_impact_2", "sound/metal_impact_2")
    },
    turret = {
        fire1 = Sound.load("sound_turret_fire_1", "sound/turret_fire_1"),
        fire2 = Sound.load("sound_turret_fire_2", "sound/turret_fire_2"),
        fire3 = Sound.load("sound_turret_fire_3", "sound/turret_fire_3"),
        fire4 = Sound.load("sound_turret_fire_4", "sound/turret_fire_4"),
        serenade = Sound.load("sound_turret_serenade","sound/turret/turret_wife_serenade"),
        cara_mia = Sound.load("sound_cara_mia","sound/turret/cara_mia_addio"),
        voices = {
            search1 = Sound.load("sound_turret_autosearch_1","sound/turret/turret_autosearch_1"),
            search2 = Sound.load("sound_turret_autosearch_2","sound/turret/turret_autosearch_2"),
            search3 = Sound.load("sound_turret_autosearch_3","sound/turret/turret_autosearch_3"),
            search4 = Sound.load("sound_turret_autosearch_4","sound/turret/turret_autosearch_4"),
            search5 = Sound.load("sound_turret_autosearch_5","sound/turret/turret_autosearch_5"),
            shoot1 = Sound.load("sound_turret_deploy_1","sound/turret/turret_deploy_1"),
            shoot2 = Sound.load("sound_turret_deploy_2","sound/turret/turret_deploy_2"),
            shoot3 = Sound.load("sound_turret_deploy_3","sound/turret/turret_deploy_3"),
            shoot4 = Sound.load("sound_turret_deploy_4","sound/turret/turret_deploy_4"),
            shoot5 = Sound.load("sound_turret_deploy_5","sound/turret/turret_deploy_5"),
            dead1 = Sound.load("sound_turret_disabled_1","sound/turret/turret_disabled_1"),
            dead2 = Sound.load("sound_turret_disabled_2","sound/turret/turret_disabled_2"),
            dead3 = Sound.load("sound_turret_disabled_3","sound/turret/turret_disabled_3"),
            dead4 = Sound.load("sound_turret_disabled_4","sound/turret/turret_disabled_4"),
            dead5 = Sound.load("sound_turret_disabled_5","sound/turret/turret_disabled_5"),
            dead6 = Sound.load("sound_turret_disabled_6","sound/turret/turret_disabled_6"),
            searchEnd1 = Sound.load("sound_turret_retire_1","sound/turret/turret_retire_1"),
            searchEnd2 = Sound.load("sound_turret_retire_2","sound/turret/turret_retire_2"),
            searchEnd3 = Sound.load("sound_turret_retire_3","sound/turret/turret_retire_3"),
            tipped1 = Sound.load("sound_turret_tipped_1","sound/turret/turret_tipped_1"),
            tipped2 = Sound.load("sound_turret_tipped_2","sound/turret/turret_tipped_2"),
            tipped3 = Sound.load("sound_turret_tipped_3","sound/turret/turret_tipped_3")
        },
        different1 = Sound.load("sound_turret_different_1", "sound/turret/turret_different_1"),
        different2 = Sound.load("sound_turret_different_2", "sound/turret/turret_different_2"),
        different3 = Sound.load("sound_turret_different_3", "sound/turret/turret_different_3")
    }
}
---

local portalObject = Object.new("Chell Portal")

local highEnergyPellet = Object.new("High-Energy Pellet")
highEnergyPellet.sprite = objects.hep.orb
local fizzlePopup = Object.new("Fizzled Popup")
fizzlePopup.sprite = objects.hep.popup

local companionCube = Object.new("Companion Cube")
companionCube.sprite = objects.ccube.cube

local turret = Object.new("Portal Turret")
local bigTurret = Object.new("Portal Animal King Turret")
bigTurret.sprite = objects.turret.animalKing

-----------
-- Buffs --
-----------

local speedBuff = Buff.new("Portal Horizontal Fling")
speedBuff.sprite = objects.ccube.explosion
speedBuff.frameSpeed = 0

speedBuff:addCallback("start", function(actor)
    actor:set("portalHorizontalFling", actor:get("pHspeed"))
end)

speedBuff:addCallback("step", function(actor)
    actor:set("pHspeed", actor:get("portalHorizontalFling"))
end)

-------------------------
-- Crudely Drawn Buddy --
-------------------------

local decoy = Object.find("EfDecoy")
-- decoy:addCallback("create", function(self)
    -- self:dumpVariables(true)
    -- if self.sprite == sprites.decoy then
        -- sounds.radio:loop()
    -- end
-- end)
registercallback("onStep", function()
    for _,d in ipairs(decoy:findAll()) do
        if d ~= nil then
            if d:isValid() then
                if d.sprite == sprites.decoy then
                    if not sounds.radio:isPlaying() then
                        sounds.radio:loop()
                    end
                end
            end
        end
    end
end)

decoy:addCallback("destroy", function(self)
    if self.sprite == sprites.decoy then
        if sounds.radio:isPlaying() then
            sounds.radio:stop()
        end
    end
end)

---------------------
-- Bullet Particle --
---------------------

local bulletParticle = Object.new("Portal/Orb Bullet Particle")
bulletParticle:addCallback("step", function(self)
    if self:get("lifeRemaining") == nil then
        self:set("lifeRemaining", 4)
    else
        self:set("lifeRemaining", self:get("lifeRemaining") - 1)
    end
    if self:get("lifeRemaining") == 0 then
        self:destroy()
    end
end)

---------
-- Orb --
---------

fizzlePopup:addCallback("create", function(self)
    self:set("alphaCounter", 60)
end)

fizzlePopup:addCallback("step", function(self)
    self.y = self.y - 0.08333
    self.alpha = self:get("alphaCounter") / 60
    self:set("alphaCounter", self:get("alphaCounter") - 1)
    if self:get("alphaCounter") <= 0 then
        self:destroy()
    end
end)

--

local orbHitEnemies = {}

highEnergyPellet:addCallback("create", function(self)
    self:set("bounces", 0)
    self:set("remainingLife", 10 * 60)
    orbHitEnemies[self.id] = {}
end)

highEnergyPellet:addCallback("step", function(self)
    if (self.x < 0 or self.x > stageWidth) and (self.y < 0 or self.y > stageHeight) then
        self:destroy()
    else
        self:set("remainingLife", self:get("remainingLife") - 1)
        if self:get("remainingLife") == 0 then
            local bullet = bulletParticle:create(self.x, self.y)
            bullet.sprite = objects.hep.splash
            bullet.angle = self.angle
            self:destroy()
            sounds.hep.boom:play(1, 0.3)
        else
            if not sounds.hep.nyoom:isPlaying() then
                sounds.hep.nyoom:play(1, 0.2)
            end
            
            local width, height = Stage.getDimensions()
            if self.x < 0 or self.x > width or self.y < 0 or self.y > height then
                self:destroy()
            else
                local oldX = self.x
                local oldY = self.y
                
                self.x = self.x + math.cos(self:get("direction") * math.pi / 180) * (self.sprite.width + 1) / 2
                self.y = self.y - math.sin(self:get("direction") * math.pi / 180) * (self.sprite.width + 1) / 2
                
                while self:collidesMap(self.x, self.y) do
                    self.x = self.x - math.cos(self:get("direction") * math.pi / 180)
                    self.y = self.y + math.sin(self:get("direction") * math.pi / 180)
                end
                
                local stepX, stepY = 0, 0
                if self.x < oldX then
                    stepX = -1
                elseif self.x > oldX then
                    stepX = 1
                end
                if self.y < oldY then
                    stepY = -1
                elseif self.y > oldY then
                    stepY = 1
                end
                
                local stepXX = stepX
                if stepXX == 0 then stepXX = 1 end
                local stepYY = stepY
                if stepYY == 0 then stepYY = 1 end
                
                local ended = false
                for dX = oldX, self.x, stepXX do
                    if not ended then
                        for dY = oldY, self.y, stepYY do
                            if not ended then
                                local nearestCube = companionCube:findNearest(dX, dY)
                                local nearestTurret = turret:findNearest(dX, dY)
                                if nearestCube ~= nil and self:collidesWith(nearestCube, dX, dY) then
                                    ended = true
                                    local multiplier = 1
                                    if self:get("direction") == 180 then
                                        multiplier = -1
                                    end
                                    nearestCube:set("speedX", 15 * multiplier)
                                    nearestCube:set("speedY", -5)
                                    self:set("direction", (self:get("direction") + 180) % 360)
                                    self:set("bounces", self:get("bounces") + 1)
                                    sounds.hep.bounce:play(0.8 + math.random() * 0.2, 0.3)
                                elseif nearestTurret ~= nil and self:collidesWith(nearestTurret, dX, dY) and nearestTurret:get("action") ~= 4 then
                                    ended = true
                                    local multiplier = 1
                                    if self:get("direction") == 180 then
                                        multiplier = -1
                                    end
                                    nearestTurret:set("speedX", 10 * multiplier)
                                    nearestTurret:set("speedY", -5)
                                    self:set("direction", (self:get("direction") + 180) % 360)
                                    self:set("bounces", self:get("bounces") + 1)
                                    sounds.hep.bounce:play(0.8 + math.random() * 0.2, 0.3)
                                else
                                    for _, bruh in ipairs(ParentObject.find("actors"):findAll()) do
                                        if bruh ~= nil then
                                            local playerCheck = not isa(bruh, "PlayerInstance")
                                            if modloader.checkFlag("portal_orb_friendly_fire") then
                                                playerCheck = true
                                            end
                                            local notHitYet = true
                                            for _, dude in ipairs(orbHitEnemies[self.id]) do
                                                if dude == bruh then
                                                    notHitYet = false
                                                    break
                                                end
                                            end
                                            if notHitYet then
                                                if bruh:isValid() and bruh:get("turretID") == nil and playerCheck then
                                                    if self:collidesWith(bruh, dX, dY) then
                                                        if modloader.checkFlag("portal_orb_no_fizzling") then
                                                            local bullet = misc.fireBullet(dX, dY, self:get("direction"), 1, self:get("damage"), "neutral")
                                                            bullet:set("specific_target", bruh.id)
                                                        else
                                                            if math.random(25) == 1 then
                                                                fizzlePopup:create(dX, dY - bruh.sprite.yorigin)
                                                                sounds.fizzler:play(1, 0.3)
                                                                bruh:kill()
                                                            else
                                                                local bullet = misc.fireBullet(dX, dY, self:get("direction"), 1, self:get("damage"), "neutral")
                                                                bullet:set("specific_target", bruh.id)
                                                            end
                                                        end
                                                        
                                                        orbHitEnemies[self.id][#orbHitEnemies[self.id] + 1] = bruh
                                                        
                                                        if self:get("pierce") == 0 then
                                                            local bullet = bulletParticle:create(self.x, self.y)
                                                            bullet.sprite = objects.hep.splash
                                                            bullet.angle = self.angle
                                                            self:destroy()
                                                            sounds.hep.boom:play(1, 0.3)
                                                            ended = true
                                                            break
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                local enteredPortal = false
                
                if self:isValid() then
                    local sourcePortal = portalObject:findNearest(self.x, self.y)
                    if sourcePortal ~= nil then
                        if sourcePortal.angle == self:get("direction") and self:collidesWith(sourcePortal, self.x, self.y) then
                            for _, destinationPortal in ipairs(portalObject:findAll()) do
                                if destinationPortal:isValid() then
                                    if destinationPortal:get("portalColor") == sourcePortal:get("portalColor")
                                      and destinationPortal:get("portalTurn") ~= sourcePortal:get("portalTurn") then
                                        enteredPortal = true
                                        local dX, dY = 0, 0
                                        if destinationPortal.angle % 180 == 0 then
                                            dX = destinationPortal.sprite.width + self.sprite.width
                                            if destinationPortal.angle == 0 then
                                                dX = dX * -1
                                            end
                                        elseif destinationPortal.angle % 180 == 90 then
                                            dY = destinationPortal.sprite.width + self.sprite.width
                                            if destinationPortal.angle == 270 then
                                                dY = dY * -1
                                            end
                                        end
                                        
                                        self.x = destinationPortal.x + dX
                                        self.y = destinationPortal.y + dY
                                        
                                        self:set("direction", (destinationPortal.angle + 180) % 360)
                                        
                                        sounds.portal.enter:play(0.8 + math.random() * 0.2, 0.5)
                                        
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
                
                if self:isValid() then
                    if not enteredPortal then
                        if self:collidesMap(self.x + stepX, self.y + stepY) then
                            self:set("direction", (self:get("direction") + 180) % 360)
                            self:set("bounces", self:get("bounces") + 1)
                            sounds.hep.bounce:play(0.8 + math.random() * 0.2, 0.3)
                            orbHitEnemies[self.id] = {}
                        end
                        if self:get("bounces") == 3 then
                            local bullet = bulletParticle:create(self.x, self.y)
                            bullet.sprite = objects.hep.splash
                            bullet.angle = self.angle
                            self:destroy()
                            sounds.hep.boom:play(1, 0.3)
                        end
                    end
                end
            end
        end
    end
end)

highEnergyPellet:addCallback("destroy", function(self)
    if sounds.hep.nyoom:isPlaying() then
        sounds.hep.nyoom:stop()
    end
end)

--------------------
-- Companion Cube --
--------------------

local physicsHitEnemies = {}

local deployedCubes = {}
local deployedCubesAmount = 0

companionCube:addCallback("create", function(self)
    self:set("speedX", 0)
    self:set("speedY", 0)
    self:set("accelY", 0.26)
    self:set("jumpPadCooldown", 0)
end)

companionCube:addCallback("step", function(self)
    if (self.x < 0 or self.x > stageWidth) and (self.y < 0 or self.y > stageHeight) then
        self:destroy()
    else
        if self:get("jumpPadCooldown") > 0 then self:set("jumpPadCooldown", self:get("jumpPadCooldown") - 1) end

        if not self:collidesMap(self.x, self.y + 1) and self:get("speedY") < 40 then
            self:set("speedY", self:get("speedY") + self:get("accelY"))
        end
        
        local oldX = self.x
        self.x = self.x + self:get("speedX")
        
        local stepX = 1
        if self.x < oldX then
            stepX = -1
        end
        local collisionCoordsX = -1
        for dX = self.x, oldX, -stepX do
            if self:collidesMap(dX, self.y) then
                collisionCoordsX = dX
            end
        end
        if collisionCoordsX ~= -1 then
            self.x = collisionCoordsX - stepX
        end
        
        if self:get("speedX") ~= 0 or self:get("speedY") ~= 0 then
            -- local enemiesHit = {}
            -- local enemiesHitAmount = 0
            for dX = oldX, self.x, stepX do
                for _, baddie in ipairs(ParentObject.find("enemies"):findAll()) do
                    if baddie ~= nil then
                        if baddie:isValid() and baddie:get("turretID") == nil then
                            if self:collidesWith(baddie, dX, self.y) then
                                local alreadyHit = false
                                -- for b = 1, enemiesHitAmount do
                                    -- if enemiesHit[b] == baddie then
                                        -- alreadyHit = true
                                        -- break
                                    -- end
                                -- end
                                if physicsHitEnemies[self.id] == nil then
                                    physicsHitEnemies[self.id] = {}
                                end
                                for _, enemy in ipairs(physicsHitEnemies[self.id]) do
                                    if enemy == baddie then
                                        alreadyHit = true
                                    end
                                end
                                if not alreadyHit then
                                    local damage
                                    for i = 1, deployedCubesAmount do
                                        local cube = deployedCubes[i]
                                        if cube.instance == self then
                                            damage = cube.player:get("damage")
                                            break
                                        end
                                    end
                                    
                                    damage = damage * math.sqrt(self:get("speedX")^2 + self:get("speedY")^2) * 0.1
                                    
                                    local direction = 1
                                    if self:get("speedX") < 0 then
                                        direction = -1
                                    end
                                    local bullet = misc.fireBullet(dX, self.y, direction, 1, damage, "player")
                                    bullet:set("specific_target", baddie.id)
                                    
                                    -- enemiesHitAmount = enemiesHitAmount + 1
                                    -- enemiesHit[enemiesHitAmount] = baddie
                                    physicsHitEnemies[self.id][#physicsHitEnemies[self.id] + 1] = baddie
                                end
                            end
                        end
                    end
                end
            end
        else
            physicsHitEnemies[self.id] = {}
        end
        
        local oldY = self.y
        self.y = self.y + self:get("speedY")
        
        local stepY = 1
        if self.y < oldY then
            stepY = -1
        end
        local collisionCoordsY = -1
        for dY = self.y, oldY, -stepY do
            if self:collidesMap(self.x, dY) then
                collisionCoordsY = dY
            end
        end
        if collisionCoordsY ~= -1 then
            self.y = collisionCoordsY - stepY
        end
        
        if self:get("jumpPadCooldown") == 0 then
            local closestJumpPad = jumpPad:findNearest(self.x, self.y)
            if closestJumpPad ~= nil then
                if closestJumpPad:isValid() then
                    if self:collidesWith(closestJumpPad, self.x, self.y) then
                        self:set("speedY", -12)
                        jumpPadSound:play()
                        self:set("jumpPadCooldown", 10)
                    end
                end
            end
        end
        
        local enteredPortal = false
        local sourcePortal = portalObject:findNearest(self.x, self.y)
        if sourcePortal ~= nil then
            if self:collidesWith(sourcePortal, self.x, self.y) then
                for _, destinationPortal in ipairs(portalObject:findAll()) do
                    if destinationPortal:isValid() then
                        if destinationPortal:get("portalColor") == sourcePortal:get("portalColor")
                          and destinationPortal:get("portalTurn") ~= sourcePortal:get("portalTurn") then
                            enteredPortal = true
                            
                            if destinationPortal.angle % 180 ~= sourcePortal.angle % 180 then
                                local temp = self:get("speedY")
                                self:set("speedY", self:get("speedX"))
                                self:set("speedX", temp)
                            end
                            
                            local dX, dY = 0, 0
                            if destinationPortal.angle == 0 then
                                self:set("speedX", math.abs(self:get("speedX")) * -1)
                                dX = (destinationPortal.mask.width + self.sprite.width - self.sprite.xorigin) * -1
                            elseif destinationPortal.angle == 90 then
                                self:set("speedY", math.abs(self:get("speedY")))
                                dY = destinationPortal.mask.width + self.sprite.yorigin
                            elseif destinationPortal.angle == 180 then
                                self:set("speedX", math.abs(self:get("speedX")))
                                dX = destinationPortal.mask.width + self.sprite.xorigin
                            elseif destinationPortal.angle == 270 then
                                self:set("speedY", math.abs(self:get("speedY")) * -1)
                                dY = (destinationPortal.mask.width + self.sprite.height - self.sprite.yorigin) * -1
                            end
                            
                            self.x = destinationPortal.x + dX
                            self.y = destinationPortal.y + dY
                            
                            sounds.portal.enter:play(0.8 + math.random() * 0.2, 0.5)
                            
                            break
                        end
                    end
                end
            end
        end
        
        if not enteredPortal then
            if self:collidesMap(self.x + stepX, self.y) then
                if self:get("speedX") ~= 0 then
                    self:set("speedX", self:get("speedX") * -3/4)
                    if math.random(2) == 1 then
                        sounds.metal.floor1:play(0.8 + math.random() / 5, 0.2)
                    else
                        sounds.metal.floor2:play(0.8 + math.random() / 5, 0.2)
                    end
                end
            end
            
            if self:collidesMap(self.x, self.y + stepY) then
                if self:get("speedY") ~= 0 then
                    self:set("speedY", self:get("speedY") * -1/2)
                    if math.abs(self:get("speedY")) <= 1 then
                        self:set("speedY", 0)
                        self:set("speedX", 0)
                    else
                        if math.random(2) == 1 then
                            sounds.metal.floor1:play(0.8 + math.random() / 5, 0.2)
                        else
                            sounds.metal.floor2:play(0.8 + math.random() / 5, 0.2)
                        end
                    end
                end
            end
        end
        
        if self:get("speedX") ~= 0 then
            local oldAngle = self.angle
        
            local angleToRotate
            if math.abs(self:get("speedX")) > 15 then
                angleToRotate = 45
            else
                angleToRotate = math.abs(self:get("speedX")) * 3
            end
            local rotationDirection = 1
            if self:get("speedX") < 0 then
                rotationDirection = -1
            end
            self.angle = (self.angle + angleToRotate * rotationDirection) % 360
            
            local newAngle = self.angle
            
            if self:collidesMap(self.x, self.y) then
                -- rotating made it collide with the map
                self.angle = oldAngle
                if self:collidesMap(self.x, self.y + 1) then
                    self.angle = newAngle
                    while self:collidesMap(self.x, self.y) do
                        self.y = self.y - 1
                    end
                elseif self:collidesMap(self.x, self.y - 1) then
                    self.angle = newAngle
                    while self:collidesMap(self.x, self.y) do
                        self.y = self.y + 1
                    end
                elseif self:collidesMap(self.x + 1, self.y) then
                    self.angle = newAngle
                    while self:collidesMap(self.x, self.y) do
                        self.x = self.x - 1
                    end
                elseif self:collidesMap(self.x - 1, self.y) then
                    self.angle = newAngle
                    while self:collidesMap(self.x, self.y) do
                        self.x = self.x + 1
                    end
                end
            end
        else
            if self.angle >= 315 and self.angle < 45 then
                if self.angle >= 315 then
                    self.angle = (self.angle + 5) % 360
                    if self.angle > 0 then
                        self.angle = 0
                    end
                elseif self.angle > 0 then
                    self.angle = (self.angle - 5) % 360
                    if self.angle >= 315 then
                        self.angle = 0
                    end
                end
            elseif self.angle >= 45 and self.angle < 135 then
                if self.angle < 90 then
                    self.angle = (self.angle + 5) % 360
                    if self.angle > 90 then
                        self.angle = 90
                    end
                elseif self.angle > 90 then
                    self.angle = (self.angle - 5) % 360
                    if self.angle < 90 then
                        self.angle = 90
                    end
                end
            elseif self.angle >= 135 and self.angle < 225 then
                if self.angle < 180 then
                    self.angle = (self.angle + 5) % 360
                    if self.angle > 180 then
                        self.angle = 180
                    end
                elseif self.angle > 180 then
                    self.angle = (self.angle - 5) % 360
                    if self.angle < 180 then
                        self.angle = 180
                    end
                end
            else -- >= 225 and < 315
                if self.angle < 270 then
                    self.angle = (self.angle + 5) % 360
                    if self.angle > 270 then
                        self.angle = 270
                    end
                elseif self.angle > 270 then
                    self.angle = (self.angle - 5) % 360
                    if self.angle < 270 then
                        self.angle = 270
                    end
                end
            end
        end
    end
end)

-------------
-- Turrets --
-------------
bigTurret:addCallback("create", function(self)
    self:set("alphaCounter", 0)
    self.alpha = 0
end)

bigTurret:addCallback("step", function(self)
    if self:get("alphaCounter") > 0 then
        self:set("alphaCounter", self:get("alphaCounter") - 1)
        self.alpha = 0.5 - (self:get("alphaCounter") / 400) -- 0.5 max
        if self:get("alphaCounter") == 0 then
            self.spriteSpeed = 1/15 -- 4fps
            self.subimage = 1
        end
    end
    if self:get("tillTheMusicFadesOut") > 0 then self:set("tillTheMusicFadesOut", self:get("tillTheMusicFadesOut") - 1) end
    if self:get("tillTheMusicFadesOut") < 400 then
        self.alpha = self:get("tillTheMusicFadesOut") / 800
        if self:get("tillTheMusicFadesOut") == 0 then
            self:destroy()
        end
    end
end)

--

local lizardsAndPOIs = {}
local lizardsAndPOIsAmount = 0

local lizard = Object.find("Lizard")
lizard:addCallback("destroy", function(self)
    if self:get("turretID") ~= nil then
        for _, turret in ipairs(turret:findAll()) do
            if turret ~= nil then
                if turret:isValid() then 
                    if turret.id == self:get("turretID") then
                        if math.random(2) == 1 then
                            turret:set("speedX", 3)
                        else
                            turret:set("speedX", -3)
                        end
                        turret:set("speedY", -2)
                        break
                    end
                end
            end
        end
    end
end)

local sneakyLemurianBuff = Buff.new("Turret Lemurian Buff")
sneakyLemurianBuff.sprite = objects.ccube.explosion
sneakyLemurianBuff.frameSpeed = 0
sneakyLemurianBuff:addCallback("start", function(actor)
    actor:set("maxhp", 150)
    actor:set("hp", 150)
    
    actor.xscale = 1.666666666 -- turret is quite a bit fatter
    
    actor:set("team", "player")
    actor.alpha = 0
    actor:set("exp_worth", 0)
    local poi = Object.find("POI")
    for _, thing in ipairs(poi:findAll()) do
        if thing ~= nil then
            if thing:isValid() then
                if thing:get("parent") == actor.id then
                    thing:destroy()
                end
            end
        end
    end
    actor:set("noPOIyet", 1)
end)

sneakyLemurianBuff:addCallback("step", function(actor, remainingTime)
    if actor:get("noPOIyet") == 1 then
        actor:set("noPOIyet", 0)
        local poi = Object.find("POI"):create(actor.x,actor.y)
        poi:set("parent", actor.id)
        lizardsAndPOIsAmount = lizardsAndPOIsAmount + 1
        lizardsAndPOIs[lizardsAndPOIsAmount] = {lizard = actor, poi = poi}
    end

    actor:setAlarm(2, 2)
    
    local found = false
    for _, turret in ipairs(turret:findAll()) do
        if turret ~= nil then
            if turret:isValid() then 
                if turret.id == actor:get("turretID") then
                    actor.x = turret.x
                    actor.y = turret.y
                    for i = 1, lizardsAndPOIsAmount do
                        local pair = lizardsAndPOIs[i]
                        if pair.lizard == self then
                            pair.poi.x = turret.x
                            pair.poi.y = turret.y
                            break
                        end
                    end
                    found = true
                    break
                end
            end
        end
    end
    if not found then
        actor:destroy()
        for i = 1, lizardsAndPOIsAmount do
            local pair = lizardsAndPOIs[i]
            if pair.lizard == self then
                pair.poi:destroy()
                table.remove(lizardsAndPOIs, i)
                lizardsAndPOIsAmount = lizardsAndPOIsAmount - 1
                break
            end
        end
    end
    
    if remainingTime == 1 then
        actor:applyBuff(sneakyLemurianBuff, 59)
    end
end)

turret:addCallback("create", function(self)
    local lemurian = lizard:create(self.x, self.y)
    lemurian:set("turretID", self.id)
    self:set("lemurianID", lemurian.id)
    lemurian:applyBuff(sneakyLemurianBuff, 60)
    
    self:set("hasScepter", 0)
    self:set("doneOperaModifications", 0)
    
    self:set("speedX", 0)
    self:set("speedY", 0)
    self:set("accelY", 0.26)
    self:set("direction", 0)
    self:set("jumpPadCooldown", 0)
    
    self:set("damage", 0)
    self:set("target", -1)
    
    self:set("remainingLife", 30 * 60)
    
    self:set("action", 0) -- -1 = dead, 0 = standby, 1 = deploying, 2 = searching, 3 = tipped, 4 = dancing, 5 = different
    self:set("animation", 0)
end)

local playedSerenade = false
local playedCaraMia = false

turret:addCallback("step", function(self)
    -- boundary check
    if (self.x < 0 or self.x > stageWidth) and (self.y < 0 or self.y > stageHeight) then
        self:destroy()
    else

        if self:get("hasScepter") == 1 and self:get("doneOperaModifications") == 0 then
            for _, lem in ipairs(lizard:findAll()) do
                if lem ~= nil then
                    if lem:isValid() and lem.id == self:get("lemurianID") then
                        lem:set("maxhp", 250)
                        lem:set("hp", 250)
                        
                        break
                    end
                end
            end
            self:set("doneOperaModifications", 1)
        end

        if self:get("action") == 4 then -- dancing!
            if self:get("hasScepter") == 1 then
                if self:get("tillTheFatLadySings") > 0 then self:set("tillTheFatLadySings", self:get("tillTheFatLadySings") - 1) end
                if self:get("tillTheBassDrops") > 0 then self:set("tillTheBassDrops", self:get("tillTheBassDrops") - 1) end
                if self:get("tillTheMusicFadesOut") > 0 then self:set("tillTheMusicFadesOut", self:get("tillTheMusicFadesOut") - 1) end

                if self:get("tillTheBassDrops") == 200 then
                    local bigTurretInstance = bigTurret:create(self.x, self.y)
                    bigTurretInstance.depth = 1000
                    bigTurretInstance.spriteSpeed = 0
                    bigTurretInstance.subimage = 4
                    bigTurretInstance:set("alphaCounter", self:get("tillTheBassDrops"))
                    bigTurretInstance:set("tillTheMusicFadesOut", self:get("tillTheMusicFadesOut"))
                end
            end
            if self:get("animation") - 1 == 0 then self:set("animation", 50) else self:set("animation", self:get("animation") - 1) end
            if not sounds.turret.serenade:isPlaying() and not sounds.turret.cara_mia:isPlaying() then
                self:destroy()
            end
        else
            if self:get("action") == 5 then -- different
                if self:get("animation") > 0 then self:set("animation", self:get("animation") - 1) end
                if self:get("animation") == 0 then
                    if math.random(5) == 1 then
                        if math.random(2) == 1 then
                            sounds.turret.different2:play(1, 0.5)
                        else
                            sounds.turret.different3:play(1, 0.5)
                        end
                    end
                    self:set("animation", 300)
                end
            end
            
            if self:get("direction") == 180 and self.xscale ~= -1 then
                self.xscale = -1
            end

            if self:get("jumpPadCooldown") > 0 then self:set("jumpPadCooldown", self:get("jumpPadCooldown") - 1) end
            
            self:set("remainingLife", self:get("remainingLife") - 1)
            if self:get("remainingLife") < 10 then
                self.alpha = self:get("remainingLife") / 10
            end
            if self:get("remainingLife") == 0 then
                self:destroy()
            else
                if self:get("speedX") ~= 0 and self:get("action") ~= 3 and self:get("action") ~= -1 then
                    self:set("action", 3)
                    self:set("animation", 2 * 60)
                    local rand = math.random(3)
                    if rand == 1 then
                        sounds.turret.voices.tipped1:play(1, 0.5)
                    elseif rand == 2 then
                        sounds.turret.voices.tipped2:play(1, 0.5)
                    else
                        sounds.turret.voices.tipped3:play(1, 0.5)
                    end
                end
                
                if not self:collidesMap(self.x, self.y + 1) and self:get("speedY") < 20 then
                    self:set("speedY", self:get("speedY") + self:get("accelY"))
                end
                
                local oldX = self.x
                self.x = self.x + self:get("speedX")
                
                local stepX = 1
                if self.x < oldX then
                    stepX = -1
                end
                local collisionCoordsX = -1
                for dX = self.x, oldX, -stepX do
                    if self:collidesMap(dX, self.y) then
                        collisionCoordsX = dX
                    end
                end
                if collisionCoordsX ~= -1 then
                    self.x = collisionCoordsX - stepX
                end
                
                if self:get("speedX") ~= 0 or self:get("speedY") ~= 0 then
                    -- local enemiesHit = {}
                    -- local enemiesHitAmount = 0
                    for dX = oldX, self.x, stepX do
                        for _, baddie in ipairs(ParentObject.find("enemies"):findAll()) do
                            if baddie ~= nil then
                                if baddie:isValid() and baddie:get("turretID") == nil then
                                    if self:collidesWith(baddie, dX, self.y) then
                                        local alreadyHit = false
                                        -- for b = 1, enemiesHitAmount do
                                            -- if enemiesHit[b] == baddie then
                                                -- alreadyHit = true
                                                -- break
                                            -- end
                                        -- end
                                        if physicsHitEnemies[self.id] == nil then
                                            physicsHitEnemies[self.id] = {}
                                        end
                                        for _, enemy in ipairs(physicsHitEnemies[self.id]) do
                                            if enemy == baddie then
                                                alreadyHit = true
                                            end
                                        end
                                        
                                        if not alreadyHit then
                                            local damage = self:get("damage")
                                            
                                            damage = damage * math.sqrt(self:get("speedX")^2 + self:get("speedY")^2) * 0.1
                                            
                                            local direction = 1
                                            if self:get("speedX") < 0 then
                                                direction = -1
                                            end
                                            local bullet = misc.fireBullet(dX, self.y, direction, 1, damage, "player")
                                            bullet:set("specific_target", baddie.id)
                                            
                                            -- enemiesHitAmount = enemiesHitAmount + 1
                                            -- enemiesHit[enemiesHitAmount] = baddie
                                            physicsHitEnemies[self.id][#physicsHitEnemies[self.id] + 1] = baddie
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    physicsHitEnemies[self.id] = {}
                end
                
                local oldY = self.y
                self.y = self.y + self:get("speedY")
                
                local stepY = 1
                if self.y < oldY then
                    stepY = -1
                end
                local collisionCoordsY = -1
                for dY = self.y, oldY, -stepY do
                    if self:collidesMap(self.x, dY) then
                        collisionCoordsY = dY
                    end
                end
                if collisionCoordsY ~= -1 then
                    self.y = collisionCoordsY - stepY
                end
                
                if self:get("jumpPadCooldown") == 0 then
                    local closestJumpPad = jumpPad:findNearest(self.x, self.y)
                    if closestJumpPad ~= nil then
                        if closestJumpPad:isValid() then
                            if self:collidesWith(closestJumpPad, self.x, self.y) then
                                self:set("speedY", -12)
                                jumpPadSound:play()
                                self:set("jumpPadCooldown", 10)
                            end
                        end
                    end
                end
                
                local enteredPortal = false
                local sourcePortal = portalObject:findNearest(self.x, self.y)
                if sourcePortal ~= nil then
                    if self:collidesWith(sourcePortal, self.x, self.y) then
                        for _, destinationPortal in ipairs(portalObject:findAll()) do
                            if destinationPortal:isValid() then
                                if destinationPortal:get("portalColor") == sourcePortal:get("portalColor")
                                  and destinationPortal:get("portalTurn") ~= sourcePortal:get("portalTurn") then
                                    enteredPortal = true
                                    
                                    if destinationPortal.angle % 180 ~= sourcePortal.angle % 180 then
                                        local temp = self:get("speedY")
                                        self:set("speedY", self:get("speedX"))
                                        self:set("speedX", temp)
                                    end
                                    
                                    local dX, dY = 0, 0
                                    if destinationPortal.angle == 0 then
                                        self:set("speedX", math.abs(self:get("speedX")) * -1)
                                        dX = (destinationPortal.mask.width + self.sprite.width - self.sprite.xorigin) * -1
                                    elseif destinationPortal.angle == 90 then
                                        self:set("speedY", math.abs(self:get("speedY")))
                                        dY = destinationPortal.mask.width + self.sprite.yorigin
                                    elseif destinationPortal.angle == 180 then
                                        self:set("speedX", math.abs(self:get("speedX")))
                                        dX = destinationPortal.mask.width + self.sprite.xorigin
                                    elseif destinationPortal.angle == 270 then
                                        self:set("speedY", math.abs(self:get("speedY")) * -1)
                                        dY = (destinationPortal.mask.width + self.sprite.height - self.sprite.yorigin) * -1
                                    end
                                    
                                    self.x = destinationPortal.x + dX
                                    self.y = destinationPortal.y + dY
                                    
                                    if self:get("action") ~= -1 and self:get("action") ~= 3 then
                                        self:set("action", 3)
                                        self:set("animation", 2 * 60)
                                        local rand = math.random(3)
                                        if rand == 1 then
                                            sounds.turret.voices.tipped1:play(1, 0.5)
                                        elseif rand == 2 then
                                            sounds.turret.voices.tipped2:play(1, 0.5)
                                        else
                                            sounds.turret.voices.tipped3:play(1, 0.5)
                                        end
                                    end
                                    
                                    sounds.portal.enter:play(0.8 + math.random() * 0.2, 0.5)
                                    
                                    break
                                end
                            end
                        end
                    end
                end
                
                if not enteredPortal then
                    if self:collidesMap(self.x + stepX, self.y) then
                        if self:get("speedX") ~= 0 then
                            self:set("speedX", self:get("speedX") * -3/4)
                            if math.random(2) == 1 then
                                sounds.metal.floor1:play(0.8 + math.random() / 5, 0.2)
                            else
                                sounds.metal.floor2:play(0.8 + math.random() / 5, 0.2)
                            end
                        end
                    end
                    
                    if self:collidesMap(self.x, self.y + stepY) then
                        if self:get("speedY") ~= 0 then
                            self:set("speedY", self:get("speedY") * -1/2)
                            if math.abs(self:get("speedY")) <= 1 then
                                self:set("speedY", 0)
                                self:set("speedX", 0)
                            else
                                if math.random(2) == 1 then
                                    sounds.metal.floor1:play(0.8 + math.random() / 5, 0.2)
                                else
                                    sounds.metal.floor2:play(0.8 + math.random() / 5, 0.2)
                                end
                            end
                        end
                    end
                end
                
                if self:get("action") == 0 then -- standby
                    local turretList = {}
                    local turretListCount = 0
                    for _, t in ipairs(turret:findAll()) do
                        if t ~= nil then
                            if t:isValid() and t ~= self then
                                if t.y == self.y and math.abs(t.x - self.x) < 40 and t:get("hasScepter") == 0 and t:get("action") == 0 then
                                    turretListCount = turretListCount + 1
                                    turretList[turretListCount] = t
                                end
                            end
                        end
                    end
                    if (turretListCount == 3 and self:get("hasScepter") == 0 and not playedSerenade)
                      or (turretListCount == 2 and self:get("hasScepter") == 1 and not playedCaraMia) then
                        turretListCount = turretListCount + 1
                        turretList[turretListCount] = self
                        for i = 1, turretListCount do
                            local currentTurret = turretList[i]
                            for _, lem in ipairs(lizard:findAll()) do
                                if lem ~= nil then
                                    if lem:isValid() and lem.id == currentTurret:get("lemurianID") then
                                        lem:destroy()
                                        currentTurret:set("lemurianID", -1)
                                        for i = 1, lizardsAndPOIsAmount do
                                            local pair = lizardsAndPOIs[i]
                                            if pair.lizard == lem then
                                                pair.poi:destroy()
                                                table.remove(lizardsAndPOIs, i)
                                                lizardsAndPOIsAmount = lizardsAndPOIsAmount - 1
                                                break
                                            end
                                        end
                                        
                                        break
                                    end
                                end
                            end
                            
                            currentTurret:set("action", 4)
                            currentTurret:set("animation", math.random(50))
                            currentTurret:set("direction", math.random(0, 1) * 180)
                        end
                        
                        -- added self so count is now 4 (or 3)
                        if turretListCount == 4 and self:get("hasScepter") == 0 then
                            -- if sounds.turret.serenade:isPlaying() then
                                -- sounds.turret.serenade:stop()
                                -- playedSerenade = true
                            -- end
                            sounds.turret.serenade:play()
                            playedSerenade = true
                        else
                            -- if sounds.turret.cara_mia:isPlaying() then
                                -- sounds.turret.cara_mia:stop()
                                -- playedCaraMia = true
                            -- end
                            sounds.turret.cara_mia:play()
                            playedCaraMia = true
                            self:set("tillTheFatLadySings", 2445)
                            self:set("tillTheBassDrops", 3577)
                            self:set("tillTheMusicFadesOut", 8224)
                        end
                        
                    else
                
                        local small = Object.find("EfGold"):create(0,0)
                        --for alpha = -30, 30 do
                        local angle = self:get("direction") --(self:get("direction") + alpha) % 360
                        -- for range = 1, 250 do
                            -- if small:collidesMap(
                              -- self.x + math.cos(angle * math.pi / 180) * range,
                              -- self.y - math.sin(angle * math.pi / 180) * range) then
                                -- break
                            -- end
                            -- for _, enemy in ipairs(ObjectGroup.find("enemies"):findAll()) do
                                -- if enemy ~= nil then
                                    -- if enemy:isValid() and enemy:get("turretID") == nil then
                                        -- if small:collidesWith(enemy,
                                          -- self.x + math.cos(angle * math.pi / 180) * range,
                                          -- self.y - math.sin(angle * math.pi / 180) * range) then
                                            -- self:set("target", enemy.id)
                                            -- break
                                        -- end
                                    -- end
                                -- end
                            -- end
                            -- if self:get("target") ~= -1 then
                                -- break
                            -- end
                        -- end
                        for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
                            if enemy ~= nil then
                                if enemy:isValid() and enemy:get("turretID") == nil then
                                    local checkShoot = false
                                    if enemy.y - enemy.sprite.yorigin < self.y and enemy.y + enemy.sprite.height - enemy.sprite.yorigin then
                                        if self:get("direction") < 90 or self:get("direction") >= 270 then -- right
                                            checkShoot = enemy.x >= self.x and enemy.x <= self.x + 250
                                        else -- left
                                            checkShoot = enemy.x <= self.x and enemy.x >= self.x - 250
                                        end
                                    end
                                    if checkShoot then
                                        for range = 1, 250 do
                                            if small:collidesMap(
                                              self.x + math.cos(angle * math.pi / 180) * range,
                                              self.y - math.sin(angle * math.pi / 180) * range) then
                                                break
                                            end
                                            if small:collidesWith(enemy,
                                              self.x + math.cos(angle * math.pi / 180) * range,
                                              self.y - math.sin(angle * math.pi / 180) * range) then
                                                self:set("target", enemy.id)
                                                break
                                            end
                                        end
                                        if self:get("target") ~= -1 then
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if self:get("target") ~= -1 then
                            self:set("animation", 30)
                            self:set("action", 1)
                            local rand = math.random(5)
                            if rand == 1 then
                                sounds.turret.voices.shoot1:play(1, 0.5)
                            elseif rand == 2 then
                                sounds.turret.voices.shoot2:play(1, 0.5)
                            elseif rand == 3 then
                                sounds.turret.voices.shoot3:play(1, 0.5)
                            elseif rand == 4 then
                                sounds.turret.voices.shoot4:play(1, 0.5)
                            else
                                sounds.turret.voices.shoot5:play(1, 0.5)
                            end
                            --break
                        end
                        --end
                        small:delete()
                    end
                elseif self:get("action") == 1 then -- deploying
                    self:set("animation", self:get("animation") - 1)
                    if self:get("animation") == 0 then
                        local tookShot = false
                        for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
                            if enemy ~= nil then
                                if enemy:isValid() and enemy:get("turretID") == nil then
                                    -- local multiplier = 1
                                    -- if self:get("direction") == 180 then
                                        -- multiplier = -1
                                    -- end
                                    -- if (enemy.x - self.x) * multiplier > 0 then
                                    local checkShoot = false
                                    if enemy.y - enemy.sprite.yorigin < self.y and enemy.y + enemy.sprite.height - enemy.sprite.yorigin then
                                        if self:get("direction") < 90 or self:get("direction") >= 270 then -- right
                                            checkShoot = enemy.x >= self.x and enemy.x <= self.x + 250
                                        else -- left
                                            checkShoot = enemy.x <= self.x and enemy.x >= self.x - 250
                                        end
                                    end
                                    if checkShoot then
                                        if enemy.id == self:get("target") then
                                            local angle = math.atan(self.y - enemy.y, enemy.x - self.x) * 180 / math.pi
                                            local distance = math.sqrt((enemy.x - self.x)^2 + (enemy.y - self.y)^2)
                                            local hitWall = false
                                            local small = Object.find("EfGold"):create(0,0)
                                            for i = 1, distance do
                                                if small:collidesMap(
                                                  self.x + math.cos(angle * math.pi / 180) * distance,
                                                  self.y - math.sin(angle * math.pi / 180) * distance) then
                                                    hitWall = true
                                                    break
                                                end
                                            end
                                            small:delete()
                                            if not hitWall then
                                                tookShot = true
                                                
                                                local bulletInstance = misc.fireBullet(self.x, self.y, angle, 250, self:get("damage"), "player", Sprite.find("sparks1"))
                                                bulletInstance:set("specific_target", self:get("target"))
                                                bulletInstance:set("knockback", 0)
                                                local rand = math.random(4)
                                                if rand == 1 then
                                                    sounds.turret.fire1:play(0.8 + math.random() / 5, 0.5)
                                                elseif rand == 2 then
                                                    sounds.turret.fire2:play(0.8 + math.random() / 5, 0.5)
                                                elseif rand == 3 then
                                                    sounds.turret.fire3:play(0.8 + math.random() / 5, 0.5)
                                                else
                                                    sounds.turret.fire4:play(0.8 + math.random() / 5, 0.5)
                                                end
                                                
                                                self:set("animation", 12)
                                                
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if not tookShot then
                            self:set("target", -1)
                            local small = Object.find("EfGold"):create(0,0)
                            --for alpha = -30, 30 do
                            local angle = self:get("direction") --(self:get("direction") + alpha) % 360
                            -- for range = 1, 250 do
                                -- if small:collidesMap(
                                  -- self.x + math.cos(angle * math.pi / 180) * range,
                                  -- self.y - math.sin(angle * math.pi / 180) * range) then
                                    -- break
                                -- end
                                -- for _, enemy in ipairs(ObjectGroup.find("enemies"):findAll()) do
                                    -- if enemy ~= nil then
                                        -- if enemy:isValid() and enemy:get("turretID") == nil then
                                            -- if small:collidesWith(enemy,
                                              -- self.x + math.cos(angle * math.pi / 180) * range,
                                              -- self.y - math.sin(angle * math.pi / 180) * range) then
                                                -- self:set("target", enemy.id)
                                                -- break
                                            -- end
                                        -- end
                                    -- end
                                -- end
                                -- if self:get("target") ~= -1 then
                                    -- break
                                -- end
                            -- end
                            for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
                                if enemy ~= nil then
                                    if enemy:isValid() and enemy:get("turretID") == nil then
                                        local checkShoot = false
                                        if enemy.y - enemy.sprite.yorigin < self.y and enemy.y + enemy.sprite.height - enemy.sprite.yorigin then
                                            if self:get("direction") < 90 or self:get("direction") >= 270 then -- right
                                                checkShoot = enemy.x >= self.x and enemy.x <= self.x + 250
                                            else -- left
                                                checkShoot = enemy.x <= self.x and enemy.x >= self.x - 250
                                            end
                                        end
                                        if checkShoot then
                                            for range = 1, 250 do
                                                if small:collidesMap(
                                                  self.x + math.cos(angle * math.pi / 180) * range,
                                                  self.y - math.sin(angle * math.pi / 180) * range) then
                                                    break
                                                end
                                                if small:collidesWith(enemy,
                                                  self.x + math.cos(angle * math.pi / 180) * range,
                                                  self.y - math.sin(angle * math.pi / 180) * range) then
                                                    self:set("target", enemy.id)
                                                    break
                                                end
                                            end
                                            if self:get("target") ~= -1 then
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            if self:get("target") ~= -1 then
                                self:set("animation", 6)
                                --break
                            end
                            --end
                            small:delete()
                            if self:get("target") == -1 then
                                self:set("action", 2)
                                self:set("animation", 5 * 60)
                                local rand = math.random(5)
                                if rand == 1 then
                                    sounds.turret.voices.search1:play(1, 0.5)
                                elseif rand == 2 then
                                    sounds.turret.voices.search2:play(1, 0.5)
                                elseif rand == 3 then
                                    sounds.turret.voices.search3:play(1, 0.5)
                                elseif rand == 4 then
                                    sounds.turret.voices.search4:play(1, 0.5)
                                else
                                    sounds.turret.voices.search5:play(1, 0.5)
                                end
                            end
                        end
                    end
                elseif self:get("action") == 2 then -- searching
                    self:set("animation", self:get("animation") - 1)
                    if self:get("animation") == 0 then
                        self:set("action", 0)
                        local rand = math.random(3)
                        if rand == 1 then
                            sounds.turret.voices.searchEnd1:play(1, 0.5)
                        elseif rand == 2 then
                            sounds.turret.voices.searchEnd2:play(1, 0.5)
                        else
                            sounds.turret.voices.searchEnd3:play(1, 0.5)
                        end
                    elseif self:get("animation") < 4 * 60 then
                        local small = Object.find("EfGold"):create(0,0)
                        --for alpha = -30, 30 do
                        local angle = self:get("direction") --(self:get("direction") + alpha) % 360
                        -- for range = 1, 250 do
                            -- if small:collidesMap(
                              -- self.x + math.cos(angle * math.pi / 180) * range,
                              -- self.y - math.sin(angle * math.pi / 180) * range) then
                                -- break
                            -- end
                            -- for _, enemy in ipairs(ObjectGroup.find("enemies"):findAll()) do
                                -- if enemy ~= nil then
                                    -- if enemy:isValid() and enemy:get("turretID") == nil then
                                        -- if small:collidesWith(enemy,
                                          -- self.x + math.cos(angle * math.pi / 180) * range,
                                          -- self.y - math.sin(angle * math.pi / 180) * range) then
                                            -- self:set("target", enemy.id)
                                            -- break
                                        -- end
                                    -- end
                                -- end
                            -- end
                            -- if self:get("target") ~= -1 then
                                -- break
                            -- end
                        -- end
                        for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
                            if enemy ~= nil then
                                if enemy:isValid() and enemy:get("turretID") == nil then
                                    local checkShoot = false
                                    if enemy.y - enemy.sprite.yorigin < self.y and enemy.y + enemy.sprite.height - enemy.sprite.yorigin then
                                        if self:get("direction") < 90 or self:get("direction") >= 270 then -- right
                                            checkShoot = enemy.x >= self.x and enemy.x <= self.x + 250
                                        else -- left
                                            checkShoot = enemy.x <= self.x and enemy.x >= self.x - 250
                                        end
                                    end
                                    if checkShoot then
                                        for range = 1, 250 do
                                            if small:collidesMap(
                                              self.x + math.cos(angle * math.pi / 180) * range,
                                              self.y - math.sin(angle * math.pi / 180) * range) then
                                                break
                                            end
                                            if small:collidesWith(enemy,
                                              self.x + math.cos(angle * math.pi / 180) * range,
                                              self.y - math.sin(angle * math.pi / 180) * range) then
                                                self:set("target", enemy.id)
                                                break
                                            end
                                        end
                                        if self:get("target") ~= -1 then
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if self:get("target") ~= -1 then
                            self:set("animation", 30)
                            self:set("action", 1)
                            local rand = math.random(5)
                            if rand == 1 then
                                sounds.turret.voices.shoot1:play(1, 0.5)
                            elseif rand == 2 then
                                sounds.turret.voices.shoot2:play(1, 0.5)
                            elseif rand == 3 then
                                sounds.turret.voices.shoot3:play(1, 0.5)
                            elseif rand == 4 then
                                sounds.turret.voices.shoot4:play(1, 0.5)
                            else
                                sounds.turret.voices.shoot5:play(1, 0.5)
                            end
                            --break
                        end
                        --end
                        small:delete()
                    end
                elseif self:get("action") == 3 then -- tipped
                    if self:get("lemurianID") ~= nil then
                        for _, lem in ipairs(lizard:findAll()) do
                            if lem ~= nil then
                                if lem:isValid() and lem.id == self:get("lemurianID") then
                                    lem:destroy()
                                    for i = 1, lizardsAndPOIsAmount do
                                        local pair = lizardsAndPOIs[i]
                                        if pair.lizard == lem then
                                            pair.poi:destroy()
                                            table.remove(lizardsAndPOIs, i)
                                            lizardsAndPOIsAmount = lizardsAndPOIsAmount - 1
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        self:set("lemurianID", nil)
                    end
                    self:set("animation", self:get("animation") - 1)
                    if self:get("animation") == 0 then
                        self:set("action", -1)
                        local rand = math.random(6)
                        if rand == 1 then
                            sounds.turret.voices.dead1:play(1, 0.5)
                        elseif rand == 2 then
                            sounds.turret.voices.dead2:play(1, 0.5)
                        elseif rand == 3 then
                            sounds.turret.voices.dead3:play(1, 0.5)
                        elseif rand == 4 then
                            sounds.turret.voices.dead4:play(1, 0.5)
                        elseif rand == 5 then
                            sounds.turret.voices.dead5:play(1, 0.5)
                        else
                            sounds.turret.voices.dead6:play(1, 0.5)
                        end
                    else
                        if self:get("animation") % 12 == 0 then
                            local angleVariation = math.random() * 10 - 5
                            misc.fireBullet(self.x, self.y, self.angle + angleVariation, 250, self:get("damage"), "player", Sprite.find("sparks1"))
                            local rand = math.random(4)
                            if rand == 1 then
                                sounds.turret.fire1:play(0.8 + math.random() / 5, 0.5)
                            elseif rand == 2 then
                                sounds.turret.fire2:play(0.8 + math.random() / 5, 0.5)
                            elseif rand == 3 then
                                sounds.turret.fire3:play(0.8 + math.random() / 5, 0.5)
                            else
                                sounds.turret.fire4:play(0.8 + math.random() / 5, 0.5)
                            end
                        end
                    end
                    if self:get("speedX") ~= 0 then
                        local angleToRotate
                        if math.abs(self:get("speedX")) > 10 then
                            angleToRotate = 10
                        else
                            angleToRotate = math.abs(self:get("speedX"))
                        end
                        local rotationDirection = 1
                        if self:get("speedX") < 0 then
                            rotationDirection = -1
                        end
                        self.angle = (self.angle + angleToRotate * rotationDirection) % 360
                    else
                        if self.angle >= 0 and self.angle < 180 then
                            if self.angle < 90 then
                                self.angle = self.angle + 5
                                if self.angle > 90 then
                                    self.angle = 90
                                end
                            elseif self.angle > 90 then
                                self.angle = self.angle - 5
                                if self.angle < 90 then
                                    self.angle = 90
                                end
                            end
                        elseif self.angle >= 180 and self.angle < 360 then
                            if self.angle < 270 then
                                self.angle = self.angle + 5
                                if self.angle > 270 then
                                    self.angle = 270
                                end
                            elseif self.angle > 270 then
                                self.angle = self.angle - 5
                                if self.angle < 270 then
                                    self.angle = 270
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

turret:addCallback("draw", function(self)
    if self:get("action") == -1 then -- dead
        graphics.drawImage{
            image = self.sprite,
            x = self.x,
            y = self.y,
            subimage = 5,
            xscale = self.xscale,
            angle = self.angle
        }
    elseif self:get("action") == 0 or self:get("action") == 5 then -- standby or different
        graphics.drawImage{
            image = self.sprite,
            x = self.x,
            y = self.y,
            subimage = 1,
            xscale = self.xscale,
            angle = self.angle
        }
    elseif self:get("action") == 1 then -- deploying
        if self:get("animation") <= 15 then
            if self:get("animation") == 1 then
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 4,
                    xscale = self.xscale,
                    angle = self.angle
                }
            else
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 3,
                    xscale = self.xscale,
                    angle = self.angle
                }
            end
        else
            graphics.drawImage{
                image = self.sprite,
                x = self.x,
                y = self.y,
                subimage = 2,
                xscale = self.xscale,
                angle = self.angle
            }
        end
    elseif self:get("action") == 2 then -- searching
        graphics.drawImage{
            image = self.sprite,
            x = self.x,
            y = self.y,
            subimage = 3,
            xscale = self.xscale,
            angle = self.angle
        }
    elseif self:get("action") == 3 then -- tipped
        if self:get("animation") % 12 == 1 then
            graphics.drawImage{
                image = self.sprite,
                x = self.x,
                y = self.y,
                subimage = 4,
                xscale = self.xscale,
                angle = self.angle
            }
        else
            graphics.drawImage{
                image = self.sprite,
                x = self.x,
                y = self.y,
                subimage = 3,
                xscale = self.xscale,
                angle = self.angle
            }
        end
    elseif self:get("action") == 4 then -- dancing
        local doesAnimation = true
        if self:get("hasScepter") == 1 then
            if self:get("tillTheFatLadySings") ~= 0 then
                doesAnimation = false
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 1,
                    xscale = self.xscale,
                    angle = self.angle
                }
            end
        end
        if doesAnimation then
            if self:get("animation") <= 10 then
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 3,
                    xscale = self.xscale,
                    angle = self.angle
                }
            elseif self:get("animation") <= 20 then
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 2,
                    xscale = self.xscale,
                    angle = self.angle
                }
            elseif self:get("animation") <= 30 then
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 1,
                    xscale = self.xscale,
                    angle = self.angle
                }
            elseif self:get("animation") <= 40 then
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 2,
                    xscale = self.xscale * -1,
                    angle = self.angle
                }
            else
                graphics.drawImage{
                    image = self.sprite,
                    x = self.x,
                    y = self.y,
                    subimage = 3,
                    xscale = self.xscale * -1,
                    angle = self.angle
                }
            end
        end
    end
end)

-- turret:addCallback("destroy", function(self)
    -- for i = 1, turretsAndPOIsAmount do
        -- local pair = turretsAndPOIs[i]
        -- if pair.turret == self then
            -- pair.poi:destroy()
            -- table.remove(turretsAndPOIs, i)
            -- turretsAndPOIsAmount = turretsAndPOIsAmount - 1
            -- break
        -- end
    -- end
-- end)
-------------
-- Portals --
-------------

function tableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end
registercallback("preStep", function()
    -- debug
    -- if input.checkKeyboard("numpad4") == input.PRESSED then
        -- local turretInstance = turret:create(misc.players[1].x, misc.players[1].y)
        -- turretInstance:set("direction", misc.players[1]:getFacingDirection())
        -- turretInstance.sprite = objects.turret.normal
        -- turretInstance:set("damage", misc.players[1]:get("damage") * 0.5)
        -- turretInstance.spriteSpeed = 0
        -- turretInstance.alpha = 0
    -- elseif input.checkKeyboard("numpad5") == input.PRESSED then
        -- local turretInstance = turret:create(misc.players[1].x, misc.players[1].y)
        -- turretInstance:set("direction", misc.players[1]:getFacingDirection())
        -- turretInstance.sprite = objects.turret.opera
        -- turretInstance:set("damage", misc.players[1]:get("damage"))
        -- turretInstance:set("hasScepter", 1)
        -- turretInstance.spriteSpeed = 0
        -- turretInstance.alpha = 0
    -- elseif input.checkKeyboard("numpad6") == input.PRESSED then
        -- local turretInstance = turret:create(misc.players[1].x, misc.players[1].y)
        -- turretInstance:set("direction", misc.players[1]:getFacingDirection())
        -- turretInstance.sprite = objects.turret.normal
        -- turretInstance:set("damage", misc.players[1]:get("damage") * 0.5)
        -- turretInstance:set("action", 5)
        -- turretInstance:set("animation", 600)
        -- sounds.turret.different1:play(1, 0.5)
        -- turretInstance.spriteSpeed = 0
        -- turretInstance.alpha = 0
    -- end
    
    local physicsActors = tableConcat(ParentObject.find("classicEnemies"):findAll(), misc.players)
    
    for _, actor in ipairs(physicsActors) do --ObjectGroup.find("actors"):findAll()) do
        if isa(actor, "PlayerInstance") and actor:get("oldSpeedY") == nil then
            actor:set("oldSpeedY", 0)
            actor:set("oldHP", actor:get("hp"))
        end
        if isa(actor, "PlayerInstance") then
            if actor:getSurvivor().displayName == "Chell" then
                if actor:get("pVspeed") == 0 and actor:get("oldSpeedY") ~= 0 then
                    if actor:get("hp") < actor:get("oldHP") then
                        -- long fall boots
                        local regen = 0
                        if actor:get("oldHP") + actor:get("hp_regen") <= actor:get("maxhp") then regen = actor:get("hp_regen") end
                        actor:set("hp", actor:get("oldHP") + regen)
                    end
                end
            end
        end
        if actor:isValid() then
            local sourcePortal = portalObject:findNearest(actor.x, actor.y)
            if sourcePortal ~= nil then
                if actor:collidesWith(sourcePortal, actor.x, actor.y) then
                    if isa(actor, "PlayerInstance") and actor:get("pVspeed") == 0 and actor:get("oldSpeedY") ~= 0 then
                        -- hit floor while going through portals
                        actor:set("pVspeed", actor:get("oldSpeedY"))
                        local regen = 0
                        if actor:get("oldHP") + actor:get("hp_regen") <= actor:get("maxhp") then regen = actor:get("hp_regen") end
                        actor:set("hp", actor:get("oldHP") + regen)
                    end
                    for _, destinationPortal in ipairs(portalObject:findAll()) do
                        if destinationPortal:isValid() then
                            if destinationPortal:get("portalColor") == sourcePortal:get("portalColor")
                              and destinationPortal:get("portalTurn") ~= sourcePortal:get("portalTurn") then
                                
                                actor:set("pVspeed", math.abs(actor:get("pVspeed")) * math.sin(destinationPortal.angle * math.pi / 180))
                                actor:set("pHspeed", math.abs(actor:get("pHspeed")) * math.cos(destinationPortal.angle * math.pi / 180) * -1)
                                
                                local xFix = 0
                                if destinationPortal.angle % 180 ~= sourcePortal.angle % 180 then
                                    local temp = actor:get("pVspeed")
                                    actor:set("pVspeed", actor:get("pHspeed"))
                                    actor:set("pHspeed", temp)
                                    if sourcePortal.angle % 180 == 0 then
                                        -- enter horizontal, come out vertical
                                        actor:set("pVspeed", actor:get("pVspeed") - 1)
                                        if sourcePortal.angle == 0 then
                                            xFix = destinationPortal.sprite.height - destinationPortal.sprite.xorigin
                                        else
                                            xFix = destinationPortal.sprite.xorigin * -1 - 2
                                        end
                                    end
                                end
                                
                                -- this is probably useless
                                if destinationPortal.angle % 180 == 0 then
                                    actor:applyBuff(speedBuff, 15)
                                end
                                
                                local dX, dY = 0, 0
                                if destinationPortal.angle == 0 then
                                    dX = (destinationPortal.mask.width + actor.sprite.width - actor.sprite.xorigin) * -1
                                elseif destinationPortal.angle == 90 then
                                    dY = destinationPortal.mask.width + actor.sprite.yorigin
                                elseif destinationPortal.angle == 180 then
                                    dX = destinationPortal.mask.width + actor.sprite.xorigin
                                elseif destinationPortal.angle == 270 then
                                    dY = (destinationPortal.mask.width + actor.sprite.height - actor.sprite.yorigin) * -1
                                end
                                
                                actor.x = destinationPortal.x + dX + xFix
                                actor.y = destinationPortal.y + dY
                                -- dope rope fix that saturn knew of but didn't add to the docs like he should have >:(
                                actor:set("xprevious", actor.x)
                                actor:set("yprevious", actor.y)
                                
                                if actor:get("activity") == 30 then
                                    actor:set("activity", 0)
                                    actor:set("moveUp", 1):set("ropeUp", 0):set("ropeDown",0)
                                end
                                
                                sounds.portal.enter:play(0.8 + math.random() * 0.2, 0.5)
                                
                                break
                            end
                        end
                    end
                end
            end
        end
        if isa(actor, "PlayerInstance") then
            actor:set("oldSpeedY", actor:get("pVspeed"))
            actor:set("oldHP", actor:get("hp"))
        end
    end
end)

-----------------------
-- Character details --
-----------------------

chell:setLoadoutInfo(
[[&b&Chell&!& was a test subject at the &y&Aperture Science&!& who managed to escape,
bringing some goodies along, such as the A.S.H.P.D., or &y&Portal Gun&!& for short.
&or&High Energy Pellet&!& is a powerful but dangerous attack, as it can also damage you.
&or&Companion Cube&!& can be flailed around to deal heavy damage.
&or&Deploy Turret&!& gets a random turret from Aperture Science, even if its friendly.]], sprites.skills)
--&or&Portal Gun&!& can be fired diagonally and can be used for more than just movement.

chell:setLoadoutSkill(1, "High Energy Pellet",
[[Fires a high-velocity orb that deals &y&250% damage&!& and ricochets off walls,
hurting anything in its path. Has a chance to vaporize a target.]])

chell:setLoadoutSkill(2, "Companion Cube",
[[Spawns a lovingly booby-trapped cube that deals damage to enemies on impact
based on its velocity. Reactivate to explode, dealing &y&200% damage&!&.]])

chell:setLoadoutSkill(3, "Portal Gun",
[[Fires one of two portals, alternating between them when fired. When both are
placed, creates an interdimensional link between them that conserves momentum.]])

chell:setLoadoutSkill(4, "Deploy Turret",
[[Spawn a turret that lasts &y&30 seconds&!&. When in range of an enemy,
it shoots for &y&50% damage per second&!&. Can be flung.]])

chell.loadoutColor = Color(0xFF7F00)

chell.loadoutSprite = sprites.loadoutSelect

chell.titleSprite = sprites.walk

chell.endingQuote = "..and so she left, still waiting for a third sequel."

----------------

local skillSetupDone = false

registercallback("onStageEntry", function()
    stageWidth, stageHeight = Stage.getDimensions()

    if sounds.hep.nyoom:isPlaying() then
        sounds.hep.nyoom:stop()
    end
    
    if sounds.turret.serenade:isPlaying() then
        sounds.turret.serenade:stop()
    end
    if sounds.turret.cara_mia:isPlaying() then
        sounds.turret.cara_mia:stop()
    end
    if sounds.radio:isPlaying() then
        sounds.radio:stop()
    end
    
    orbHitEnemies = {}
    physicsHitEnemies = {}
    
    deployedCubesAmount = 0
    deployedCubes = {}
    
    for _, player in ipairs(misc.players) do
        if player:getSurvivor().displayName == "Chell" then
            player:set("cubeDispensed", 0)
            player:setSkill(2,
                "Companion Cube",
                "Spawns a lovingly booby-trapped cube that deals damage to enemies on impact\nbased on its velocity. Reactivate to explode, dealing 200% damage.",
                sprites.skills, 2,
                0
            )
        end
    end
    
    if not skillSetupDone then
        local firstChell = nil
        for _, player in ipairs(misc.players) do
            if player:isValid() then
                if isa(player, "PlayerInstance") then
                    if player:getSurvivor():getName() == "Chell" then
                        if firstChell == nil then
                            firstChell = player
                            player:setSkill(3,
                                "Portal Gun",
                                "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
                                sprites.colorSet.normal.iconSet, 1,
                                15
                            )
                            player:set("portalColor", 0)
                        else
                            firstChell:setSkill(3,
                                "Portal Gun",
                                "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
                                sprites.colorSet.atlas.iconSet, 1,
                                15
                            )
                            player:set("portalColor", 1)
                            player:setSkill(3,
                                "Portal Gun",
                                "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
                                sprites.colorSet.pbody.iconSet, 1,
                                15
                            )
                            player:set("portalColor", 2)
                        end
                    end
                end
            end
        end
        skillSetupDone = true;
    end
end)

---------------

function raytraceBullet(x, y, angle, range, portalColor, portalTurn)
    local smallObject = Object.find("EfGold"):create(0, 0)
    local currentPos = {x = 0, y = 0}
    local hit = false
    for i = 0, range do
        if not hit then
            currentPos.x = x + math.cos(angle * math.pi / 180) * i
            currentPos.y = y - math.sin(angle * math.pi / 180) * i
            if smallObject:collidesMap(currentPos.x, currentPos.y) then
                hit = true
                
                local bulletParticleInstance = bulletParticle:create(currentPos.x, currentPos.y)
                bulletParticleInstance.spriteSpeed = 0.5
                
                local portalColorSet = nil
                if portalColor == 1 then
                    portalColorSet = sprites.colorSet.atlas
                elseif portalColor == 2 then
                    portalColorSet = sprites.colorSet.pbody
                else
                    portalColorSet = sprites.colorSet.normal
                end
                
                local portalPortalSprite = nil
                if portalTurn == 2 then
                    portalPortalSprite = portalColorSet.portal2
                    bulletParticleInstance.sprite = portalColorSet.bullet2
                else
                    portalPortalSprite = portalColorSet.portal1
                    bulletParticleInstance.sprite = portalColorSet.bullet1
                end
                
                local newPortal = portalObject:create(currentPos.x, currentPos.y)
                newPortal.sprite = portalPortalSprite
                newPortal.mask = sprites.portalMask
                newPortal:set("portalColor", portalColor)
                
                if not smallObject:collidesMap(newPortal.x - 1, newPortal.y) then
                    -- sprite is facing left by default; do nothing
                    --newPortal:set("invertSpeeds", 0)
                    while smallObject:collidesMap(newPortal.x - 1, newPortal.y + (newPortal.sprite.height - newPortal.sprite.yorigin)) do
                        newPortal.y = newPortal.y - 1
                    end
                    if smallObject:collidesMap(newPortal.x - 1, newPortal.y - newPortal.sprite.yorigin) then
                        newPortal:destroy()
                    else
                        for _, otherPortal in ipairs(portalObject:findAll()) do
                            if otherPortal:isValid() then
                                if newPortal:collidesWith(otherPortal, newPortal.x, newPortal.y)
                                  and not (otherPortal:get("portalColor") == portalColor
                                  and otherPortal:get("portalTurn") == portalTurn) then
                                    newPortal:destroy()
                                    break
                                end
                            end
                        end
                    end
                elseif not smallObject:collidesMap(newPortal.x + 1, newPortal.y) then
                    bulletParticleInstance.angle = 180
                    newPortal.angle = 180
                    --newPortal:set("invertSpeeds", 0)
                    while smallObject:collidesMap(newPortal.x + 1, newPortal.y + (newPortal.sprite.height - newPortal.sprite.yorigin)) do
                        newPortal.y = newPortal.y - 1
                    end
                    if smallObject:collidesMap(newPortal.x + 1, newPortal.y - newPortal.sprite.yorigin) then
                        newPortal:destroy()
                    else
                        for _, otherPortal in ipairs(portalObject:findAll()) do
                            if otherPortal:isValid() then
                                if newPortal:collidesWith(otherPortal, newPortal.x, newPortal.y)
                                  and not (otherPortal:get("portalColor") == portalColor
                                  and otherPortal:get("portalTurn") == portalTurn) then
                                    newPortal:destroy()
                                    break
                                end
                            end
                        end
                    end
                elseif not smallObject:collidesMap(newPortal.x, newPortal.y - 1) then
                    bulletParticleInstance.angle = 270
                    newPortal.angle = 270
                    --newPortal:set("invertSpeeds", 1)
                    while smallObject:collidesMap(newPortal.x + (newPortal.sprite.width - newPortal.sprite.xorigin), newPortal.y - 1) do
                        newPortal.x = newPortal.x - 1
                    end
                    if smallObject:collidesMap(newPortal.x - newPortal.sprite.xorigin, newPortal.y - 1) then
                        newPortal:destroy()
                    else
                        for _, otherPortal in ipairs(portalObject:findAll()) do
                            if otherPortal:isValid() then
                                if newPortal:collidesWith(otherPortal, newPortal.x, newPortal.y)
                                  and not (otherPortal:get("portalColor") == portalColor
                                  and otherPortal:get("portalTurn") == portalTurn) then
                                    newPortal:destroy()
                                    break
                                end
                            end
                        end
                    end
                elseif not smallObject:collidesMap(newPortal.x, newPortal.y + 1) then
                    bulletParticleInstance.angle = 90
                    newPortal.angle = 90
                    --newPortal:set("invertSpeeds", 1)
                    while smallObject:collidesMap(newPortal.x + (newPortal.sprite.width - newPortal.sprite.xorigin), newPortal.y + 1) do
                        newPortal.x = newPortal.x - 1
                    end
                    if smallObject:collidesMap(newPortal.x - newPortal.sprite.xorigin, newPortal.y + 1) then
                        newPortal:destroy()
                    else
                        for _, otherPortal in ipairs(portalObject:findAll()) do
                            if otherPortal:isValid() then
                                if newPortal:collidesWith(otherPortal, newPortal.x, newPortal.y)
                                  and not (otherPortal:get("portalColor") == portalColor
                                  and otherPortal:get("portalTurn") == portalTurn) then
                                    newPortal:destroy()
                                    break
                                end
                            end
                        end
                    end
                end
                smallObject:delete()
                
                -- if portal managed to get placed, delete the old one
                if newPortal:isValid() then
                    for _, oldPortal in ipairs(portalObject:findAll()) do
                        if oldPortal:isValid() and oldPortal ~= newPortal then
                            if oldPortal:get("portalColor") == portalColor and oldPortal:get("portalTurn") == portalTurn then
                                oldPortal:destroy()
                                break
                            end
                        end
                    end
                    
                    -- and finally set the turn
                    newPortal:set("portalTurn", portalTurn)
                end
            end
        end
    end
    if not hit then
        smallObject:delete()
    end
end

----------------

chell:addCallback("init", function(player)
    player:set("portalColor", 0)
    player:set("portalTurn", 1)
    
    player:set("cubeDispensed", 0)
    
	player:setAnimations{
        idle =  sprites.idle,
        walk = sprites.walk,
        jump = sprites.jump,
        climb = sprites.climb,
        death = sprites.death,
        decoy = sprites.decoy
    }
    
	player:survivorSetInitialStats(120, 14, 0.01)
    
	player:setSkill(1,
		"High Energy Pellet",
        "Fires a high-velocity orb that deals 250% damage and ricochets off walls,\nhurting anything in its path. Has a chance to vaporize a target.",
		sprites.skills, 1,
		1 * 60
	)
	player:setSkill(2,
		"Companion Cube",
        "Spawns a lovingly booby-trapped cube that deals damage to enemies on impact\nbased on its velocity. Reactivate to explode, dealing 200% damage.",
		sprites.skills, 2,
		0
	)
    player:setSkill(3,
        "Portal Gun",
        "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
        sprites.skills, 3, -- temp
        15
    )
	player:setSkill(4,
		"Deploy Turret",
        "Spawn a turret that lasts 30 seconds. When in range of an enemy,\nit shoots for 50% damage per second. Can be flung.",
		sprites.skills, 4,
		20 * 60
	)
end)

chell:addCallback("levelUp", function(player)
	player:survivorLevelUpStats(24, 4, 0.002, 4)
end)

chell:addCallback("scepter", function(player)
	player:setSkill(4,
		"Deploy Opera Turret",
		[[Spawn a large turret that lasts 30 seconds. When in range of an enemy,
        it shoots for 100% damage per second. Can be flung.]],
		sprites.skills, 5,
		20 * 60
	)
end)

chell:addCallback("useSkill", function(player, skill)
    if player:get("activity") == 0 then
		if skill == 1 then
			player:survivorActivityState(1, sprites.shoot, 0.5, true, true)
		elseif skill == 2 then
			player:survivorActivityState(2, sprites.shoot, 0.1, false, false)
		elseif skill == 3 then
			player:survivorActivityState(3, sprites.shoot, 0.1, false, false)
		elseif skill == 4 then
			player:survivorActivityState(4, sprites.shoot, 0.1, false, false)
		end
		
		player:activateSkillCooldown(skill)
	end
end)

registercallback("onPlayerDeath", function(player)
    if player:getSurvivor().displayName == "Chell" then
        sounds.fizzler:play(1, 0.5)
        for _, portal in ipairs(portalObject:findAll()) do
            if portal ~= nil then
                if portal:isValid() and portal:get("portalColor") == player:get("portalColor") then
                    portal:destroy()
                end
            end
        end 
    end
end)

chell:addCallback("onSkill", function(player, skill, relevantFrame)
    if skill == 1 then
        if relevantFrame == 1 then
            local pierceThroughEnemies = 0
			-- if Heaven Cracker triggers, ignore its bullet and make sure bullet pierces enemies
            local heavenCrackerBullet = player:survivorFireHeavenCracker(0)
            if heavenCrackerBullet ~= nil then
                pierceThroughEnemies = 1
            end
            
            local dX = (player.sprite.width - player.sprite.xorigin) + 5
            if player:getFacingDirection() == 180 then
                dX = dX * -1
            end
            
            local orbInstance = highEnergyPellet:create(player.x + dX, player.y)
            orbInstance:set("direction", player:getFacingDirection())
            orbInstance:set("pierce", pierceThroughEnemies)
            orbInstance:set("damage", player:get("damage") * 2.5)
            
            -- quick fix: if spawned in a wall, make it "bounce" instantly
            if orbInstance:collidesMap(orbInstance.x, orbInstance.y) then
                orbInstance:set("bounces", 1)
                for i = 1, math.abs(2 * dX) do
                    if player:getFacingDirection() == 180 then
                        orbInstance.x = orbInstance.x + i
                    else
                        orbInstance.x = orbInstance.x - i
                    end
                    if not orbInstance:collidesMap(orbInstance.x, orbInstance.y) then
                        break
                    end
                end
                if orbInstance:collidesMap(orbInstance.x, orbInstance.y) then
                    -- player stuck in some kind of hole; destroy orb
                    orbInstance:destroy()
                else
                    sounds.hep.bounce:play(0.8 + math.random() * 0.2, 0.5)
                end
            end
        end
    elseif skill == 2 then
        if relevantFrame == 1 then
            if player:get("cubeDispensed") == 0 then
                local cube = companionCube:create(player.x, player.y)
                deployedCubesAmount = deployedCubesAmount + 1
                deployedCubes[deployedCubesAmount] = {instance = cube, player = player}
                player:set("cubeDispensed", 1)
                player:setSkill(2,
                    "Detonate Companion Cube",
                    "Detonates the dispensed cube, dealing 200% damage.",
                    objects.ccube.detonateIcon, 1,
                    60 * 7
                )
            else
                for i = 1, deployedCubesAmount do
                    local cube = deployedCubes[i]
                    if cube.player == player then
                        misc.fireExplosion(cube.instance.x, cube.instance.y, 1, 5, player:get("damage") * 2, "player", objects.ccube.explosion)
                        explosionSound:play(1, 0.5)
                        cube.instance:destroy()
                        table.remove(deployedCubes, i)
                        deployedCubesAmount = deployedCubesAmount - 1
                        break
                    end
                end
                player:set("cubeDispensed", 0)
                player:setSkill(2,
                    "Companion Cube",
                    "Spawns a lovingly booby-trapped cube that deals damage to enemies on impact\nbased on its velocity. Reactivate to explode, dealing 200% damage.",
                    sprites.skills, 2,
                    0
                )
            end
        end
    elseif skill == 3 then
        if relevantFrame == 1 then
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
            
            local portalIconsSprite = nil
            if player:get("portalColor") == 1 then
                portalIconsSprite = sprites.colorSet.atlas.iconSet
            elseif player:get("portalColor") == 2 then
                portalIconsSprite = sprites.colorSet.pbody.iconSet
            else
                portalIconsSprite = sprites.colorSet.normal.iconSet
            end
            
            raytraceBullet(player.x, player.y, playerDirection, 1000, player:get("portalColor"), player:get("portalTurn"))
            
            if player:get("portalTurn") == 1 then
                sounds.portal.blue:play(0.8 + math.random() * 0.2)
                player:set("portalTurn", 2)
                player:setSkill(3,
                    "Portal Gun",
                    "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
                    portalIconsSprite, 2,
                    15
                )
            else
                sounds.portal.orange:play(0.8 + math.random() * 0.2)
                player:set("portalTurn", 1)
                player:setSkill(3,
                    "Portal Gun",
                    "Fires one of two portals, alternating between them when fired. When both are\n placed, creates an interdimensional link between them that conserves momentum.",
                    portalIconsSprite, 1,
                    15
                )
            end
        end
    elseif skill == 4 then
        if relevantFrame == 1 then
            local turretInstance = turret:create(player.x, player.y)
            turretInstance:set("direction", player:getFacingDirection())
            if player:get("scepter") == 1 then
                turretInstance.sprite = objects.turret.opera
                turretInstance:set("damage", player:get("damage"))
                turretInstance:set("hasScepter", 1)
            else
                turretInstance.sprite = objects.turret.normal
                turretInstance:set("damage", player:get("damage") * 0.5)
                if math.random(1, 50) == 1 then -- different turret
                    turretInstance:set("action", 5)
                    turretInstance:set("animation", 600)
                    sounds.turret.different1:play(1, 0.5)
                end
            end
            turretInstance.spriteSpeed = 0
            turretInstance.alpha = 0
        end
    end
end)

registercallback("onImpact", function(bullet)
    if bullet:get("portalColor") ~= nil then
        local portalColor = bullet:get("portalColor")
        local portalTurn = bullet:get("portalTurn")
        
        local portalColorSet = nil
        if portalColor == 1 then
            portalColorSet = sprites.colorSet.atlas
        elseif portalColor == 2 then
            portalColorSet = sprites.colorSet.pbody
        else
            portalColorSet = sprites.colorSet.normal
        end
        
        local portalPortalSprite = nil
        if portalTurn == 1 then
            portalPortalSprite = portalColorSet.portal1
        else
            portalPortalSprite = portalColorSet.portal2
        end
        
        local newPortal = portalObject:create(bullet.x, bullet.y)
        newPortal.sprite = portalPortalSprite
        newPortal:set("portalTurn", portalTurn)
        newPortal:set("portalColor", portalColor)
        
        local bulletParticleInstance = bulletParticle:create(newPortal.x, newPortal.y)
        
        local smallObject = Object.find("EfGold"):create(0, 0)
        if smallObject:collidesMap(newPortal.x + 1, newPortal.y) then
            -- sprite is facing left by default; do nothing
            --newPortal:set("invertSpeeds", 0)
            while smallObject:collidesMap(newPortal.x, newPortal.y + (newPortal.sprite.height - newPortal.sprite.yorigin)) do
                newPortal.y = newPortal.y - 1
            end
            if smallObject:collidesMap(newPortal.x, newPortal.y - newPortal.sprite.yorigin) then
                newPortal:destroy()
            end
        elseif smallObject:collidesMap(newPortal.x - 1, newPortal.y) then
            bulletParticleInstance.angle = 180
            newPortal.angle = 180
            --newPortal:set("invertSpeeds", 0)
            while smallObject:collidesMap(newPortal.x, newPortal.y + (newPortal.sprite.height - newPortal.sprite.yorigin)) do
                newPortal.y = newPortal.y - 1
            end
            if smallObject:collidesMap(newPortal.x, newPortal.y - newPortal.sprite.yorigin) then
                newPortal:destroy()
            end
        elseif smallObject:collidesMap(newPortal.x, newPortal.y + 1) then
            bulletParticleInstance.angle = 270
            newPortal.angle = 270
            --newPortal:set("invertSpeeds", 1)
            while smallObject:collidesMap(newPortal.x + (newPortal.sprite.width - newPortal.sprite.xorigin), newPortal.y) do
                newPortal.x = newPortal.x - 1
            end
            if smallObject:collidesMap(newPortal.x - newPortal.sprite.xorigin, newPortal.y) then
                newPortal:destroy()
            end
        elseif smallObject:collidesMap(newPortal.x, newPortal.y - 1) then
            bulletParticleInstance.angle = 90
            newPortal.angle = 90
            --newPortal:set("invertSpeeds", 1)
            while smallObject:collidesMap(newPortal.x + (newPortal.sprite.width - newPortal.sprite.xorigin), newPortal.y) do
                newPortal.x = newPortal.x - 1
            end
            if smallObject:collidesMap(newPortal.x - newPortal.sprite.xorigin, newPortal.y) then
                newPortal:destroy()
            end
        end
        smallObject:delete()
        
        -- if portal managed to get placed, delete the old one
        if newPortal:isValid() then
            for _, oldPortal in ipairs(portalObject:findAll()) do
                if oldPortal:isValid() then
                    if oldPortal:get("portalTurn") == portalTurn then
                        oldPortal:destroy()
                        break
                    end
                end
            end
        end

    end
end)

registercallback("onGameEnd", function()
    if sounds.turret.serenade:isPlaying() then
        sounds.turret.serenade:stop()
    end
    if sounds.turret.cara_mia:isPlaying() then
        sounds.turret.cara_mia:stop()
    end 
    if sounds.radio:isPlaying() then
        sounds.radio:stop()
    end
end)