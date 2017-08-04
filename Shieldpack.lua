-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\Weapons\Shieldpack.lua
--
--    Created by:   Andreas Urwalek (a_urwa@sbox.tugraz.at)
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/ScriptActor.lua")
Script.Load("lua/Mixins/ModelMixin.lua")
Script.Load("lua/TeamMixin.lua")
Script.Load("lua/PickupableMixin.lua")
Script.Load("lua/SelectableMixin.lua")

class 'Shieldpack' (ScriptActor)

Shieldpack.kMapName = "shieldpack"

-- TODO: add physic geometry to a seperate "pick up jetpack" model, otherwise the jetpack will not move to the ground (alternatively we can change the comm dropheight for this entity for 0)
Shieldpack.kModelName = PrecacheAsset("models/marine/jetpack/jetpack.model")

Shieldpack.kEmptySound = PrecacheAsset("sound/NS2.fev/marine/common/jetpack_empty")

Shieldpack.kThinkInterval = .5

local networkVars = { }

AddMixinNetworkVars(BaseModelMixin, networkVars)
AddMixinNetworkVars(ModelMixin, networkVars)
AddMixinNetworkVars(TeamMixin, networkVars)
AddMixinNetworkVars(SelectableMixin, networkVars)

function Shieldpack:OnCreate()

    ScriptActor.OnCreate(self)
    
    InitMixin(self, BaseModelMixin)
    InitMixin(self, ModelMixin)
    InitMixin(self, TeamMixin)
    InitMixin(self, SelectableMixin)
    
    InitMixin(self, PickupableMixin, { kRecipientType = "Marine" })
    
end

function Shieldpack:OnInitialized()

    ScriptActor.OnInitialized(self)    
    self:SetModel(Shieldpack.kModelName)
    
    local coords = self:GetCoords()

    self.jetpackBody = Shared.CreatePhysicsSphereBody(false, 0.4, 0, coords)
    self.jetpackBody:SetCollisionEnabled(true)    
    self.jetpackBody:SetGroup(PhysicsGroup.WeaponGroup)    
    self.jetpackBody:SetEntity(self)
    
end

function Shieldpack:OnDestroy() 

    ScriptActor.OnDestroy(self)

end

function Shieldpack:OnTouch(recipient)    
end

-- only give jetpacks to standard marines
function Shieldpack:GetIsValidRecipient(recipient)
    return not recipient:isa("JetpackMarine") and not recipient:isa("Exo") and not recipient:isa("ShieldpackMarine")
end

function Shieldpack:GetIsPermanent()
    return true
end  

function Shieldpack:GetCanBeUsed(player, useSuccessTable)
    useSuccessTable.useSuccess = self:GetIsValidRecipient(player)      
end  

function Shieldpack:_GetNearbyRecipient()
end

if Server then
    
    function Shieldpack:OnUseDeferred()
        
        local player = self.useRecipient 
        self.useRecipient = nil
        
        if player and not player:GetIsDestroyed() and self:GetIsValidRecipient(player) then
            
            player:GiveShieldpack()
            self:TriggerEffects("pickup")
            DestroyEntity(self)
            
        end
    
    end

    function Shieldpack:OnUse(player, elapsedTime, useSuccessTable)
    
        if self:GetIsValidRecipient( player ) and ( not self.useRecipient or self.useRecipient:GetIsDestroyed() ) then
            
            self.useRecipient = player
            self:AddTimedCallback( self.OnUseDeferred, 0 )
            
        end
        
    end
    
end

Shared.LinkClassToMap("Shieldpack", Shieldpack.kMapName, networkVars)