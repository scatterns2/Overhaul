-- ======= Copyright (c) 2003-2012, Unknown Worlds Entertainment, Inc. All rights reserved. =======        
--        
-- lua\BalanceHealth.lua        
--        
--    Created by:   Charlie Cleveland (charlie@unknownworlds.com)            
--        
-- ========= For more information, visit us at http://www.unknownworlds.com =====================        

--Time interval allowed for healing to be clamped
kHealingClampInterval = 2
kHealingClampMaxHPAmount = 0.2
kHealingClampReductionScalar = 0.2

-- HEALTH AND ARMOR        
kMarineHealth = 100    kMarineArmor = 30    kMarinePointValue = 5
kJetpackHealth = 100    kJetpackArmor = 30    kJetpackPointValue = 10
kExosuitHealth = 100    kExosuitArmor = 320    kExosuitPointValue = 20

--Medpack
kMedpackHeal = 25
kMedpackPickupDelay = 0.45
kMarineRegenerationHeal = 25 --Amount of hp per second

kLayMinesPointValue = 2
kGrenadeLauncherPointValue = 10
kShotgunPointValue = 10
kHeavyMachineGunValue = 15
kFlamethrowerPointValue = 7

kMinigunPointValue = 10
kRailgunPointValue = 10
        
kSkulkHealth = 85    kSkulkArmor = 15    kSkulkPointValue = 5    kSkulkHealthPerBioMass = 0
kGorgeHealth = 180   kGorgeArmor = 75    kGorgePointValue = 7    kGorgeHealthPerBioMass = 0
kLerkHealth = 175    kLerkArmor = 45     kLerkPointValue = 15    kLerkHealthPerBioMass = 0
kFadeHealth = 250    kFadeArmor = 80     kFadePointValue = 20    kFadeHealthPerBioMass = 0
kOnosHealth = 500    kOnosArmor = 250    kOnosPointValue = 30    kOnosHealtPerBioMass = 0

kMarineWeaponHealth = 400
        
kEggHealth = 350    kEggArmor = 0    kEggPointValue = 1
kMatureEggHealth = 400    kMatureEggArmor = 0

kBabblerHealth = 10    kBabblerArmor = 0    kBabblerPointValue = 0
kBabblerEggHealth = 300    kBabblerEggArmor = 0    kBabblerEggPointValue = 0
        
kArmorPerUpgradeLevel = 20
kExosuitArmorPerUpgradeLevel = 30
kArmorHealScalar = 1 -- 0.75

kParasitePlayerPointValue = 1
kBuildPointValue = 5
kRecyclePaybackScalar = 0.75

kCarapaceHealReductionPerLevel = 0.0

kSkulkArmorFullyUpgradedAmount = 40
kGorgeArmorFullyUpgradedAmount = 140
kLerkArmorFullyUpgradedAmount = 90
kFadeArmorFullyUpgradedAmount = 160
kOnosArmorFullyUpgradedAmount = 450

kSkulkCelerityArmorReduction = 15
kGorgeCelerityArmorReduction = 40
kLerkCelerityArmorReduction = 15
kFadeCelerityArmorReduction = 40
kOnosCelerityArmorReduction = 150

kSkulkCombinedArmor = 20
kGorgeCombinedArmor = 85
kLerkCombinedArmor = 55
kFadeCombinedArmor = 90
kOnosCombinedArmor = 300

kBalanceInfestationHurtPercentPerSecond = 2
kMinHurtPerSecond = 20

-- used for structures
kStartHealthScalar = 0.3

kArmoryHealth = 1800    kArmoryArmor = 300    kArmoryPointValue = 5
kAdvancedArmoryHealth = 3000    kAdvancedArmoryArmor = 500    kAdvancedArmoryPointValue = 10
kCommandStationHealth = 3000    kCommandStationArmor = 1500    kCommandStationPointValue = 20
kObservatoryHealth = 700    kObservatoryArmor = 500    kObservatoryPointValue = 10
kPhaseGateHealth = 1500    kPhaseGateArmor = 800    kPhaseGatePointValue = 10
kRoboticsFactoryHealth = 2800    kRoboticsFactoryArmor = 600    kRoboticsFactoryPointValue = 5
kARCRoboticsFactoryHealth = 2800    kARCRoboticsFactoryArmor = 600    kARCRoboticsFactoryPointValue = 7
kPrototypeLabHealth = 3000    kPrototypeLabArmor = 500    kPrototypeLabPointValue = 20
kInfantryPortalHealth = 1525    kInfantryPortalArmor = 500    kInfantryPortalPointValue = 10
kArmsLabHealth = 1650    kArmsLabArmor = 500    kArmsLabPointValue = 15
kSentryBatteryHealth = 600    kSentryBatteryArmor = 200    kSentryBatteryPointValue = 5

-- 5000/1000 is good average (is like 7,000 health from NS1)
kHiveHealth = 4000    kHiveArmor = 750    kHivePointValue = 30
kBioMassUpgradePointValue = 10 kUgradedHivePointValue = 5
kMatureHiveHealth = 6000 kMatureHiveArmor = 1400
        
kDrifterHealth = 300    kDrifterArmor = 20    kDrifterPointValue = 5
kMACHealth = 300    kMACArmor = 50    kMACPointValue = 2
kMineHealth = 20    kMineArmor = 5    kMinePointValue = 1
        
kExtractorHealth = 2400 kExtractorArmor = 1050 kExtractorPointValue = 15
kExtractorArmorAddAmount = 700 -- not used

-- (2500 = NS1)
kHarvesterHealth = 2000 kHarvesterArmor = 200 kHarvesterPointValue = 15
kMatureHarvesterHealth = 2300 kMatureHarvesterArmor = 320

kSentryHealth = 500    kSentryArmor = 100    kSentryPointValue = 2
kARCHealth = 2000    kARCArmor = 500    kARCPointValue = 5
kARCDeployedHealth = 2000    kARCDeployedArmor = 0
        
kShellHealth = 600     kShellArmor = 150     kShellPointValue = 12
kMatureShellHealth = 700     kMatureShellArmor = 200

kCragHealth = 600    kCragArmor = 200    kCragPointValue = 10
kMatureCragHealth = 700    kMatureCragArmor = 340    kMatureCragPointValue = 10
        
kWhipHealth = 650    kWhipArmor = 175    kWhipPointValue = 10
kMatureWhipHealth = 720    kMatureWhipArmor = 240    kMatureWhipPointValue = 10
        
kSpurHealth = 800     kSpurArmor = 50     kSpurPointValue = 12
kMatureSpurHealth = 900  kMatureSpurArmor = 100  kMatureSpurPointValue = 12

kShiftHealth = 750    kShiftArmor = 75    kShiftPointValue = 10
kMatureShiftHealth = 1100    kMatureShiftArmor = 150    kMatureShiftPointValue = 10

kVeilHealth = 900     kVeilArmor = 0     kVeilPointValue = 12
kMatureVeilHealth = 1100     kMatureVeilArmor = 0     kVeilPointValue = 12

kShadeHealth = 750    kShadeArmor = 0    kShadePointValue = 10
kMatureShadeHealth = 1500    kMatureShadeArmor = 0    kMatureShadePointValue = 10

kHydraHealth = 350    kHydraArmor = 10    kHydraPointValue = 2
kMatureHydraHealth = 450    kMatureHydraArmor = 50    kMatureHydraPointValue = 2

kClogHealth = 250  kClogArmor = 0 kClogPointValue = 0
kWebHealth = 50

kCystHealth = 30    kCystArmor = 0
kMatureCystHealth = 450    kMatureCystArmor = 0    kCystPointValue = 1
kMinMatureCystHealth = 200 kMinCystScalingDistance = 48 kMaxCystScalingDistance = 168

kBoneWallHealth = 100 kBoneWallArmor = 0    kBoneWallHealthPerBioMass = 100
kContaminationHealth = 1000 kContaminationArmor = 0    kContaminationPointValue = 2

kPowerPointHealth = 2000    kPowerPointArmor = 1000    kPowerPointPointValue = 10
kDoorHealth = 2000    kDoorArmor = 1000    kDoorPointValue = 0

kTunnelEntranceHealth = 1000    kTunnelEntranceArmor = 100    kTunnelEntrancePointValue = 5
kMatureTunnelEntranceHealth = 1250    kMatureTunnelEntranceArmor = 200


