class CfgPatches
{
	class ATFixes
	{
		units[] = {};
		weapons[] = {"launch_Titan_short_base","missiles_titan_static","missiles_titan"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_Launchers_Titan"};
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
