-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\ShieldpackMarine.lua
--
--    Created by:   Andreas Urwalek (a_urwa@sbox.tugraz.at
--
--    Thanks to twiliteblue for initial input.
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================
Script.Load("lua/Marine.lua")
Script.Load("lua/Shieldpack.lua")

class 'ShieldpackMarine' (Marine)

PrecacheAsset("cinematics/vfx_materials/nanoshield.surface_shader")
PrecacheAsset("cinematics/vfx_materials/nanoshield_view.surface_shader")
PrecacheAsset("cinematics/vfx_materials/nanoshield_exoview.surface_shader")

local kNanoShieldStartSound = PrecacheAsset("sound/NS2.fev/marine/commander/nano_shield_3D")
local kNanoLoopSound = PrecacheAsset("sound/NS2.fev/marine/commander/nano_loop")
local kNanoDamageSound = PrecacheAsset("sound/NS2.fev/marine/commander/nano_damage")

local kNanoshieldMaterial = PrecacheAsset("cinematics/vfx_materials/nanoshield.material")
local kNanoshieldExoViewMaterial = PrecacheAsset("cinematics/vfx_materials/nanoshield_exoview.material")
local kNanoshieldViewMaterial = PrecacheAsset("cinematics/vfx_materials/nanoshield_view.material")


ShieldpackMarine.kMapName = "shieldpackmarine"

ShieldpackMarine.kModelName = PrecacheAsset("models/marine/male/male.model")


ShieldpackMarine.kShieldpackPickupSound = PrecacheAsset("sound/NS2.fev/marine/common/pickup_jetpack")

ShieldpackMarine.kShieldpackNode = "ShieldPack"

kShieldCapacity = 100
kShieldCapacityUpgrade = 100
kShieldPackDamageReduction = 0 --0 = 100%
kShieldRecharge = 10
kShieldRechargeUpgrade = 10

kCombatDuration = 5
kCombatDurationUpgrade = 2.5



if Server then
    Script.Load("lua/ShieldpackMarine_Server.lua")
end

local networkVars =
{
   shieldCharge = "float (0 to 300 by 1)",
   shieldMaxCapacity = "float (0 to 300 by 1)",
   isShieldEmpty = "boolean",
   lastHitTime = "time"
}

function ShieldpackMarine:OnCreate()

    Marine.OnCreate(self)
	
	self.shieldCharge = self:GetShieldCapacity()
	self.shieldMaxCapacity = self:GetShieldCapacity()
    self.isShieldEmpty = false
	self.lastTimeHit = 0	
    self.isInCombat = false

    
end

local function InitEquipment(self)

    assert(Server)  
    
	if Server then
        
            assert(self.shieldLoopSound == nil)
            self.shieldLoopSound = Server.CreateEntity(SoundEffect.kMapName)
            self.shieldLoopSound:SetAsset(kNanoLoopSound)
            self.shieldLoopSound:SetParent(self)
            self.shieldLoopSound:Start()
            
            StartSoundEffectOnEntity(kNanoShieldStartSound, self)
            
	end    
end

function ShieldpackMarine:OnInitialized()


    Marine.OnInitialized(self)
    
    if Server then
       InitEquipment(self)
    end
    
end

function ShieldpackMarine:OnDestroy()

    Marine.OnDestroy(self)
    
	if self.shieldDisplayUI then
		Client.DestroyGUIView(self.shieldDisplayUI)
		self.shieldDisplayUI = nil
	end
	
    self.equipmentId = Entity.invalidId
    
end

function ShieldpackMarine:GetHasEquipment()
    return true
end

function ShieldpackMarine:GetHasCapacityUpgrade()

		if GetHasTech(self, kTechId.ShieldCapacityTech, true) then
			return kShieldCapacityUpgrade
		else
			return 0			
		end
	
end

function ShieldpackMarine:GetHasRechargeUpgrade()

		if GetHasTech(self, kTechId.ShieldRechargeTech, true) then
			return kShieldRechargeUpgrade
		else
			return 0			
		end
	
end

function ShieldpackMarine:GetHasCombatDurationUpgrade()

		if GetHasTech(self, kTechId.ShieldRechargeTech, true) then
			return kCombatDurationUpgrade
		else
			return 0			
		end
	
end

function ShieldpackMarine:GetShieldCapacity()

	self.shieldMaxCapacity = kShieldCapacity + self:GetHasCapacityUpgrade()

	return self.shieldMaxCapacity
end

function ShieldpackMarine:GetShieldRecharge()

	return kShieldRecharge + self:GetHasRechargeUpgrade()
end

function ShieldpackMarine:GetCombatDuration()

	return kCombatDuration - self:GetHasCombatDurationUpgrade()
end

function ShieldpackMarine:GetShieldpack()

    if Server then
    
        -- There is a case where this function is called after the ShieldpackMarine has been
        -- destroyed but we don't have reproduction steps.
        if not self:GetIsDestroyed() and self.equipmentId == Entity.invalidId then
            InitEquipment(self)
        end
        
        -- Help us track down this problem.
        if self:GetIsDestroyed() then
        
            DebugPrint("Warning - ShieldpackMarine:GetShieldpack() was called after the ShieldpackMarine was destroyed")
            DebugPrint(Script.CallStack())
            
        end
        
    end

    return Shared.GetEntity(self.equipmentId)
    
end

function ShieldpackMarine:OnEntityChange(oldId, newId)

    if oldId == self.equipmentId and newId then
        self.equipmentId = newId
    end

end

function ShieldpackMarine:GetWeaponName()

    local currentWeapon = self:GetActiveWeaponName()
    
    if currentWeapon then
        return string.lower(currentWeapon)
    else
        return nil
    end
    
end

function ShieldpackMarine:UpdateShieldCharge(damageTable)
	
	if self.shieldCharge == 0 then
		self.isShieldEmpty	= true
		--Print("Empty %s", self.isShieldEmpty)
	else
		self.isShieldEmpty = false
		--Print("Empty %s", self.isShieldEmpty)
	end
	
	if not self.isShieldEmpty then
		self.shieldCharge = Clamp(self.shieldCharge - damageTable.damage, 0, self:GetShieldCapacity())
		self.lastHitTime = Shared.GetTime()
		--
	end
	
end
	
function ShieldpackMarine:ModifyDamageTaken(damageTable, attacker, doer, damageType, hitPoint)
    	
	self:UpdateShieldCharge(damageTable)
		
    if not self.isShieldEmpty then
       damageTable.damage = damageTable.damage * kShieldPackDamageReduction
	   StartSoundEffectAtOrigin(kNanoDamageSound, self:GetOrigin())
	end
end

function ShieldpackMarine:OnUpdatePlayer(deltaTime)    

	if self.shieldCharge < self:GetShieldCapacity() and not (Shared.GetTime() < self.lastHitTime + self:GetCombatDuration()) then
		self.shieldCharge = Clamp(self.shieldCharge + self:GetShieldRecharge() * deltaTime, 0, self:GetShieldCapacity())
		
		
	end


end

local function UpdateClientNanoShieldEffects(self)

    assert(Client)
    
    if not self.isShieldEmpty and self:GetIsAlive() then
        self:_CreateEffect()
    else
        self:_RemoveEffect() 
    end
    
end


function ShieldpackMarine:OnUpdateRender()
	
	if Client and not Shared.GetIsRunningPrediction() then
        UpdateClientNanoShieldEffects(self)
    end
    
    local parent = self:GetParent()
    if parent and parent:GetIsLocalPlayer() then
        local shieldDisplayUI = self.shieldDisplayUI
        if not shieldDisplayUI then
            shieldDisplayUI:Load("lua/GUIShieldpackFuel.lua")
            self.shieldDisplayUI = shieldDisplayUI
        end

      
    end
end



function ShieldpackMarine:GetShieldCharge()
	
	return self.shieldCharge
end

if Client then

    -- Adds the material effect to the entity and all child entities (hat have a Model mixin)
    local function AddEffect(entity, material, viewMaterial, entities)
    
        local numChildren = entity:GetNumChildren()
        
        if HasMixin(entity, "Model") then
            local model = entity._renderModel
            if model ~= nil then
                if model:GetZone() == RenderScene.Zone_ViewModel then
                    model:AddMaterial(viewMaterial)
                else
                    model:AddMaterial(material)
                end
                table.insert(entities, entity:GetId())
            end
        end
        
        for i = 1, entity:GetNumChildren() do
            local child = entity:GetChildAtIndex(i - 1)
            AddEffect(child, material, viewMaterial, entities)
        end
    
    end
    
    local function RemoveEffect(entities, material, viewMaterial)
    
        for i =1, #entities do
            local entity = Shared.GetEntity( entities[i] )
            if entity ~= nil and HasMixin(entity, "Model") then
                local model = entity._renderModel
                if model ~= nil then
                    if model:GetZone() == RenderScene.Zone_ViewModel then
                        model:RemoveMaterial(viewMaterial)
                    else
                        model:RemoveMaterial(material)
                    end
                end                    
            end
        end
        
    end

    function NanoShieldMixin:_CreateEffect()
   
        if not self.nanoShieldMaterial then
        
            local material = Client.CreateRenderMaterial()
            material:SetMaterial(kNanoshieldMaterial)

            local viewMaterial = Client.CreateRenderMaterial()
            
         
            viewMaterial:SetMaterial(kNanoshieldViewMaterial)
              
            
            self.nanoShieldEntities = {}
            self.nanoShieldMaterial = material
            self.nanoShieldViewMaterial = viewMaterial
            AddEffect(self, material, viewMaterial, self.nanoShieldEntities)
            
        end    
        
    end

    function NanoShieldMixin:_RemoveEffect()

        if self.nanoShieldMaterial then
            RemoveEffect(self.nanoShieldEntities, self.nanoShieldMaterial, self.nanoShieldViewMaterial)
            Client.DestroyRenderMaterial(self.nanoShieldMaterial)
            Client.DestroyRenderMaterial(self.nanoShieldViewMaterial)
            self.nanoShieldMaterial = nil
            self.nanoShieldViewMaterial = nil
            self.nanoShieldEntities = nil
        end            

    end
    
end

Shared.LinkClassToMap("ShieldpackMarine", ShieldpackMarine.kMapName, networkVars, true)