-- ======= Copyright (c) 2003-2012, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\Globals.lua
--
--    Created by:   Charlie Cleveland (charlie@unknownworlds.com)
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/Utility.lua")
Script.Load("lua/GUIAssets.lua")

kMaxPlayerSkill = 3000
kMaxPlayerLevel = 300

kSuicideDelay = 6

kDecalMaxLifetime = 60

-- All the layouts are based around this screen height.
kBaseScreenHeight = 1080

-- Team types - corresponds with teamNumber in editor_setup.xml
kNeutralTeamType = 0
kMarineTeamType = 1
kAlienTeamType = 2
kRandomTeamType = 3

-- only allow reseting the game in the first 3 minutes
-- after 7 minutes players are allowed to give up a round
-- was 5 minutes prior to Feb 07, 2013 (bumped to 10 for an unknown reason)
-- was 10 minutes prior to Nov 08, 2014 (decreased to 7 because many games are over by the time fades come out and were using the resetgame vote to get around this)
kMaxTimeBeforeReset = 3 * 60
kMinTimeBeforeConcede = 7 * 60
kPercentNeededForVoteConcede = 0.75

-- Team colors
kMarineFontName = Fonts.kAgencyFB_Large
kMarineFontColor = Color(0.756, 0.952, 0.988, 1)

kAlienFontName = Fonts.kAgencyFB_Large
kAlienFontColor = Color(0.901, 0.623, 0.215, 1)

kNeutralFontName = Fonts.kAgencyFB_Large
kNeutralFontColor = Color(0.7, 0.7, 0.7, 1)

kSteamFriendColor = Color(1, 1, 1, 1)

-- Move hit effect slightly off surface we hit so particles don't penetrate. In meters.
kHitEffectOffset = 0.13
-- max distance of blood from impact point to nearby geometry
kBloodDistance = 3.5

kCommanderPingDuration = 15

kCommanderColor = 0xFFFF00
kCommanderColorFloat = Color(1,1,0,1)
kMarineTeamColor = 0x4DB1FF
kMarineTeamColorFloat = Color(0.302, 0.859, 1)
kAlienTeamColor = 0xFFCA3A
kAlienTeamColorFloat = Color(1, 0.792, 0.227)
kNeutralTeamColor = 0xEEEEEE
kChatPrefixTextColor = 0xFFFFFF
kChatTextColor = { [kNeutralTeamType] = kNeutralFontColor,
                   [kMarineTeamType] = kMarineFontColor,
                   [kAlienTeamType] = kAlienFontColor }
kNewPlayerColor = 0x00DC00
kNewPlayerColorFloat = Color(0, 0.862, 0, 1)
kChatTypeTextColor = 0xDD4444
kFriendlyColor = 0xFFFFFF
kNeutralColor = 0xAAAAFF
kEnemyColor = 0xFF0000
kParasitedTextColor = 0xFFEB7F

kParasiteColor = Color(1, 1, 0, 1)
kPoisonedColor = Color(0, 1, 0, 1)

kCountDownLength = 6

-- Team numbers and indices
kTeamInvalid = -1
kTeamReadyRoom = 0
kTeam1Index = 1
kTeam2Index = 2
kSpectatorIndex = 3

-- Marines vs. Aliens
kTeam1Type = kMarineTeamType
kTeam2Type = kAlienTeamType

-- Used for playing team and scoreboard
kTeam1Name = "Frontiersmen"
kTeam2Name = "Kharaa"
kSpectatorTeamName = "Ready room"
kDefaultPlayerName = "NSPlayer"

kDefaultWaypointGroup = "GroundWaypoints"
kAirWaypointsGroup = "AirWaypoints"

kMaxResources = 200

-- Max number of entities allowed in radius. Don't allow creating any more entities if this number is rearched.
-- Don't include players in count.
kMaxEntitiesInRadius = 25
kMaxEntityRadius = 15

kWorldMessageLifeTime = 1.0
kCommanderErrorMessageLifeTime = 2.0
kWorldMessageResourceOffset = Vector(0, 2.5, 0)
kResourceMessageRange = 35
kWorldDamageNumberAnimationSpeed = 800
-- Updating messages with new numbers shouldn't reset animation - keep it big and faded-in intead of growing
kWorldDamageRepeatAnimationScalar = .1

-- Max player name
kMaxNameLength = 20
kMaxScore = 9999
kMaxKills = 254
kMaxDeaths = 254
kMaxPing = 999

kMaxChatLength = 120

kMaxHotkeyGroups = 9

-- Surface list. Add more materials here to precache ricochets, bashes, footsteps, etc
-- Used with PrecacheMultipleAssets
kSurfaceList = { "door", "electronic", "metal", "organic", "rock", "thin_metal", "membrane", "armor", "flesh", "flame", "infestation", "glass" }
kSurfaces = enum(kSurfaceList)

-- a longer surface list, for hiteffects only (used by hiteffects network message, don't remove any values)
kHitEffectSurface = enum( { "metal", "door", "electronic", "organic", "rock", "thin_metal", "membrane", "armor", "flesh", "flame", "infestation", "glass", "ethereal", "flame", "hallucination", "umbra", "nanoshield" } )
kHitEffectRelevancyDistance = 40
kHitEffectMaxPosition = 1638 -- used for precision in hiteffect message
kTracerSpeed = 115
kMaxHitEffectsPerSecond = 25

kMainMenuFlash = "ui/main_menu.swf"

kPlayerStatus = enum( { "Hidden", "Dead", "Evolving", "Embryo", "Commander", "Exo", "GrenadeLauncher", "Rifle", "HeavyMachineGun", "Shotgun", "Flamethrower", "Void", "Spectator", "Skulk", "Gorge", "Fade", "Lerk", "Onos", "SkulkEgg", "GorgeEgg", "FadeEgg", "LerkEgg", "OnosEgg" } )
kPlayerCommunicationStatus = enum( {'None', 'Voice', 'Typing', 'Menu'} )
kSpectatorMode = enum( { 'FreeLook', 'Overhead', 'Following', 'FirstPerson', 'KillCam' } )

kMaxAlienAbilities = 3

kNoWeaponSlot = 0
-- Weapon slots (marine only). Alien weapons use just regular numbers.
kPrimaryWeaponSlot = 1
kSecondaryWeaponSlot = 2
kTertiaryWeaponSlot = 3

-- How long to display weapon picker after selecting weapons
kDisplayWeaponTime = 1.5

-- Death message indices
kDeathMessageIcon = enum( { 'None', 
                            'Rifle', 'RifleButt', 'Pistol', 'Axe', 'Shotgun',
                            'Flamethrower', 'ARC', 'Grenade', 'Sentry', 'Welder',
                            'Bite', 'HydraSpike', 'Spray', 'Spikes', 'Parasite',
                            'SporeCloud', 'Swipe', 'BuildAbility', 'Whip', 'BileBomb',
                            'Mine', 'Gore', 'Spit', 'Jetpack', 'Claw',
                            'Minigun', 'Vortex', 'LerkBite', 'Umbra', 
                            'Xenocide', 'Blink', 'Leap', 'Stomp',
                            'Consumed', 'GL', 'Recycled', 'Babbler', 'Railgun', 'BabblerAbility', 'GorgeTunnel', 'BoneShield',
                            'ClusterGrenade', 'GasGrenade', 'PulseGrenade', 'Stab', 'WhipBomb', 'Metabolize', 'Crush', 'EMPBlast', 'HeavyMachineGun','Shieldpack'
                            } )

kMinimapBlipType = enum( { 'Undefined', 'TechPoint', 'ResourcePoint', 'Scan', 'EtherealGate', 'HighlightWorld',
                           'Sentry', 'CommandStation',
                           'Extractor', 'InfantryPortal', 'Armory', 'AdvancedArmory', 'PhaseGate', 'Observatory',
                           'RoboticsFactory', 'ArmsLab', 'PrototypeLab',
                           'Hive', 'Harvester', 'Hydra', 'Egg', 'Embryo', 'Crag', 'Whip', 'Shade', 'Shift', 'Shell', 'Veil', 'Spur', 'TunnelEntrance', 'BoneWall',
                           'Marine', 'JetpackMarine', 'Exo', 'Skulk', 'Lerk', 'Onos', 'Fade', 'Gorge',
                           'Door', 'PowerPoint', 'DestroyedPowerPoint', 'UnsocketedPowerPoint', 
                           'BlueprintPowerPoint', 'ARC', 'Drifter', 'MAC', 'Infestation', 'InfestationDying', 'MoveOrder', 'AttackOrder', 'BuildOrder', 'SensorBlip', 'SentryBattery','ShieldpackMarine' } )

-- Friendly IDs
-- 0 = friendly
-- 1 = enemy
-- 2 = neutral
-- for spectators is used Marine and Alien
kMinimapBlipTeam = enum( {'Friendly', 'Enemy', 'Neutral', 'Alien', 'Marine', 'FriendAlien', 'FriendMarine', 'InactiveAlien', 'InactiveMarine' } )

-- How long commander alerts should last (from NS1)
kAlertExpireTime = 20

-- Bit mask table for non-stackable game effects. OnInfestation is set if we're on ANY infestation (regardless of team).
-- Always keep "Max" as last element.
kGameEffect = CreateBitMask( {"InUmbra", "Fury", "Cloaked", "Parasite", "NearDeath", "OnFire", "OnInfestation", "Beacon", "Energize" } )
kGameEffectMax = bit.lshift( 1, GetBitMaskNumBits(kGameEffect) )

-- Stackable game effects (more than one can be active, server-side only)
kFuryGameEffect = "fury"
kMaxStackLevel = 10

kMaxEntityStringLength = 32
kMaxAnimationStringLength = 32

-- Player modes. When outside the default player mode, input isn't processed from the player
kPlayerMode = enum( {'Default', 'Taunt', 'Knockback', 'StandUp'} )

-- Team alert types
kAlertType = enum( {'Attack', 'Info', 'Request'} )

-- Dynamic light modes for power grid
kLightMode = enum( {'Normal', 'NoPower', 'LowPower', 'Damaged'} )

-- Game state
-- Everthing less than PreGame means the game has not started
kGameState = enum( {'NotStarted', 'WarmUp', 'PreGame', 'Countdown', 'Started', 'Team1Won', 'Team2Won', 'Draw'} )

-- Don't allow commander to build structures this close to attach points or other structures
kBlockAttachStructuresRadius = 3

-- Marquee while active, to ensure we get mouse release event even if on top of other component
kHighestPriorityZ = 3

-- How often to send kills, deaths, nick name changes, etc. for scoreboard
kScoreboardUpdateInterval = 1

-- How often to send ping updates to individual players
kUpdatePingsIndividual = 3

-- How often to send ping updates to all players.
kUpdatePingsAll = 10

kStructureSnapRadius = 4

-- Only send friendly blips down within this range
kHiveSightMaxRange = 50
kHiveSightMinRange = 3
kHiveSightDamageTime = 8

-- Bit masks for relevancy checking
kRelevantToTeam1Unit        = 1
kRelevantToTeam2Unit        = 2
kRelevantToTeam1Commander   = 4
kRelevantToTeam2Commander   = 8
kRelevantToTeam1            = bit.bor(kRelevantToTeam1Unit, kRelevantToTeam1Commander)
kRelevantToTeam2            = bit.bor(kRelevantToTeam2Unit, kRelevantToTeam2Commander)
kRelevantToReadyRoom        = 16

-- Hive sight constants
kBlipType = enum( {'Undefined', 'Friendly', 'FriendlyUnderAttack', 'Sighted', 'TechPointStructure', 'NeedHealing', 'FollowMe', 'Chuckle', 'Pheromone', 'Parasited' } )

kFeedbackURL = "http://getsatisfaction.com/unknownworlds/feedback/topics/new?product=unknownworlds_natural_selection_2&display=layer&style=idea&custom_css=http://www.unknownworlds.com/game_scripts/ns2/styles.css"

-- Used for menu on top of class (marine or alien buy menus or out of game menu)
kMenuFlashIndex = 2

-- Fade to black time (then to spectator mode)
kFadeToBlackTime = 2

-- Constant to prevent z-fighting
kZFightingConstant = 0.1

-- Any geometry or props with this name won't be drawn or affect commanders
kCommanderInvisibleGroupName = "CommanderInvisible"
kCommanderInvisibleVentsGroupName = "CommanderInvisibleVents"
-- Any geometry or props with this name will not support being built on top of
kCommanderNoBuildGroupName = "CommanderNoBuild"
kCommanderBuildGroupName = "CommanderBuild"

kSeasonalFallGroupName = "SeasonalFall"
kSeasonalFallExcludeGroupName = "SeasonalFallExclude"
kSeasonalFallCommanderInvisibleGroupName = "SeasonalFallCommanderInvisible"
kSeasonalFallNonCollisionGeometryGroupName = "SeasonalFallNonCollisionGeometry"

kSeasonalWinterGroupName = "SeasonalWinter"
kSeasonalWinterExcludeGroupName = "SeasonalWinterExclude"
kSeasonalWinterCommanderInvisibleGroupName = "SeasonalWinterCommanderInvisible"
kSeasonalWinterNonCollisionGeometryGroupName = "SeasonalWinterNonCollisionGeometry"

-- invisible and blocks all movement
kMovementCollisionGroupName = "MovementCollisionGeometry"
-- same as 'MovementCollisionGeometry'
kCollisionGeometryGroupName = "CollisionGeometry"
-- invisible, blocks anything default geometry would block
kInvisibleCollisionGroupName = "InvisibleGeometry"
-- visible and won't block anything
kNonCollisionGeometryGroupName = "NonCollisionGeometry"

kPathingLayerName = "Pathing"

-- Max players allowed in game
kMaxPlayers = 32

kMaxIdleWorkers = 127
kMaxPlayerAlerts = 127

-- Max distance to propagate entities with
kMaxRelevancyDistance = 40

kEpsilon = 0.0001

-- Weapon spawn height (for Commander dropping weapons)
kCommanderDropSpawnHeight = 0.08
kCommanderEquipmentDropSpawnHeight = 0.5

kInventoryIconsTexture = Textures.kInventoryIcons
kInventoryIconTextureWidth = 128
kInventoryIconTextureHeight = 64

-- Options keys
kNicknameOptionsKey = "nickname4"
kNicknameOverrideKey = "ns2distinctPersona"
kVisualDetailOptionsKey = "visualDetail"
kSoundInputDeviceOptionsKey = "sound/input-device"
kSoundOutputDeviceOptionsKey = "sound/output-device"
kSoundMuteWhenMinized = "sound/minimized-mute"
kSoundVolumeOptionsKey = "soundVolume"
kMusicVolumeOptionsKey = "musicVolume"
kVoiceVolumeOptionsKey = "voiceVolume"
kDisplayOptionsKey = "graphics/display/display"
kWindowModeOptionsKey = "graphics/display/window-mode"
kDisplayQualityOptionsKey = "graphics/display/quality"
kInvertedMouseOptionsKey = "input/mouse/invert"
kLastServerConnected = "lastConnectedServer"
kLastServerPassword  = "lastServerPassword"
kLastServerMapName  = "lastServerMapName"

kPhysicsGpuAccelerationKey = "physics/gpu-acceleration"
kGraphicsXResolutionOptionsKey = "graphics/display/x-resolution"
kGraphicsYResolutionOptionsKey = "graphics/display/y-resolution"
kAntiAliasingOptionsKey = "graphics/display/anti-aliasing"
kAtmosphericsOptionsKey = "graphics/display/atmospherics"
kShadowsOptionsKey = "graphics/display/shadows"
kShadowFadingOptionsKey = "graphics/display/shadow-fading"
kBloomOptionsKey = "graphics/display/bloom_new"
kAnisotropicFilteringOptionsKey = "graphics/display/anisotropic-filtering"

kMouseSensitivityScalar         = 50

-- Player use range
kPlayerUseRange = 2
kMaxPitch = (math.pi / 2) - math.rad(3)

-- Pathing flags
kPathingFlags = enum ({'UnBuildable', 'UnPathable', 'Blockable'})

-- How far from the order location must units be to complete it.
kAIMoveOrderCompleteDistance = 0.01
kPlayerMoveOrderCompleteDistance = 1.5

-- Statistics
kStatisticsURL = "http://sponitor2.herokuapp.com/api/send"

kResourceType = enum( {'Team', 'Personal', 'Energy', 'Ammo'} )

kNameTagFontColors = { [kMarineTeamType] = kMarineFontColor,
                       [kAlienTeamType] = kAlienFontColor,
                       [kNeutralTeamType] = kNeutralFontColor }

kNameTagFontNames = { [kMarineTeamType] = kMarineFontName,
                      [kAlienTeamType] = kAlienFontName,
                      [kNeutralTeamType] = kNeutralFontName }

kHealthBarColors = { [kMarineTeamType] = Color(0.725, 0.921, 0.949, 1),
                     [kAlienTeamType] = Color(0.776, 0.364, 0.031, 1),
                     [kNeutralTeamType] = Color(1, 1, 1, 1) }
kHealthBarEnemyPlayerColor = Color(0.987, 0.067, 0.267, 1)

kHealthBarBgColors = { [kMarineTeamType] = Color(0.725 * 0.5, 0.921 * 0.5, 0.949 * 0.5, 1),
                     [kAlienTeamType] = Color(0.776 * 0.5, 0.364 * 0.5, 0.031 * 0.5, 1),
                     [kNeutralTeamType] = Color(1 * 0.5, 1 * 0.5, 1 * 0.5, 1) }
kHealthBarBgEnemyPlayerColor = Color(0.910 * 0.25, 0.067 * 0.25, 0.267 * 0.25, 1)

kRegenBarFriendlyColor = Color(0, 1.0, 0.129, 1)
kRegenBarEnemyColor = Color(1.0, 0.930, 0, 1 )
    
kArmorBarColors = { [kMarineTeamType] = Color(0.078, 0.878, 0.984, 1),
                    [kAlienTeamType] = Color(0.576, 0.194, 0.011, 1),
                    [kNeutralTeamType] = Color(0.5, 0.5, 0.5, 1) }
kArmorBarEnemyPlayerColor = Color(0.800, 0.627 , 0.0, 1)

kArmorBarBgColors = { [kMarineTeamType] = Color(0.078 * 0.5, 0.878 * 0.5, 0.984 * 0.5, 1),
                    [kAlienTeamType] = Color(0.576 * 0.5, 0.194 * 0.5, 0.011 * 0.5, 1),
                    [kNeutralTeamType] = Color(0.5 * 0.5, 0.5 * 0.5, 0.5 * 0.5, 1) }
--kArmorBarBgEnemyPlayerColor =  Color(0.408 * 0.25, 0.078 * 0.25, 0.157 * 0.25, 1)
kArmorBarBgEnemyPlayerColor =  Color(0.800 * 0.25, 0.627 * 0.25, 0.0 * 0.25, 1)

kAbilityBarColors = { [kMarineTeamType] = Color(0,1,1,1),
                    [kAlienTeamType] = Color(1,1,0,1),
                    [kNeutralTeamType] = Color(1, 1, 1, 1) }
                     
kAbilityBarBgColors = { [kMarineTeamType] = Color(0, 0.5, 0.5, 1),
                    [kAlienTeamType] = Color(0.5, 0.5, 0, 1),
                    [kNeutralTeamType] = Color(0.5, 0.5, 0.5, 1) }

-- used for specific effects
kUseInterval = 0.1

kPlayerLOSDistance = 20
kStructureLOSDistance = 3.5

kGestateCameraDistance = 1.75

-- Rookie mode
kRookieOnlyLevel = 5
kRookieAllowedLevel = 25
kRookieOptionsKey = "rookieMode"

kMinFOVAdjustmentDegrees = 0
kMaxFOVAdjustmentDegrees = 20

kDamageEffectType = enum({ 'Blood', 'AlienBlood', 'Sparks' })

kIconColors = 
{
    [kMarineTeamType] = Color(0.8, 0.96, 1, 1),
    [kAlienTeamType] = Color(1, 0.9, 0.4, 1),
    [kNeutralTeamType] = Color(1, 1, 1, 1),
}

------------------------------------------
--  DLC stuff
------------------------------------------
-- checks if client has the DLC, if a table is passed, the function returns true when the client owns at least one of the productIds
function GetHasDLC(productId, client)

    if productId == nil or productId == 0 then
        return true
    end
    
    local checkIds = {}
    
    if type(productId) == "table" then
        checkIds = productId
    else
        checkIds = { productId }
    end  
    
    for i = 1, #checkIds do
    
        if Client then
        
            assert(client == nil)
            if Client.GetIsDlcAuthorized(checkIds[i]) then
                return true
            end
            
        elseif Server and client then
        
            assert(client ~= nil)
            if Server.GetIsDlcAuthorized(client, checkIds[i]) then
                return true 
            end    

        end
    
    end
    
    return false
    
end

function GetOwnsItem( item )
    if Client then
        return Client.GetOwnsItem( item )
    else
        return true
    end
end

kSpecialEditionProductId = 4930
kShadowProductId = 250893

kUnpackTundraBundleItemId=10
kTundraBundleItemId=100
kTundraArmorItemId=101
kTundraExosuitItemId=102
kTundraRifleItemId=103
kTundraShotgunItemId=104
kTundraShoulderPatchItemId=105
kKodiakArmorItemId=201
kKodiakExosuitItemId=202
kKodiakRifleItemId=203
kKodiakShoulderPatchItemId=204
kKodiakSkulkItemId=205
kReaperShoulderPatchItemId=301
kReaperSkulkItemId=302
kReaperGorgeItemId=303
kReaperLerkItemId=304
kReaperFadeItemId=305
kReaperOnosItemId=306
kEliteAssaultArmorItemId=401
kShadowShoulderPatchItemId=402
kShadowSkulkItemId=403
kShadowGorgeItemId=404
kShadowLerkItemId=405
kShadowFadeItemId=406
kShadowOnosItemId=407
kDeluxeArmorItemId=501
kAssaultArmorItemId=502
kReinforcedShoulderPatchItemId=503
kAbyssSkulkItemId=601
kRedRifleItemId=801
kNS2WC14GlobeShoulderPatchItemId=901
kGodarShoulderPatchItemId=902
kSaunamenShoulderPatchItemId=903
kSnailsShoulderPatchItemId=904
kTitusGamingShoulderPatchItemId=905
kRookieShoulderPatchItemId=906
kHalloween16ShoulderPatchItemId=907
kBlackArmorItemId=9001

kCollectableItemIds = { 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715 }

-- DLC player variants
-- "code" is the key

-- TODO we can really just get rid of the enum. use array-of-structures pattern, and use #kMarineVariants to network vars

kMarineVariant = enum({ "green", "special", "deluxe", "assault", "eliteassault", "kodiak", "tundra" })
kMarineVariantData =
{
    [kMarineVariant.green] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kMarineVariant.special] = { itemId = kBlackArmorItemId, displayName = "Black", modelFilePart = "_special", viewModelFilePart = "_special" },
    [kMarineVariant.deluxe] = { itemId = kDeluxeArmorItemId, displayName = "Deluxe", modelFilePart = "_special_v1", viewModelFilePart = "_deluxe" },
    [kMarineVariant.assault] = { itemId = kAssaultArmorItemId, displayName = "Assault", modelFilePart = "_assault", viewModelFilePart = "_assault" },
    [kMarineVariant.eliteassault] = { itemId = kEliteAssaultArmorItemId, displayName = "Elite Assault", modelFilePart = "_eliteassault", viewModelFilePart = "_eliteassault" },
    [kMarineVariant.kodiak] = { itemId = kKodiakArmorItemId, displayName = "Kodiak", modelFilePart = "_kodiak", viewModelFilePart = "_kodiak" },
    [kMarineVariant.tundra] = { itemId = kTundraArmorItemId, displayName = "Tundra", modelFilePart = "_tundra", viewModelFilePart = "_tundra" },
}
kDefaultMarineVariant = kMarineVariant.green

kSkulkVariant = enum({ "normal", "shadow", "kodiak", "reaper", "abyss" })
kSkulkVariantData =
{
    [kSkulkVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kSkulkVariant.shadow] = { itemId = kShadowSkulkItemId, displayName = "Shadow", modelFilePart = "_shadow", viewModelFilePart = "" },
    [kSkulkVariant.kodiak] = { itemId = kKodiakSkulkItemId, displayName = "Kodiak", modelFilePart = "_kodiak", viewModelFilePart = "" },
    [kSkulkVariant.reaper] = { itemId = kReaperSkulkItemId, displayName = "Reaper", modelFilePart = "_albino", viewModelFilePart = "_albino" },
    [kSkulkVariant.abyss]  = { itemId = kAbyssSkulkItemId,  displayName = "Abyss",  modelFilePart = "_abyss",  viewModelFilePart = "_abyss"  },
}
kDefaultSkulkVariant = kSkulkVariant.normal

kGorgeVariant = enum({ "normal", "shadow", "reaper" })
kGorgeVariantData =
{
    [kGorgeVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kGorgeVariant.shadow] = { itemId = kShadowGorgeItemId, displayName = "Shadow", modelFilePart = "_shadow", viewModelFilePart = "" },
    [kGorgeVariant.reaper] = { itemId = kReaperGorgeItemId, displayName = "Reaper", modelFilePart = "_albino", viewModelFilePart = "_albino" },
}
kDefaultGorgeVariant = kGorgeVariant.normal

kLerkVariant = enum({ "normal", "shadow", "reaper" })
kLerkVariantData =
{
    [kLerkVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kLerkVariant.shadow] = { itemId = kShadowLerkItemId, displayName = "Shadow", modelFilePart = "_shadow", viewModelFilePart = "" },
    [kLerkVariant.reaper] = { itemId = kReaperLerkItemId, displayName = "Reaper", modelFilePart = "_albino", viewModelFilePart = "_albino" },
}
kDefaultLerkVariant = kLerkVariant.normal

kFadeVariant = enum({ "normal", "reaper", "shadow" })
kFadeVariantData =
{
    [kFadeVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kFadeVariant.reaper] = { itemId = kReaperFadeItemId, displayName = "Reaper", modelFilePart = "_albino", viewModelFilePart = "_albino" },
    [kFadeVariant.shadow] = { itemId = kShadowFadeItemId, displayName = "Shadow", modelFilePart = "_shadow", viewModelFilePart = "_shadow" },
}
kDefaultFadeVariant = kFadeVariant.normal

kOnosVariant = enum({ "normal", "reaper" })
kOnosVariantData =
{
    [kOnosVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kOnosVariant.reaper] = { itemId = kReaperOnosItemId, displayName = "Reaper", modelFilePart = "_albino", viewModelFilePart = "_albino" },
}
kDefaultOnosVariant = kOnosVariant.normal

kExoVariant = enum({ "normal", "kodiak", "tundra" })
kExoVariantData =
{
    [kExoVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kExoVariant.kodiak] = { itemId = kKodiakExosuitItemId, displayName = "Kodiak", modelFilePart = "", viewModelFilePart = "" },
    [kExoVariant.tundra] = { itemId = kTundraExosuitItemId, displayName = "Tundra", modelFilePart = "", viewModelFilePart = "" }
}
kDefaultExoVariant = kExoVariant.normal

kRifleVariant = enum({ "normal", "kodiak", "tundra", "red" })
kRifleVariantData =
{
    [kRifleVariant.normal] = {
                                displayName = "Normal",
                                modelFilePart = "",
                                viewModelFilePart = ""
                            },
    [kRifleVariant.kodiak] = {  itemId = kKodiakRifleItemId,
                                displayName = "Kodiak",
                                modelFilePart = "_kodiak",
                                viewModelFilePart = ""
                            },
    [kRifleVariant.tundra] = {  itemId = kTundraRifleItemId,
                                displayName = "Tundra",
                                modelFilePart = "_tundra",
                                viewModelFilePart = ""
                            },
    [kRifleVariant.red] = {  itemId = kRedRifleItemId,
                                displayName = "Skull 'n' Crossfire",
                                modelFilePart = "_red",
                                viewModelFilePart = ""
                            },
}
kDefaultRifleVariant = kRifleVariant.normal

kShotgunVariant = enum({ "normal", "tundra" })
kShotgunVariantData = 
{
    [kShotgunVariant.normal] = { displayName = "Normal", modelFilePart = "", viewModelFilePart = "" },
    [kShotgunVariant.tundra] = { itemId = kTundraShotgunItemId, displayName = "Tundra", modelFilePart = "_tundra", viewModelFilePart = "" },
}
kDefaultShotgunVariant = kShotgunVariant.normal

function FindVariant( data, displayName )

    for var, data in pairs(data) do
        if data.displayName == displayName then
            return var
        end
    end

    return 1

end

function GetVariantName( data, var )
    if data[var] then
        return data[var].displayName
    end
    return ""        
end

function GetVariantModel( data, var )
    if data[var] then
        return data[var].modelFilePart .. ".model"
    end
    return ""
end

function GetHasVariant(data, var, client)
    if not data[var] then
        return false
    end
    if data[var].itemId then
        return GetOwnsItem( data[var].itemId, client )
    else
        return GetHasDLC(data[var].productId, client)
    end
end

kShoulderPadNames =
{
    "None",
    "Reinforced",
    "Shadow",
    "Globe",
    "Godar",
    "Saunamen",
    "Snails",
    "Titus",
    "Kodiak",
    "Reaper",
    "Tundra",
    "Eat your Greens",
    "Pumpkin Patch",
}

kShoulderPad2ItemId =
{
    0, -- no item required if you're not using a shoulder pad
    kReinforcedShoulderPatchItemId,
    kShadowShoulderPatchItemId,
    kNS2WC14GlobeShoulderPatchItemId,
    kGodarShoulderPatchItemId,
    kSaunamenShoulderPatchItemId,
    kSnailsShoulderPatchItemId,
    kTitusGamingShoulderPatchItemId,
    kKodiakShoulderPatchItemId,
    kReaperShoulderPatchItemId,
    kTundraShoulderPatchItemId,
    kRookieShoulderPatchItemId,
    kHalloween16ShoulderPatchItemId,
}

function GetHasShoulderPad(index, client)
    local itemId = kShoulderPad2ItemId[index]
    
    if not itemId then
        return false
    end
    
    if itemId == 0 then
        return true
    end
    
    return GetOwnsItem( itemId, client )
end

function GetShoulderPadIndexByName(padName)

    for index, name in ipairs(kShoulderPadNames) do
        if name == padName then
            return index
        end    
    end
    
    return 1

end

kHUDMode = enum({ "Full", "Minimal" })

-- standard update intervals for use with TimedCallback
-- The engine spreads out callbacks running at the same update interval to spread out any load. This works best if the number of
-- different intervals used is not too high (a hashmap(updateInterval->list of callbacks) is used).
-- The values are just advisory to keep people from choosing 0.45 and 0.55 instead of 0.5
kUpdateIntervalMinimal = 0.5
kUpdateIntervalLow = 0.1
kUpdateIntervalMedium = 0.05
kUpdateIntervalAnimation = 0.02
kUpdateIntervalFull = 0

-- concede sequence constants
kConcedeTimeBeforeMontage = 1.0
kConcedeMontageDuration = 5.0
kConcedeTimeAfterMontage = 4.0

kConcedeNumAnglesToCheck = 64 -- adjust for performance
kConcedeIdealDistance = {6.5, 6.5, 4.5} -- xz distance
kConcedeIdealHeightOffset = {2.5, 2.0, 1.5} -- y distance
kConcedeIdealCameraSpeed = 1.0
kConcedeRelevancyDistance = 20 -- reduce relevancy distance for these sequences




