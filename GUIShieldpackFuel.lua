-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\GUIShieldpackFuel.lua
--
-- Created by: Andreas Urwalek (a_urwa@sbox.tugraz.at)
--
-- Manages the marine buy/purchase menu.
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

class 'GUIShieldpackFuel' (GUIScript)

GUIShieldpackFuel.kJetpackFuelTexture = "ui/marine_jetpackfuel.dds"


GUIShieldpackFuel.kFont = Fonts.kMicrogrammaDMedExt_Medium

GUIShieldpackFuel.kBgCoords = {0, 0, 32, 144}

GUIShieldpackFuel.kBarCoords = {39, 10, 39 + 18, 10 + 123}

GUIShieldpackFuel.kFuelBlueIntensity = .8

GUIShieldpackFuel.kBackgroundColor = Color(0, 0, 0, 0.5)
GUIShieldpackFuel.kFuelBarOpacity = 0.8

local function UpdateItemsGUIScale(self)
    GUIShieldpackFuel.kBackgroundWidth = GUIScale(32)
    GUIShieldpackFuel.kBackgroundHeight = GUIScale(144)
    GUIShieldpackFuel.kBackgroundOffsetX = GUIScale(30)
    GUIShieldpackFuel.kBackgroundOffsetY = GUIScale(-240)

    GUIShieldpackFuel.kBarWidth = GUIScale(20)
    GUIShieldpackFuel.kBarHeight = GUIScale(123)
end

function GUIShieldpackFuel:Initialize()    
    
    -- jetpack fuel display background
    
    UpdateItemsGUIScale(self)
    
    self.background = GUIManager:CreateGraphicItem()
    self.background:SetSize( Vector(GUIShieldpackFuel.kBackgroundWidth, GUIShieldpackFuel.kBackgroundHeight, 0) )
    self.background:SetPosition(Vector(GUIShieldpackFuel.kBackgroundWidth / 2 + GUIShieldpackFuel.kBackgroundOffsetX, -GUIShieldpackFuel.kBackgroundHeight / 2 + GUIShieldpackFuel.kBackgroundOffsetY, 0))
    self.background:SetAnchor(GUIItem.Left, GUIItem.Bottom) 
    self.background:SetLayer(kGUILayerPlayerHUD)
    self.background:SetTexture(GUIShieldpackFuel.kJetpackFuelTexture)
    self.background:SetTexturePixelCoordinates(unpack(GUIShieldpackFuel.kBgCoords))
    
    -- fuel bar
    
    self.fuelBar = GUIManager:CreateGraphicItem()
    self.fuelBar:SetAnchor(GUIItem.Middle, GUIItem.Bottom)
    self.fuelBar:SetPosition( Vector(-GUIShieldpackFuel.kBarWidth / 2, -GUIScale(10), 0))
    self.fuelBar:SetTexture(GUIShieldpackFuel.kJetpackFuelTexture)
    self.fuelBar:SetTexturePixelCoordinates(unpack(GUIShieldpackFuel.kBarCoords))
 
    self.background:AddChild(self.fuelBar)
    
    self.visible = true
    
    self:Update(0)
    
end

function GUIShieldpackFuel:SetIsVisible(state)
    
    self.visible = state
    
    self.background:SetIsVisible(state)
    
end

function GUIShieldpackFuel:GetIsVisible()
    
    return self.visible
    
end

function GUIShieldpackFuel:SetFuel(fraction)

    self.fuelBar:SetSize( Vector(GUIShieldpackFuel.kBarWidth, -GUIShieldpackFuel.kBarHeight * (fraction), 0) )
    self.fuelBar:SetColor( Color(1 - (fraction) * GUIShieldpackFuel.kFuelBlueIntensity, 
                                 GUIShieldpackFuel.kFuelBlueIntensity * (fraction) * 0.8 , 
                                 GUIShieldpackFuel.kFuelBlueIntensity * (fraction) ,
                                 GUIShieldpackFuel.kFuelBarOpacity) )

end

function GUIShieldpackFuel:OnResolutionChanged(oldX, oldY, newX, newY)
    UpdateItemsGUIScale(self)
    
    self:Uninitialize()
    self:Initialize()
end

	
function GUIShieldpackFuel:Update(deltaTime)
    
    PROFILE("GUIShieldpackFuel:Update")
    
    local player = Client.GetLocalPlayer()
    
    if player and player.GetShieldCharge and player.GetShieldCapacity  then
        self:SetFuel(player:GetShieldCharge()/player:GetShieldCapacity())
		--Print("Charge %s", player:GetShieldCharge())
    end

end



function GUIShieldpackFuel:Uninitialize()

    GUI.DestroyItem(self.fuelBar)
    GUI.DestroyItem(self.background)

end

