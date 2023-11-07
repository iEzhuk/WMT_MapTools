
class CfgPatches
{
	class ATFixes
	{
		units[] = {"MRAP_01_gmg_base_F","MRAP_03_hmg_base_F","MRAP_02_hmg_base_F","MRAP_03_base_F","Boat_Armed_01_base_F","Land_Pallet_static_F","Land_Pallet_vertical_static_F","O_APC_Tracked_02_cannon_hard_F","I_APC_Wheeled_03_cannon_hard_F","B_LSV_01_AT_hard_F","I_E_Static_AT_hard_F","O_static_AT_hard_F","B_static_AT_hard_F","I_static_AT_hard_F"};
		weapons[] = {"launch_Titan_short_base","missiles_titan_static","missiles_titan"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_Launchers_Titan","A3_Soft_F","A3_Boat_F_Boat_Armed_01","A3_Boat_F","A3_Structures_F_Civ_Constructions","A3_Data_F","A3_Weapons_F_Explosives","A3_Armor_F_Beta_APC_Tracked_02","A3_Armor_F_Gamma_APC_Wheeled_03","A3_Aegis_Soft_F_Aegis","A3_Soft_F_Exp_LSV_01","A3_Static_F_Enoch_AT_01","A3_Static_F"};
		authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
		author = "Zealot,Jason,Ezhuk";
		version = "1.6.0";
		versionStr = "1.6.0";
		versionAr[] = {1,6,0};
		magazines[] = {};
		ammo[] = {"M_Titan_AT","M_Titan_AT_Hard","M_Titan_AT_static_Hard","DirectionalBombBase","APERSTripMine_Wire_Ammo","APERSMine_Range_Ammo","BoundingMineCore","BoundingMineBase","APERSBoundingMine_Range_Ammo","ATMine_Range_Ammo","SatchelCharge_Remote_Ammo","SLAMDirectionalMine_Wire_Ammo","DemoCharge_Remote_Ammo","ClaymoreDirectionalMine_Remote_Ammo","FlareBase","Flare_82mm_AMOS_White"};
	};
};
class CfgMagazineWells
{
	class RBC_Static_Titan_AT
	{
		RBC_Titan_hard[] = {"2Rnd_GAT_missiles_hard","5Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
	};
};
class SensorTemplateLaser;
class CfgMagazines
{
	class Titan_AT;
	class 5Rnd_GAT_missiles;
	class Titan_AT_Hard: Titan_AT
	{
		ammo = "M_Titan_AT_Hard";
		displayName = "Titan EP Missile";
		displayNameShort = "EP";
		descriptionShort = "Type: Anti-Tank(EP)<br />Rounds: 1<br />Used in: Titan MPRL Compact";
	};
	class 5Rnd_GAT_missiles_hard: 5Rnd_GAT_missiles
	{
		displayName = "Titan Missile EP";
		displayNameShort = "EP";
		ammo = "M_Titan_AT_Hard";
	};
	class 1Rnd_GAT_missiles_hard: 5Rnd_GAT_missiles_hard
	{
		ammo = "M_Titan_AT_static_hard";
		count = 1;
		initSpeed = 320;
		maxLeadSpeed = 320;
	};
	class 2Rnd_GAT_missiles_hard: 5Rnd_GAT_missiles_hard
	{
		count = 2;
	};
};
class CfgAmmo
{
	class MissileBase;
	class M_Titan_AT_static;
	class M_Titan_AT: MissileBase
	{
		class Components;
	};
	class M_Titan_AT_Hard: M_Titan_AT
	{
		weaponLockSystem = "4+16";
		class Components: Components
		{
			class SensorsManagerComponent
			{
				class Components
				{
					class LaserSensorComponent: SensorTemplateLaser
					{
						class AirTarget
						{
							minRange = 4000;
							maxRange = 4000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
						class GroundTarget
						{
							minRange = 4000;
							maxRange = 4000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
						maxTrackableSpeed = 35;
						angleRangeHorizontal = 7;
						angleRangeVertical = 4.5;
						maxTrackableATL = 100;
					};
				};
			};
		};
	};
	class M_Titan_AT_static_Hard: M_Titan_AT_static
	{
		weaponLockSystem = "2+4+16";
		irLock = 0;
	};
	class TimeBombCore;
	class DirectionalBombCore;
	class DirectionalBombBase: DirectionalBombCore{};
	class APERSTripMine_Wire_Ammo: DirectionalBombBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class MineCore;
	class MineBase;
	class APERSMine_Range_Ammo: MineBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class BoundingMineCore: TimeBombCore{};
	class BoundingMineBase: BoundingMineCore
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class APERSBoundingMine_Range_Ammo: BoundingMineBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class ATMine_Range_Ammo: MineBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class PipeBombCore;
	class PipeBombBase;
	class SatchelCharge_Remote_Ammo: PipeBombBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class SLAMDirectionalMine_Wire_Ammo: DirectionalBombBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class DemoCharge_Remote_Ammo: PipeBombBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class ClaymoreDirectionalMine_Remote_Ammo: DirectionalBombBase
	{
		soundActivation[] = {};
		soundDeactivation[] = {};
	};
	class FlareCore;
	class FlareBase: FlareCore
	{
		intensity = 500000;
	};
	class Flare_82mm_AMOS_White: FlareCore
	{
		intensity = 1000000;
	};
};
class CfgWeapons
{
	class launch_Titan_base;
	class MissileLauncher;
	class missiles_titan: MissileLauncher
	{
		magazineWell[] = {"RBC_Static_Titan_AT"};
	};
	class missiles_titan_static: missiles_titan
	{
		magazineWell[] = {"RBC_Static_Titan_AT"};
	};
	class launch_Titan_short_base: launch_Titan_base
	{
		magazines[] += {"Titan_AT_Hard"};
	};
};
class RenderTargets;
class Gunner_display;
class commander_display;
class CameraView1;
class CfgVehicles
{
 	class MRAP_01_base_F;
	class MRAP_02_base_F;
	class Car;
    class Car_F: Car {class Turrets {class MainTurret;};};
	class Boat_F;
	class NonStrategic;
	class Land_Pallet_static_F: NonStrategic
	{
		mapSize = 2.25;
		author = "$STR_A3_Bohemia_Interactive";
		_generalMacro = "Land_Pallet_F";
		scope = 2;
		scopeCurator = 2;
		displayName = "$STR_A3_CfgVehicles_Land_Pallet_F0";
		model = "\A3\Structures_F\Civ\Constructions\Pallet_F.p3d";
		icon = "iconObject_1x1";
		vehicleClass = "Cargo";
		destrType = "DestructNo";
		cost = 100;
		class DestructionEffects{};
	};
	class Land_Pallet_vertical_static_F: NonStrategic
	{
		mapSize = 1.53;
		author = "$STR_A3_Bohemia_Interactive";
		_generalMacro = "Land_Pallet_vertical_F";
		scope = 2;
		scopeCurator = 2;
		displayName = "$STR_A3_CfgVehicles_Land_Pallet_vertical_F0";
		model = "\A3\Structures_F\Civ\Constructions\Pallet_vertical_F.p3d";
		icon = "iconObject_10x1";
		vehicleClass = "Cargo";
		destrType = "DestructNo";
		cost = 100;
		class DestructionEffects{};
	};
	

    class O_APC_Tracked_02_cannon_F {class Turrets;};
	class O_APC_Tracked_02_cannon_hard_F: O_APC_Tracked_02_cannon_F {
		displayName = "BTR-K Kamysh HARD";
		class MainTurret;
		class Turrets : Turrets {
			class MainTurret : MainTurret {
						magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Green","140Rnd_30mm_MP_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","200Rnd_762x51_Belt_Green","2Rnd_GAT_missiles_hard","2Rnd_GAT_missiles_hard"};
			};
		};
    };
	
	class I_APC_Wheeled_03_cannon_F {class Turrets;};
	class I_APC_Wheeled_03_cannon_hard_F:I_APC_Wheeled_03_cannon_F
	{
		displayName = "AFV-4 Gorgon HARD";
		class MainTurret;
		class Turrets : Turrets {
			class MainTurret : MainTurret {
				magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Yellow","140Rnd_30mm_MP_shells_Tracer_Yellow","60Rnd_30mm_APFSDS_shells_Tracer_Yellow","60Rnd_30mm_APFSDS_shells_Tracer_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","200Rnd_762x51_Belt_Yellow","2Rnd_GAT_missiles_hard","2Rnd_GAT_missiles_hard"};
			};
		};
	};
	
    class LSV_01_base_F: Car_F {
        class Turrets: Turrets {};
    };
    class LSV_01_AT_base_F: LSV_01_base_F {
		class Turrets: Turrets
		{
			class TopTurret: MainTurret{};
			class CodRiverTurret: MainTurret{};
		};
	};
	
	class B_LSV_01_AT_F : LSV_01_AT_base_F {};
	class B_LSV_01_AT_hard_F : B_LSV_01_AT_F{
		displayName = "Prowler(AT) HARD";
		class Turrets : Turrets {
			class TopTurret : TopTurret {
				magazines[] = {"1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
			};
		};
	};
	
	class LandVehicle;
	class StaticWeapon: LandVehicle {
        class Turrets;
    };
    class StaticMGWeapon: StaticWeapon {
        class Turrets: Turrets {
            class MainTurret;
        };
    };
    class AT_01_base_F: StaticMGWeapon {};
	
	class B_static_AT_F : AT_01_base_F {};
	class B_static_AT_hard_F : B_static_AT_F {
		displayName = "Static Titan Launcher (AT)[NATO] HARD";
		class Turrets : Turrets {
			class MainTurret : MainTurret {
				magazines[] = {"1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
			};
		};
	};
	class O_static_AT_F : AT_01_base_F {};
	class O_static_AT_hard_F : O_static_AT_F {
		displayName = "Static Titan Launcher (AT)[CSAT] HARD";
		class Turrets : Turrets {
			class MainTurret : MainTurret {
				magazines[] = {"1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
			};
		};
	};
	class I_static_AT_F : AT_01_base_F {};
	class I_static_AT_hard_F : I_static_AT_F {
		displayName = "Static Titan Launcher (AT)[AAF] HARD";
		class Turrets : Turrets {
			class MainTurret : MainTurret {
				magazines[] = {"1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
			};
		};
	};
	
	class I_E_Static_AT_F : I_static_AT_F {};
	class I_E_Static_AT_hard_F : I_E_Static_AT_F {
		displayName = "Static Titan Launcher (AT)[LDF] HARD";
		class Turrets : Turrets {
			class MainTurret : MainTurret {
				magazines[] = {"1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard","1Rnd_GAT_missiles_hard"};
			};
		};
	};
	

	
	class Boat_Armed_01_base_F: Boat_F
	{
		class RenderTargets
		{
			class Gunner_TV
			{
				class CameraView1
				{
					renderVisionMode = 1;
				};
			};
		};
	};
	class MRAP_01_gmg_base_F: MRAP_01_base_F
	{
		class RenderTargets
		{
			class Gunner_display
			{
				class CameraView1
				{
					renderVisionMode = 0;
				};
			};
		};
	};
	class MRAP_03_base_F: Car_F
	{
		class RenderTargets
		{
			class commander_display
			{
				class CameraView1
				{
					renderVisionMode = 0;
				};
			};
		};
	};
	class MRAP_03_hmg_base_F: MRAP_03_base_F
	{
		class RenderTargets
		{
			class commander_display
			{
				class CameraView1
				{
					renderVisionMode = 0;
				};
			};
			class gunner_display
			{
				class CameraView1
				{
					renderVisionMode = 0;
				};
			};
		};
	};
	class MRAP_02_hmg_base_F: MRAP_02_base_F
	{
		class RenderTargets
		{
			class gunner_display
			{
				class CameraView1
				{
					renderVisionMode = 0;
				};
			};
		};
	};
};
