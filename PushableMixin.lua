-- Onos push mod
-- lua\PushableMixin.lua
-- by twiliteblue

PushableMixin = CreateMixin( PushableMixin )
PushableMixin.type = "Pushable"

local kDefaultForce = 5
local kDefaultDuration = 0.1
local kMaxForce = 45 --max speed allowed ingame

PushableMixin.optionalCallbacks =
{
}

PushableMixin.networkVars =
{
    pushed = "compensated boolean",
	pushVelocity = "compensated vector",
	timePushDamaged = "time"
}

function PushableMixin:__initmixin()

	self.pushed = false	
	self.pushVelocity = Vector(0, 0, 0)
	self.timePushDamaged = 0
	if Server then
		self.timePushEnds = 0
	end

end

function PushableMixin:GetIsPushed()
    return self.pushed
end

local function SharedUpdate(self)

    local wasPushed = self.pushed
	if Server then
		self.pushed = self.timePushEnds > Shared.GetTime()
	end
    
    if wasPushed and not self.pushed and self.OnPushedEnd then
        self:OnPushedEnd()
    end
	
end

if Server then

    function PushableMixin:ForcePush(newForce, duration, override)
	
	    if newForce:GetLength() >= 0.01 then
            local pushDuration = duration or kDefaultDuration		
            local newVelocity = Vector(0, 0, 0)
            local canPush = false

            if override == true then
                canPush = true
                newVelocity = newForce
            elseif not self.pushed then
                canPush = true
                newVelocity = self.pushVelocity + newForce
            end
		
            if newVelocity:GetLengthSquared() > kMaxForce * kMaxForce then
                newVelocity:Scale(kMaxForce/newVelocity:GetLength())
            end
		
		    if canPush and pushDuration > 0 then
			    self:DisableGroundMove(pushDuration)
			    self.pushed = true
			    self.pushVelocity = newVelocity
			    self.timePushEnds = Shared.GetTime() + pushDuration
                self:SetVelocity(self.pushVelocity)
            end
		end

	
    end

    function PushableMixin:PushDamage()
        self.timePushDamaged = Shared.GetTime()
    end

    function PushableMixin:OnUpdate(deltaTime)
        PROFILE("PushableMixin:OnUpdate")
        SharedUpdate(self)
    end
	    
end

function PushableMixin:OnProcessMove(input)

    SharedUpdate(self)
        
end