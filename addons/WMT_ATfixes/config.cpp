class CfgPatches
{
	class ATFixes
	{
		units[] = {"MRAP_01_gmg_base_F","MRAP_03_hmg_base_F","MRAP_02_hmg_base_F","MRAP_03_base_F","Boat_Armed_01_base_F", "Land_Pallet_static_F", "Land_Pallet_vertical_static_F"};
		weapons[] = {"launch_Titan_short_base","missiles_titan_static","missiles_titan"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_Launchers_Titan","A3_Soft_F","A3_Boat_F_Boat_Armed_01","A3_Boat_F","A3_Structures_F_Civ_Constructions","A3_Data_F","A3_Weapons_F_Explosives"};
		authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
		author[]= {"Zealot, Ezhuk"};
		version = 1.5.0;
		versionStr = "1.5.0";
		versionAr[] = {1,5,0};
	};
};

class CfgMagazines
{
	class CA_Magazine;
	class CA_LauncherMagazine;
	class Titan_AT;
	class 5Rnd_GAT_missiles;

	class Titan_AT_Hard : Titan_AT {
        ammo = "M_Titan_AT_Hard";
        displayName = "Titan EP Missile";
        displayNameShort = "EP";
        descriptionShort = "Type: Anti-Tank(EP)<br />Rounds: 1<br />Used in: Titan MPRL Compact";
    };

	class 5Rnd_GAT_missiles_hard : 5Rnd_GAT_missiles {
        displayName = "Titan Missile EP";
        displayNameShort = "EP";
        ammo = "M_Titan_AT_Hard";
    };

    class 1Rnd_GAT_missiles_hard : 5Rnd_GAT_missiles_hard {
        ammo = "M_Titan_AT_static_hard";
        count = 1;
        initSpeed = 320;
        maxLeadSpeed = 320;
    };

    class 2Rnd_GAT_missiles_hard : 5Rnd_GAT_missiles_hard {
        count = 2;
    };

};

class CfgAmmo
{
	class BulletBase;
	class MissileBase;
	class ShellBase;
	class RocketBase;
	class M_Titan_AT;
	class M_Titan_AT_static;


	class M_Titan_AT_Hard : M_Titan_AT {
		weaponLockSystem = "2+4+16";
        irLock = 0;
    };

	class M_Titan_AT_static_Hard : M_Titan_AT_static {
		weaponLockSystem = "2+4+16";
		irLock = 0;
    };

	class Default;
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
	class Default;
	class Launcher;
	class Launcher_Base_F: Launcher
	{
		class WeaponSlotsInfo;
	};
	class launch_Titan_base;
	class MissileLauncher;

	class missiles_titan: MissileLauncher {
		magazines[] = {"2Rnd_GAT_missiles", "5Rnd_GAT_missiles", "4Rnd_GAA_missiles", "4Rnd_Titan_long_missiles","2Rnd_GAT_missiles_hard","5Rnd_GAT_missiles_hard"};
	};

	class missiles_titan_static : missiles_titan {
        magazines[] = {"1Rnd_GAT_missiles", "1Rnd_GAA_missiles","1Rnd_GAT_missiles_hard"};
    };

	class launch_Titan_short_base : launch_Titan_base {
		magazines[] = {"Titan_AT", "Titan_AP","Titan_AT_Hard"};
	};

};


class RenderTargets;
class Gunner_display;
class commander_display ;
class CameraView1;

class CfgVehicles {
	class MRAP_01_base_F;
	class MRAP_02_base_F;
	class Car_F;
	class Boat_F;
	class NonStrategic;

	class Land_Pallet_static_F : NonStrategic {
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

	class Land_Pallet_vertical_static_F : NonStrategic {
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

	class Boat_Armed_01_base_F : Boat_F {
		class RenderTargets {
            class Gunner_TV {
                class CameraView1 {
                    renderVisionMode = 1;
                };
			};
		};
	};

	class MRAP_01_gmg_base_F : MRAP_01_base_F {
		class RenderTargets {
            class Gunner_display {
                class CameraView1 {
                    renderVisionMode = 0;

                };
            };
        };
	};

	class MRAP_03_base_F : Car_F {
		class RenderTargets {
			class commander_display {
                class CameraView1 {
                    renderVisionMode = 0;
                };
            };
		};
	};

	class MRAP_03_hmg_base_F : MRAP_03_base_F {
		class RenderTargets {
			class commander_display {
                class CameraView1 {
                    renderVisionMode = 0;
                };
            };
			class gunner_display {
                class CameraView1 {
                    renderVisionMode = 0;
                };
            };
		};
	};

	class MRAP_02_hmg_base_F : MRAP_02_base_F {
		class RenderTargets {
			class gunner_display {
                class CameraView1 {
                    renderVisionMode = 0;
                };
            };
		};
	};
};
