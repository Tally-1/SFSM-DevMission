class CfgFunctions
{
    class SFSM
    {
        class audioFeedback
        {
            file = "functions\audioFeedback";
            class SquadSay        {};
            class say             {};
            class canSpeak        {};
            class speechEventsMan {};
            class getPhrase       {};
        }

        class animations 
        {
            file = "functions\animations";
            class playAnimList       {};
            class animListEnd        {};
            class onAnimListEhFired  {};
            class animListEh         {};
            class removeAnimPlaylist {};
            class animationMaps      {};
            class movementAnimData   {};
            class getAnimData        {};
            class checkAnimDirDist   {};
            class animListData       {};
        };

        class OOP_movement
        {
            file = "functions\animations\OOPmovement";
            class OOP_moveAnimsMap     {};
            class OOP_moveAnimsEntries {};
            class OOP_playAnim         {};
            class OOP_mapByCfgName     {};
            class OOP_animEndPos       {};
            class OOP_getAnimEndPos    {};
        };

        
        
        class CQB
        {
           file = "functions\CQB";
           class assignAllBuildings    {};
           class assignBuilding        {};
           class currentBuilding       {};
           class unitIndoorPos         {};
           class floorPositions        {};
           class buildingFloors        {};
           class unitsInBuilding       {};
           class CQBlimitReached       {};
           class initCQB               {};
           class buildingPath          {};
           class buildingExits         {};
           class CQBTargetEnemies      {};
           class clearCQBPos           {};
           class clearBuilding         {};
           class CQBposAvailable       {};
           class CQBcoverPosFilter     {};
           class moveIntoHouseInit     {};
           class moveIntoHouseExec     {};
           class endMoveIntoHouse      {};
           class houseAvailable        {};
           class nearestAvailableHouse {};
           class endCQBclearing        {};
        };
        
        class misc
        {
            
            file = "functions\misc";
            class StoreSuppression      {};
            class onSuppression         {};
            class unitData              {};
            class sinCosPos             {};
            class sinCosPos2            {};
            
            class initReaction          {};
            class groupData             {};
            class manAvailable          {};
            class manLoaded             {};
            class unitInDoor            {};
            
            class targetVisible         {};
            class allCurrentDestinations{};
            class manOverrunBy          {};
            class firePosLite           {};
            class killNearEnemies       {};
            
            class loadedAddons          {};
            class unitsInRangeSameSide  {};
            class getNearestOrPlayer    {};
            class relAimPos             {};
            class isPosition            {};
            class availableRegulars     {};
            class isUncon               {};
            class enableAutoStance      {};
            class disableAutoStance     {};
            class autoStanceActions     {};
            class showAutoStAction      {};
            class playableUnit          {};
            class playableGroup         {};

            class getNearest            {};
            class noBushNoMan           {};

            class getAction             {};
            class setAction             {};
            class inVehicle             {};

            class targetsAndVisibility  {};
            class stand                 {};
            class crouch                {};
            class hostile               {};
            class nearEnemies           {};
            class nearAllies            {};

            class hasActiveWp           {};
            class animSetStance         {};

            class isPlayerGroup         {};
            class spamDoFire            {};
            class getFurthest           {};
            
            class canResetBrain         {};
            class deActivateMan         {};
            class activateMan           {};
            class abilitiesInUse        {};
            class getSquadIndex         {};
            class forceGroupJoin        {};
            class resetBrain            {};
            class inDirRange            {};
            class formatDirRanges       {};
            class selectionPos          {};
            class addToPosValues        {};
            class setDirAndPitchToPos   {};
            class canGoProne            {};
            class animThenExec          {};
            class onExecAnim            {};
            class execFromArr           {};

            class rgbColorToA3Color     {};
            class distanceToFooting     {};

            class deploySmoke           {};
            class numberDiff            {};
            class getProneTreshHold     {};
            class distanceToMan         {};

            class threadsFinished       {};
            class enemiesInFront        {};
        };

        class morale
        {
            file = "functions\morale";
            class moraleEvent           {};

            class moraleOnCapture       {};
            class moraleOnHit           {};
            class moraleOnKnockOut      {};
            class moraleOnKill          {};
            class moraleOnRevive        {};

            class moraleEventData       {};
            class postMoraleEvent       {};

            class canUpdateMorale       {};
            class updateMorale          {};
            class updateFleeCoef        {};
            
            class baseMorale            {};
            class moraleFinal           {};

            class alliesFactor          {};
            class enemiesFactor         {};
            class skillFactor           {};
            class moraleFactors         {};
            class storeMoraleFactors    {};

            class avgMorale             {};
        };

        class movement
        {
            file = "functions\movement";
            class forceMoveToPos        {};
            class forceMove2            {};
            class postForceMove2        {};

            class objectsInPath         {};
            class calculatePath         {};
            class abortForcedMove       {};
            class moveToMan             {};

            class canRun                {};
            class forceMoveATL          {};

            class regroup               {};
            class fixPos                {};

        };

        class evasionAttack
        {
            file = "functions\movement\evasionAttack";
            class evasiveAttack          {};
            class evasiveAttackAnims     {};
            class canDoEvasiveAttack     {};
            class evasiveAttackCondition {};
            class evasiveAttackLoop      {};
            class evasiveAttackAlign     {};
            class endEvasiveAttack       {};
            class initEvasiveAttack      {};
        };

        class sprint
        {
            file = "functions\movement\sprint";
            class canSprint             {};
            class clearSprintPath       {};
            class sprint                {};
            class sprintInit            {};
            class sprintLooper          {};
            class sprintVarRemoval      {};

            class sprintAnimList        {};
            class sprintCondition       {};
            class sprintMidFnc          {};
            class sprintEndFnc          {};
            class updateSprintAnims     {};
            class canUpdateSprintAnims  {};
            class sprintEndAnims        {};
            class sprintSuppress        {};
            class updateSprintTimer     {};
            class adjustSprintDir       {};
        };

        class vehicles
        {
            file = "functions\vehicles";
            class vehicleData           {};
            class vehicleHeard          {};
            class availableVehicles     {};
            class vehicleAvailable      {};
            class UnitsNearVehicles     {};
            class endGetInVehicle       {};
            class otherSideInVehicle    {};
            class initGetInVehicle      {};
            class hijackAllVehicles     {};
            class hijackVehicle         {};
            class getInVehicle          {};
            class vehicleNeedsCrew      {};
            class reinforceVehicles     {};
            class vehicleActions        {};
            class enableHijack          {};
            class disableHijack         {};
            class canHijackVehicle      {};

        };


        class taskManagement
        {
            file = "functions\taskManagement";
            class HandleSuppression     {};
            class TaskManager           {};
            class tenSecondTasks        {};
            class fiveMinTasks          {};
            class unitTasks             {};
            class vehicleTasks          {};
            class updateVehicle         {};
            class groupTasks            {};
            class handleGroupStance     {};
            class deleteDeadData        {};
            class validCleanupObject    {};
            class garbageCollector      {};
            class minuteTasks           {};
            
        };

        class projectileHandling
        {
            file = "functions\projectileHandling";
            class soundReaction         {};
            class handleBulletImpact    {};
        };

        class curator
        {
            file = "functions\curator";
            class zWPplaced             {};
            class zWPdeleted            {};
        };
        
        class eventHandlers
        {
            file = "functions\eventHandlers";
            class SuppressedEH          {};
            class hitEH                 {};
            class firedEH               {};
            class endHealEH             {};
            class curatorEH             {};
            class spottedCustomEH       {};
            class enemySpotted          {};
            class unitKilled            {};
            class unitCreated           {};

            class projectileCreated     {};
            class projectileEH          {};
            class explosionEH           {};
            class bulletEH              {};

            class vehicleFiredEh        {};
            class enemyDetected         {};
            class gameLoaded            {preInit = 1};
            class gameLoadedWarning     {};
            class putAnimDoneEH         {};
            class PathCalculated        {};

            class leaderChangeEH        {};
            class antiRubberBand        {};
            class ACE_MedicalCBA        {};
            class buildingDestroyedEH   {};
            
        };

        class explosives 
        {
            file = "functions\explosives" 
            class canBlowUpHouse         {};
            class carriedExplosives      {};
            class formatExplosiveName    {};
            class getChargeFromBackPack  {};
            class initHouseDemolition    {};
            class placeExplosive         {};
            class blowUpHouse            {};

            class reactToExplosion      {};
            class addCrater             {};
            class handleExplosion       {};
            class handleGrenade         {};
            class throwBackGrenade      {};
            class evadeGrenade          {};

            class getBiggestInvExplosive {};
            class isExplosiveMag         {};
            class getMagSplashRange      {};
        };

        class launchers
        {
            file = "functions\launchers" 
            class rpgHouse          {};
            class launcherHandler   {};
            class forceFireLauncher {};
            class canRpgHouse       {};
            class forcedCqbRpg      {};
        }

        class dodging
        {
            file = "functions\dodging";
            class dodgeEnded            {};
            class EndDodge              {};
            class Dodge                 {};
            class GetDodgePos           {};
            class canDodge              {};
            class getLateralPos         {};
            class groupCanDodge         {};
            class forceCoverDodge       {};

            class evasion               {};
            class evadeDir              {};
            class evasionFail           {};

            
            
        };
        
        class flinching 
        {
            file = "functions\flinching";
            class canFlinch             {};
            class endFlinch             {};
            class flinch                {};
            class canRoll               {};
            class Roll                  {};
            class proneFlinch           {};
            class bigBulletFlinch       {};
            class standardFlinch        {};
            class execStandardFlinch    {};
            class normalizeStance       {};
            class bigFlinchCover        {};

            class registerFlinch        {};
            class isPinnedDown          {};
            
        };
       
       
/*******************FIPOs***************************/
        
        
        class fightPos 
        {
            file = "functions\fightPos";
            class clearFipo             {};
            class getFipo               {};
            class inFipo                {};
            class nearestFipo           {};
            class handleFipoHit         {};
            class fipoAvailable         {};
            class nearGroupFiposs       {};
            class selectFipo            {};
            class assignFiposs          {};
            class fipoMenRegroup        {};
            // class groupFipoAssigner     {};
            class fipoAssigner          {};
            class fipoFSM               {};
            class fipoManager           {};
            class canTeleportFipo       {};
            class checkFipoError        {};
            class getFipoMen            {};
            class tempPegToFipo         {};
            class dynamicFipoActive     {};
            class assignFipo            {};
                        
        };

        class dodgeToFipo
        {
            file = "functions\fightPos\dodgeToFipo";
            class isDodgeFipo           {};
            class initDodgeToFipo       {};
            class dodgeToFipo           {};

        }

        class actions
        {
            file = "functions\fightPos\actions";
            class fipoActions         {};
            class leaderGetOutFipo    {};
            class curatorGetOutFipo   {};
            class fipoRemoveUseless   {};
            class fipoCorrectPosition {};
            
            class initIdleFipoMove    {};
            class idleAnimEh          {};
            class idleFipoMan         {};
            class canDoIdleFipo       {};
            class abortIdleFipo       {};

            class getOutFipo          {};
            class getInFiPo           {};
            class moveInFipo          {};
            class moveOutFiPo         {};
            class failFipoMove        {};
            class canMoveInFipo       {};
            class fipoMoveInStatus    {};
            class getOutDynamicFipo   {};
            class fipoAttemptAllowed  {};
            
        };

        class module
        {
            file = "functions\fightPos\module";
            class initFipo          {};
            class fipoMan           {};
            class moveInFipoSynced  {};
            class fipoMarker        {};
			class fipoAllowedMan    {};
			class fipoDefineSides   {};
			class fipoMarkerColor   {};
			class updateFipoMarker  {};
        };

        class peeking
        {
            file = "functions\fightPos\peeking";
            class peekEnded            {};
            class initFipoPeek         {};
            class fipoPeek             {};
            class peekActions          {};
            class canFipoPeek          {};
            class fipoPeekTime         {};
            class peekCoolDownTime     {};
            class fipoStanceIndexes    {};
            class getPeekTarget        {};
            class fipoManFired         {};
            class getFipoATtarget      {};
            class selectShootingStance {};
            class setFipoAnimOfset     {};
        };

        class sectors 
        {
            file = "functions\fightPos\sectors";
            class validSector         {};
            class inSector            {};
            class sectorEdgePositions {};
            class sector3D            {};
            class sector3DLines       {};
            class fipoFlankSectors    {};
            class showActiveFlanks    {};
            class fipoFlankEnemies    {};
            class fipoOutFlanked      {};
            class curatorFipoFlanks   {};
            class getObjectSector     {};
            class unitsInFireSector   {};
        };

        class hitAndRun
        {
            file = "functions\fightPos\hitAndRun";
            class initHitAndRunFipo   {};
            class fipoCooldownLeft    {};
            class firedHitAndRunEH    {};
            class fipoTimeUntilExit   {};
            class getOutFipoHitAndRun {};
            class fipoRun             {};
            class endHitAndRun        {};
        };

        class FUBAR
        {
            file = "functions\fightPos\FUBAR";
            class fipoKnockOut          {};
            class timeSinceFipoKnockOut {};
            class fipoIsFUBAR           {};
            class fipoIsDestroyed       {};
            class fipoBuildingDestroyed {};
        };

        class activationZones
        {
            file = "functions\fightPos\activationZones";
            class initFIPOsAndAZs       {};
            class initActivationZones   {};
            class getAzSides            {};
            class validAzUnit           {};
            class getUnitsInAz          {};
            class getAzArea             {};
            class updateAz              {};
            class initAz                {};

            class getAzFipos            {};
            class getAzFipoZones        {};
            class initAzFipo            {};
            class hostilePresentInAz    {};
            class azFipoActive          {};
            class availAzFipoUnits      {};
            class handleAZfipos         {};
            class onAzActiveChanged     {};
            class azFipoGetOut          {};
            class azFipoActions         {};
            class handleActivationZones {};

        };

/***********************FIPO-END*************************/
/********************************************************/


        class overrun 
        {
            file = "functions\overrun";
            class groupFleeingEh    {};
            class groupFlee         {};            
            class groupFleeDecision {};

            class initOverRun       {};
            class overRunAllies     {};
            class overRunDecision   {};
            class overRunFight      {};
            class overRun           {};
            class flee              {};
            
            class canBeOverRun      {};
            class canBeOverrunFipo  {}; // not sure if this may belong in the fightPos category
            class fipoOverrunDist   {};
            class panic             {};
            class panicAction       {};
            class calmPanicked      {};
        }

        class capture
        {
            file = "functions\overrun\capture";
            class dropWeapon         {};
            class dropAllWeapons     {};
            class surrender          {};
            class capture            {};
            class execute            {};
            class executeAction      {};
            class captureAction      {};
            class joinSurrenderGroup {};
            class battleLost         {};
            
            class failRescue         {};
            class failAiCapture      {};
            class aiCaptureMan       {};
            class unconSurrPan       {};
            class canBeCaptured      {};
            class canCapture         {};
            class initCapture        {};
            class canRescue          {};
            class AiRescue           {};
            class initAiRescue       {};
            class helpOrCapture      {};
            class allAiRescueCapture {};
        };

        class selfBomb 
        {
            file = "functions\overrun\selfBomb";
            class captureBombType  {};
            class canBombOnCapVars {};
            class bombOnCapture    {};
        };

        class reactiveFire
        {
            file = "functions\reactiveFire";
            class canReactFire          {};
            class reactFire             {};
            class endReactiveFire       {};
            class directReactFire       {};
            class unitTounitForcedFire  {};
            class unitAimedAtTarget     {};
            class unitWeaponDir         {};
            class multiplyReactionFire  {};
            class multiplyRF            {};
            class forcedFire            {};
            class isAimedAtTarget       {};
            class ifAimThenFire         {};
        };

        class rearming
        {
            file = "functions\rearming";
            class rearm            {};
            class canRearm         {};
            class needMachinegun   {};
            class needLauncher     {};
            class canRearmWeapon   {};
            class getNewWeapon     {};
            class validRearm       {};
            class rearmAtSupply    {};
            class endRearm         {};
            class hasMagsForWeapon {};
            class getBestSupply    {};
            class primaryWeaponMags{};
            class pickUpFreshAT     {};
            class availMagsForWeapon {};
        };

        class buddyRearm
        {
            file = "functions\rearming\buddyRearm";
            class buddyRearmAction   {};
            class isRearmBuddy       {};
            class canCallBuddyRearm  {};
            class getRearmingBuddy   {};
            class buddyRearmHint     {};
            class giveMagazines      {};
            class buddyRearm         {};

        }

        class marksmanFSM
        {
            file = "functions\marksmanFSM";
            class handleMarksmanHit       {};
            class marksmenInGroup         {};
            class getMarksMen             {};
            class isHVT                   {};
            class getHVTs                 {};
            class canHunt                 {};
            class activateMarksMen        {};
            class battlefieldMarksmen     {};
            class isFirePos               {};
            class selectTarget            {};
            class selectMarksmanTarget    {};
            class snipingPosGrid          {};
            class selectSnipingPos        {};
            class snipingPos              {};
            class viableTarget            {};
            class huntEnded               {};
            class correctTarget           {};
            class marksmanTargetControlEh {};
            class initHunt                {};
            class abortMoveToSnipePos     {};
            class MoveToSnipePos          {};
            class huntActions             {};
            class huntTarget              {};
            class marksmanReturnMove      {};
            class marksmanReturn          {};
            class endHunt                 {};
            class mrkMnKeepShooting       {};
            class marksmanFireAtTarget    {};
            class preyHandler             {};
        };

        class startEngagement
        {
            file = "functions\startEngagement";
            class canDoSpecial           {};
            class allowSpecial           {};
            class AtSpecialistInitFight  {};
            class targetInfWithLauncher  {};
            class reactTovehicles        {};
            class unkillableEnemyVehicle {};
            class eyelidTrench           {};
            class getEnemyVehicles       {};
            class specialInitFightActions{};
            class machineGunInitFight    {};
            class supressPositions       {};
            class moveToFirePos          {};
            class findFirePos            {};

            class forcedRegroupNeeded    {};
            class forcedRegroup          {};
            class abortSpecial           {};

        };

        class startEngagement_takeCover
        {
            file = "functions\startEngagement\takeCover";
            class getCoverPos            {};
            class fightInitCover         {};
            class takeCover              {};
            class endTakeCover           {};
            class selectCoverPos         {};
            class postCoverActions       {};
            class initTakeCover          {};
            class stayInCover            {};
            class endStayInCover         {};
            class eventTriggeredCover    {};
        };

        class startEngagement_hide
        {
            file = "functions\startEngagement\hide";
            class findHidePos            {};
            class hideFromVehicle        {};
            class initHideFromVeh        {};
            class moveToHidePos          {};
            class doHide                 {};
            class doHideCQB              {};
        };

        class init
        {
            file = "functions\init";
            class serverInit            {};
            class initSettings          {};
            class postConfig            {};
            class initClient            {};
            class initSFSM              {postInit = 1};
            class InitMan               {};
            class initGroup             {};
            class initVehicle           {};
            class initFiPositions       {};
        };

        class debug
        {
            file = "functions\debug";
            class 3dDebug               {};
            class aimLine               {};
            class actionColor           {};
            class drawObjectMarker      {};
            class drawAllAimLines       {};
            class multiple3dmarkers     {};
            class battlefield3d         {};
            class debugMessage          {};
            class hunkerObj3d           {};
            class logSettings           {};
            class deleteWarning         {};
            class custom3Dmarkers       {};
            class flashAction           {};
            class onDbgCurKey           {};
            class debugCuratorKeyHandler{};
            class debugCuratorInterface {};
            class drawBullets           {};
            class bulletTracker         {};
            class trajectory            {};
            class drawTrajectory        {};
            class drawAllTrajectories   {};
            class drawFiPositions       {};
            class sideColor             {};

            class isDebugActive         {};
            class debugController       {};
            class draw3Dsectors         {};
            class drawSector3D          {};
            class add3Dsector           {};
            class fipoDebugData         {};
            class fipoHRDbgTxt          {};

            class flashFipoText         {};

        };

        class debugMan
        {
            file = "functions\debug\debugMan";
            class manInfo               {};
            class man3dInfo             {};
            class 3DdebugText           {};
            class dbgTxtRPS             {};
            class dbgTxtSupression      {};
            class dbgTxtAction          {};
            class dbgTxtExcluded        {};
            class dbgTxtUncon           {};
            class dbgTxtInjured         {};
            class dbgTxtSprint          {};
            class dbgTxtFipo            {};
            class dbgTxtMarksman        {};
            class dbgTxtSnipeTarget     {};
            class dbgTxtSniper          {};
            class dbgTxtFirePos         {};
            class dbgTxtSelectedMan     {};
            class dbgTxtActionText      {};
            class dbgTxtForcedMovement  {};
            class dbgTxtMorale          {};
        };
        
        class healing
        {
            file = "functions\healing";
            class proneHeal             {};
            class endSelfHeal           {};
            class canSelfHeal           {};
            class hasMedkit             {};
            class nearestHealer         {};
            class initBuddyHeal         {};
            class canBuddyHeal          {};
            class buddyHeal             {};
            class endBuddyHeal          {};
            class reviveAnim            {};
            class buddyRevive           {};
            class endBuddyRevive        {};
            class initDragMan           {};
            class dragStatus            {};
            class drag                  {};
            class dragMan               {};
            class endDragMan            {};
            class dragPos               {};
            class searchAndRevive       {};

            class getGroupHealer        {};
            class playerNeedsMedic      {};
            class canCallMedic          {};
            class playerHealHint        {};
            class callPlayerMedic       {};
            class playerCallMedicAction {};
            class nearestValidReviver   {};
            class sortRevivers          {};
            class sortUnconscious       {};

            class onKnockOut            {};
            class onWakeUp              {};
            class unconAiAbility        {};
        };


        class battlefield
        {
            file = "functions\battlefield";
            class InitBattlefield         {};
            class battlefieldPostInit     {};
            class battlefieldEnd          {};
            class getZones                {};
            class getZone                 {};
            class getCoverPositionsLight  {};
            class clusterCoverPosLight    {};
            class battlefieldRadius       {};
            class nearestBattle           {};
            class battleInitType          {};
            class battlefieldVariables    {};
            class updateBattlefield       {};
            class sidesFromString         {};
            class battlingUnits           {};
            class battleEnded             {};
            class battleFieldUpdater      {};
            class triggerBattleOnShot     {};
            class canTriggerBattleShot    {};
            class canSpotInitBattle       {};
            class excludeCpos             {};
            class getBattlefield          {};
            class getEnemyPositions       {};
            // class updateHunkerObjects     {};
            class initGrid                {};
            class updateGrid              {};
            class AddWeaponsToBattlefield {};
            class emergencyRearm          {};
            class getBattlefieldWeapon    {};
            class pickUpWeapon            {};
            class canPickUpWeapon         {};
            class endWeaponPickup         {};
            class useLightScan            {};
            class battleFieldCQB          {};
            class battleFieldSupplies     {};
            class battleFieldMachineGuns  {};

            class battleFieldMedical      {};
            class battleFieldMedicLoop    {};
            class getWoundedAndHealers    {};
            class assignBattlefieldTurrets{};
            class leaveBattlefieldTurrets {};
            class bffKnowEachOther        {};

            class battleOverRun           {};
            class BffOverRunLoop          {};
            class bffEnemyVehicles        {};

            class battlefieldDimensions   {};
            class battlefieldRevives      {}; 
            class battlefieldActions      {};

        };
        
        class markers
        {
            file = "functions\markers";
            class posMarker             {};
            class drawCircle            {};
            class bfDebugMarkers        {};
            class drawCoverPositions    {};
        };

        class objectData
        {
            file = "functions\objectData";
            class glRifle                {};
            class ObjStance              {};
            class areaData               {};
            class getMapObjects          {};
            class excludedMapObject      {};
            class filterMapObjects       {};
            class terrainObjData         {};
            class squadAsset             {};
            class hasAmmoForWeapon       {};
            class validEnemy             {};
            class validEnemyVehicle      {};
            class isMachineGunner        {};
            class isATSoldier            {};
            class isMarksman             {};
            class isRealMan              {};
            class functionalMan          {};
            class isMedic                {};
            class isFipoMedic            {};
            class isPlayer               {};
            class isDeactivated          {};            
            
            class availableAiSoldier     {};
            class buildingCenterPosASL   {};
            class availEnemyFriendDist   {};

            class validAllyVehicle       {};
            class validAlly              {};

            class manIsInjured           {};

            class weaponAimPos           {};
        };

        // class hunkerDown
        // {
        //     file = "functions\hunkerDown";
        //     class getHunkerObject     {};
        //     class initHunker          {};
        //     class isHunkerObject      {};
        //     class hunkAvailable       {};
        //     class getAvHunkObject     {};
        //     class filterHunkerObjects {};
        //     class hunkObjHash         {};
        //     class hunkerFSM           {};
        //     class hunkerFsmStatus     {};
        //     class addHunkerObjData    {};
        //     class setHobjPositions    {};
        //     class moveToHunkerPos     {};
        //     class endHunker           {};
        //     class initHunkerFSM       {};
        //     class handleHunkerStatus  {};
        //     class randomHunkerInit    {};

        // };

        class turrets
        {
            file = "functions\turrets";
            class isTurret              {};
            class getTurretsAndLeaders  {};
            class assignTurret          {};
            class canGetInTurret        {};
            class turretAvailable       {};
            class turretRunEnded        {};
            class mountTurret           {};
            class getInTurret           {};
            class failTurretMount       {};
            class removeTurretVars      {};
            class onGetOutTurret        {};
            class canStayInTurret       {};
            class turretGetOut          {};
            class groupLeaveTurrets     {};
            class manAllTurrets         {};
        };
    };

    class Tcore
    {
        class core
        {
            file = "functions\core";
            class average               {};
            class decimals              {};
            class addZ                  {};
            class roundPos              {};
            class avgPos                {};
            class get360Positions       {};
            class nearestPos            {};
            class getMidpoint           {};
            class sinCosPos             {};
            class findValidPos          {};
            
            class formatDir             {};
            class avgRelDir             {};
            class inDirRange            {};
            
            class object3DShape         {};
            class objPosData            {};
            class simpleObjectType      {};

            class clusterPos            {};
            class allClustersInRadius   {};
            class ClusterTerrainObjects {};
            class positionsClusterArr   {};
            class clusterSize           {};
            class clusterMarker         {};
            class ClusterSides          {};
            
            class ClusterUnits          {};
            class ClusterVehicles       {};
            class clusterGroups         {};

            class unitCoverPosArr       {};
            class posCoverPosArr        {};
            class coverPosStance        {};
            class objCoverPosLight      {};
            class coverPosSimple        {};
            class visibleFromPositions  {};
            
            class debugMessage          {};
            class closestLocationName   {};
            class getLocationNamePos    {};
            
            class describeDir           {};
            class describeDistance      {};
            class stringToVarName       {};
            class areaName              {};            
            
            class toArrFromArr          {};
            
            class nearKnownEnemies      {};
            class knownDirToEnemy       {};
            class getLosTarget          {};
            class deadCrew              {};
            class grid100Pos            {};
            class substringsPresent     {};
            class playerLedGrp          {};
            class isPlayer              {};

            class toggleAiMoveInhibitors{};
            class deadMenInArea         {};
            class nearSoldiers          {};

            class nilNull               {};
            class posArrToPathPosArr    {};
            class avgHeight             {};
            class unitArrAimPositions   {};
            class posFromObjArr         {};

            class getPos                {};
            class straightPosArr        {};
            class squareGrid            {};
            class visibility            {};
            class sortByDist            {};
            class setTextTexture        {};

            class availablePositions    {};
            class positionClear         {};
        };
    };
    
    #include "PR\cfgFunctions.hpp"
};