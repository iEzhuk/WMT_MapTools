#define _ARMA_

//Class WMT_noUI : config.bin{
class CfgPatches
{
	class WMT_noUI
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_UI_F","A3_DATA_F"};
		author = "Zealot";
		authorUrl = "https://github.com/Zealot111/WMT_MapTools";
		magazines[] = {};
		ammo[] = {};
	};
};
class Extended_PreInit_EventHandlers
{
	class wmt_rbc_admins
	{
		init = "WMT_global_EnableConsole = ['76561198015283887'];wmt_feature_briefTimer=1;wmt_feature_frzLegacyActions=1;";
	};
};
class CfgMarkers
{
	class Flag{};
	class b_unknown: Flag
	{
		shadow = 1;
	};
};
class cfgInGameUI
{
	class CommandBar
	{
		left = 0;
		top = 7777;
	};
	class Cursor
	{
		size = "0";
		select = "\WMT_noUI\empty.paa";
		leader = "\WMT_noUI\empty.paa";
		mission = "\WMT_noUI\empty.paa";
		customMark = "\WMT_noUI\empty.paa";
		outArrow = "\WMT_noUI\empty.paa";
		selectColor[] = {0,0,0,0};
		leaderColor[] = {0,0,0,0};
		customMarkColor[] = {0,0,0,0};
	};
	class PeripheralVision
	{
		cueTexture = "A3\ui_f\data\igui\cfg\PeripheralVision\cueTexture_gs.paa";
		bloodTexture = "A3\ui_f\data\igui\cfg\PeripheralVision\bloodTexture_ca.paa";
		bloodColor[] = {1,1,1,0.75};
		cueColor[] = {0,0,0,0};
		cueEnemyColor[] = {0,0,0,0};
		cueFriendlyColor[] = {0,0,0,0};
	};
};
class RscMapControl
{
	maxSatelliteAlpha = 0.55;
	colorMainCountlines[] = {0.82,0,0};
	colorBackground[] = {0.92,0.92,0.92,1};
	colorCountlines[] = {0.64,0.52,0.3,1};
	colorLevels[] = {0,0,0,1};
	sizeExLevel = 0.025;
	colorTracks[] = {1.0,0.0,0.0,1};
	colorTracksFill[] = {1.0,1.0,0.0,1};
	colorRoads[] = {0.0,0.0,0.0,1};
	colorRoadsFill[] = {1,1,0,1};
	colorMainRoads[] = {0.0,0.0,0.0,1};
	colorMainRoadsFill[] = {1,0.62,0.43,1};
};
class CfgDiary
{
	class FixedPages
	{
		class Units
		{
			type = "";
		};
		class Statistics
		{
			type = "";
		};
	};
	class Icons
	{
		playerWest = "A3\ui_f\data\map\diary\icons\playerUnknown_ca.paa";
		playerEast = "A3\ui_f\data\map\diary\icons\playerUnknown_ca.paa";
		playerCiv = "A3\ui_f\data\map\diary\icons\playerUnknown_ca.paa";
		playerGuer = "A3\ui_f\data\map\diary\icons\playerUnknown_ca.paa";
	};
};
class RscControlsGroup;
class RscXSliderH;
class RscEdit;
class CA_TextDisplayMode;
class RscText;
class RscPicture;
class RscObject;
class RscDisplayOptionsVideo
{
	class Controls
	{
		class QualityGroup: RscControlsGroup
		{
			class controls
			{
				class CA_SliderBrightness: RscText
				{
					idc = 112;
					x = "8 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					y = "8.5 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "8 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Для медвежат";
					tooltip = "Перезайдите без модов RBC чтобы отредактировать яркость";
				};
				class CA_ValueBrightness: RscText
				{
					idc = 111;
					style = 0;
					x = "16.2 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					y = "8.5 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					tooltip = "Перезайдите в игру без модов RBC чтобы отредактировать яркость";
				};
				class CA_SliderGamma: RscText
				{
					idc = 110;
					x = "8 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					y = "10 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "8 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					tooltip = "Перезайдите в игру без модов RBC чтобы отредактировать гамму";
					text = "Для медвежат";
				};
				class CA_ValueGamma: RscText
				{
					idc = 109;
					style = 0;
					x = "16.2 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					y = "10 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 *    (   ((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 *    (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					tooltip = "Перезайдите в игру без модов RBC чтобы отредактировать гамму";
				};
			};
		};
	};
};
class RscActiveText;
class RscDisplayMainMap
{
	class controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				class ButtonPlayer: RscActiveText
				{
					text = "";
					w = 0;
					h = 0;
					sizeEx = 0;
					onButtonClick = "";
				};
				class CA_PlayerName: RscText
				{
					x = "2 *    ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class ProfilePicture: RscPicture
				{
					x = "13.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class ProfileBackground: RscText
				{
					x = "13.3 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class Separator1: RscPicture
				{
					x = "14.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
			};
		};
	};
	class objects
	{
		class Compass: RscObject
		{
			scale = 0.9;
			zoomDuration = 0;
		};
	};
};
class RscDisplayDiary
{
	class controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				class ButtonPlayer: RscActiveText
				{
					text = "";
					w = 0;
					h = 0;
					sizeEx = 0;
					onButtonClick = "";
				};
				class CA_PlayerName: RscText
				{
					x = "2 *    ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class ProfilePicture: RscPicture
				{
					x = "13.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class ProfileBackground: RscText
				{
					x = "13.3 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class Separator1: RscPicture
				{
					x = "14.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
				};
			};
		};
	};
	class objects
	{
		class Compass: RscObject
		{
			scale = 0.9;
			zoomDuration = 0;
		};
	};
};
class RscDisplayGetReady: RscDisplayMainMap
{
	class Controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				class ButtonPlayer: RscActiveText
				{
					onbuttonclick = "";
					color[] = {0,0,0,0};
					text = "\WMT_noUI\empty.paa";
					colorText[] = {0,0,0,0};
					colorActive[] = {0,0,0,0};
					tooltip = "";
				};
			};
		};
	};
};
class RscDisplayServerGetReady: RscDisplayGetReady
{
	class Controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				class ButtonPlayer: RscActiveText
				{
					onbuttonclick = "";
					color[] = {0,0,0,0};
					text = "\WMT_noUI\empty.paa";
					colorText[] = {0,0,0,0};
					colorActive[] = {0,0,0,0};
					tooltip = "";
				};
			};
		};
	};
};
class RscDisplayClientGetReady: RscDisplayGetReady
{
	class Controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				class ButtonPlayer: RscActiveText
				{
					onbuttonclick = "";
					color[] = {0,0,0,0};
					text = "\WMT_noUI\empty.paa";
					colorText[] = {0,0,0,0};
					colorActive[] = {0,0,0,0};
					tooltip = "";
				};
			};
		};
	};
};
class CfgDifficultyPresets
{
	defaultPreset = "Regular";
	myArmorCoef = 1.5;
	groupArmorCoef = 1.5;
	recoilCoef = 1;
	visionAidCoef = 0.8;
	divingLimitMultiplier = 1.0;
	animSpeedCoef = 0;
	cancelThreshold = 0;
	showCadetHints = 1;
	showCadetWP = 1;
	class Recruit
	{
		displayName = "Elite";
		optionDescription = "Elite Settings";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options
		{
			reducedDamage = 0;
			groupIndicators = 0;
			friendlyTags = 0;
			enemyTags = 0;
			detectedMines = 0;
			commands = 0;
			waypoints = 0;
			weaponInfo = 1;
			stanceIndicator = 1;
			staminaBar = 1;
			weaponCrosshair = 0;
			visionAid = 0;
			thirdPersonView = 0;
			cameraShake = 1;
			scoreTable = 0;
			deathMessages = 0;
			vonID = 1;
			mapContent = 0;
			autoReport = 0;
			multipleSaves = 0;
			tacticalPing = 0;
			squadRadar = 0;
		};
	};
	class Regular
	{
		displayName = "Elite";
		optionDescription = "Elite Settings";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options
		{
			reducedDamage = 0;
			groupIndicators = 0;
			friendlyTags = 0;
			enemyTags = 0;
			detectedMines = 0;
			commands = 0;
			waypoints = 0;
			weaponInfo = 1;
			stanceIndicator = 1;
			staminaBar = 1;
			weaponCrosshair = 0;
			visionAid = 0;
			thirdPersonView = 0;
			cameraShake = 1;
			scoreTable = 0;
			deathMessages = 0;
			vonID = 1;
			mapContent = 0;
			autoReport = 0;
			multipleSaves = 0;
			tacticalPing = 0;
			squadRadar = 0;
		};
	};
	class Veteran
	{
		displayName = "Elite";
		optionDescription = "Elite Settings";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options
		{
			reducedDamage = 0;
			groupIndicators = 0;
			friendlyTags = 0;
			enemyTags = 0;
			detectedMines = 0;
			commands = 0;
			waypoints = 0;
			weaponInfo = 1;
			stanceIndicator = 1;
			staminaBar = 1;
			weaponCrosshair = 0;
			visionAid = 0;
			thirdPersonView = 0;
			cameraShake = 1;
			scoreTable = 0;
			deathMessages = 0;
			vonID = 1;
			mapContent = 0;
			autoReport = 0;
			multipleSaves = 0;
			tacticalPing = 0;
			squadRadar = 0;
		};
	};
	class Custom
	{
		displayName = "Elite";
		optionDescription = "Elite Settings";
		optionPicture = "\A3\Ui_f\data\Logos\arma3_white_ca.paa";
		class Options
		{
			reducedDamage = 0;
			groupIndicators = 0;
			friendlyTags = 0;
			enemyTags = 0;
			detectedMines = 0;
			commands = 0;
			waypoints = 0;
			weaponInfo = 1;
			stanceIndicator = 1;
			staminaBar = 1;
			weaponCrosshair = 0;
			visionAid = 0;
			thirdPersonView = 0;
			cameraShake = 1;
			scoreTable = 0;
			deathMessages = 0;
			vonID = 1;
			mapContent = 0;
			autoReport = 0;
			multipleSaves = 0;
			tacticalPing = 0;
			squadRadar = 0;
		};
	};
};
class CfgDifficulties
{
	default = "Regular";
	defaultNormal = "Regular";
	defaultEasy = "Regular";
	defaultHard = "Veteran";
	class Recruit
	{
		displayName = "$STR_Difficulty3";
		description = "$STR_Difficulty3_desc";
		showCadetHints = 0;
		showCadetWP = 0;
		maxPilotHeight = 10000;
		scoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		scoreChar = "*";
		badScoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		badScoreChar = "X";
		skillFriendly = 1.0;
		precisionFriendly = 1.0;
		skillEnemy = 0.85;
		precisionEnemy = 0.85;
		myArmorCoef = 1;
		groupArmorCoef = 1;
		autoAimSizeFactor = 0.3;
		autoAimDistance = 0.6;
		autoAimAngle = 2.5;
		peripheralVisionAid = 0.25;
		visionAid = 0;
		HealSoldierSelf = 0.2;
		HealPartialMedikSelf = 0.5;
		HealFullMedikSelf = 0.9;
		HealSoldierOther = 0.4;
		healPartialMedikOther = 0.7;
		healFullMedikOther = 1.0;
		HealSpeedMedicMedikit = 0.08;
		HealSpeedMedicFAK = 0.064;
		HealSpeedMedic = 0.064;
		HealSpeedSoldierFAK = 0.032;
		HealSpeedSoldier = 0.032;
		StabilizeSoldierSelf = 0.0;
		StabilizeSoldierOther = 0.0;
		StabilizeSoldierWithBandageSelf = 0.5;
		StabilizeSoldierWithBandageOther = 1.0;
		StabilizeMedicWithBandageSelf = 1.0;
		StabilizeMedicWithBandageOther = 1000.0;
		StabilizeMedicWithMedikitSelf = 1000.0;
		StabilizeMedicWithMedikitOther = 1000.0;
		BleedingRate = 0.011;
		CancelThreshold = 0;
		CancelTime = 2.0;
		DivingLimitMultiplier = 0.65;
		recoilCoef = 1;
		autoReload = 0;
		animSpeedCoef = 0;
		class Flags
		{
			armor[] = {0,0};
			friendlyTag[] = {0,0};
			enemyTag[] = {0,0};
			mineTag[] = {0,0};
			hud[] = {0,0};
			hudPerm[] = {0,0};
			hudWp[] = {0,0};
			hudWpPerm[] = {0,0};
			autoSpot[] = {0,0};
			map[] = {0,0};
			weaponCursor[] = {0,0};
			autoGuideAT[] = {0,0};
			clockIndicator[] = {0,0};
			3rdPersonView[] = {0,0};
			stanceIndicator[] = {1,0};
			autoAim[] = {0,0};
			unlimitedSaves[] = {0,0};
			deathMessages[] = {0,0};
			netStats[] = {0,0};
			vonID[] = {1,0};
			cameraShake[] = {1,0};
			hudGroupInfo[] = {0,0};
			extendetInfoType[] = {0,0};
			roughLanding[] = {0,0};
			windEnabled[] = {1,0};
			autoTrimEnabled[] = {0,0};
			stressDamageEnabled[] = {1,0};
		};
	};
	class Regular
	{
		displayName = "$STR_Difficulty3";
		description = "$STR_Difficulty3_desc";
		showCadetHints = 0;
		showCadetWP = 0;
		maxPilotHeight = 10000;
		scoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		scoreChar = "*";
		badScoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		badScoreChar = "X";
		skillFriendly = 1.0;
		precisionFriendly = 1.0;
		skillEnemy = 0.85;
		precisionEnemy = 0.85;
		myArmorCoef = 1;
		groupArmorCoef = 1;
		autoAimSizeFactor = 0.3;
		autoAimDistance = 0.6;
		autoAimAngle = 2.5;
		peripheralVisionAid = 0.25;
		visionAid = 0;
		HealSoldierSelf = 0.2;
		HealPartialMedikSelf = 0.5;
		HealFullMedikSelf = 0.9;
		HealSoldierOther = 0.4;
		healPartialMedikOther = 0.7;
		healFullMedikOther = 1.0;
		HealSpeedMedicMedikit = 0.08;
		HealSpeedMedicFAK = 0.064;
		HealSpeedMedic = 0.064;
		HealSpeedSoldierFAK = 0.032;
		HealSpeedSoldier = 0.032;
		StabilizeSoldierSelf = 0.0;
		StabilizeSoldierOther = 0.0;
		StabilizeSoldierWithBandageSelf = 0.5;
		StabilizeSoldierWithBandageOther = 1.0;
		StabilizeMedicWithBandageSelf = 1.0;
		StabilizeMedicWithBandageOther = 1000.0;
		StabilizeMedicWithMedikitSelf = 1000.0;
		StabilizeMedicWithMedikitOther = 1000.0;
		BleedingRate = 0.011;
		CancelThreshold = 0;
		CancelTime = 2.0;
		DivingLimitMultiplier = 0.65;
		recoilCoef = 1;
		autoReload = 0;
		animSpeedCoef = 0;
		class Flags
		{
			armor[] = {0,0};
			friendlyTag[] = {0,0};
			enemyTag[] = {0,0};
			mineTag[] = {0,0};
			hud[] = {0,0};
			hudPerm[] = {0,0};
			hudWp[] = {0,0};
			hudWpPerm[] = {0,0};
			autoSpot[] = {0,0};
			map[] = {0,0};
			weaponCursor[] = {0,0};
			autoGuideAT[] = {0,0};
			clockIndicator[] = {0,0};
			3rdPersonView[] = {0,0};
			stanceIndicator[] = {1,0};
			autoAim[] = {0,0};
			unlimitedSaves[] = {0,0};
			deathMessages[] = {0,0};
			netStats[] = {0,0};
			vonID[] = {1,0};
			cameraShake[] = {1,0};
			hudGroupInfo[] = {0,0};
			extendetInfoType[] = {0,0};
			roughLanding[] = {0,0};
			windEnabled[] = {1,0};
			autoTrimEnabled[] = {0,0};
			stressDamageEnabled[] = {1,0};
		};
	};
	class Veteran
	{
		displayName = "$STR_Difficulty3";
		description = "$STR_Difficulty3_desc";
		showCadetHints = 0;
		showCadetWP = 0;
		maxPilotHeight = 10000;
		scoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		scoreChar = "*";
		badScoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		badScoreChar = "X";
		skillFriendly = 1.0;
		precisionFriendly = 1.0;
		skillEnemy = 0.85;
		precisionEnemy = 0.85;
		myArmorCoef = 1;
		groupArmorCoef = 1;
		autoAimSizeFactor = 0.3;
		autoAimDistance = 0.6;
		autoAimAngle = 2.5;
		peripheralVisionAid = 0.25;
		visionAid = 0;
		HealSoldierSelf = 0.2;
		HealPartialMedikSelf = 0.5;
		HealFullMedikSelf = 0.9;
		HealSoldierOther = 0.4;
		healPartialMedikOther = 0.7;
		healFullMedikOther = 1.0;
		HealSpeedMedicMedikit = 0.08;
		HealSpeedMedicFAK = 0.064;
		HealSpeedMedic = 0.064;
		HealSpeedSoldierFAK = 0.032;
		HealSpeedSoldier = 0.032;
		StabilizeSoldierSelf = 0.0;
		StabilizeSoldierOther = 0.0;
		StabilizeSoldierWithBandageSelf = 0.5;
		StabilizeSoldierWithBandageOther = 1.0;
		StabilizeMedicWithBandageSelf = 1.0;
		StabilizeMedicWithBandageOther = 1000.0;
		StabilizeMedicWithMedikitSelf = 1000.0;
		StabilizeMedicWithMedikitOther = 1000.0;
		BleedingRate = 0.011;
		CancelThreshold = 0;
		CancelTime = 2.0;
		DivingLimitMultiplier = 0.65;
		recoilCoef = 1;
		autoReload = 0;
		animSpeedCoef = 0;
		class Flags
		{
			armor[] = {0,0};
			friendlyTag[] = {0,0};
			enemyTag[] = {0,0};
			mineTag[] = {0,0};
			hud[] = {0,0};
			hudPerm[] = {0,0};
			hudWp[] = {0,0};
			hudWpPerm[] = {0,0};
			autoSpot[] = {0,0};
			map[] = {0,0};
			weaponCursor[] = {0,0};
			autoGuideAT[] = {0,0};
			clockIndicator[] = {0,0};
			3rdPersonView[] = {0,0};
			stanceIndicator[] = {1,0};
			autoAim[] = {0,0};
			unlimitedSaves[] = {0,0};
			deathMessages[] = {0,0};
			netStats[] = {0,0};
			vonID[] = {1,0};
			cameraShake[] = {1,0};
			hudGroupInfo[] = {0,0};
			extendetInfoType[] = {0,0};
			roughLanding[] = {0,0};
			windEnabled[] = {1,0};
			autoTrimEnabled[] = {0,0};
			stressDamageEnabled[] = {1,0};
		};
	};
	class Mercenary
	{
		displayName = "$STR_Difficulty3";
		description = "$STR_Difficulty3_desc";
		showCadetHints = 0;
		showCadetWP = 0;
		maxPilotHeight = 10000;
		scoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		scoreChar = "*";
		badScoreImage = "#(argb,8,8,3)color(1,1,1,1)";
		badScoreChar = "X";
		skillFriendly = 1.0;
		precisionFriendly = 1.0;
		skillEnemy = 0.85;
		precisionEnemy = 0.85;
		myArmorCoef = 1;
		groupArmorCoef = 1;
		autoAimSizeFactor = 0.3;
		autoAimDistance = 0.6;
		autoAimAngle = 2.5;
		peripheralVisionAid = 0.25;
		visionAid = 0;
		HealSoldierSelf = 0.2;
		HealPartialMedikSelf = 0.5;
		HealFullMedikSelf = 0.9;
		HealSoldierOther = 0.4;
		healPartialMedikOther = 0.7;
		healFullMedikOther = 1.0;
		HealSpeedMedicMedikit = 0.08;
		HealSpeedMedicFAK = 0.064;
		HealSpeedMedic = 0.064;
		HealSpeedSoldierFAK = 0.032;
		HealSpeedSoldier = 0.032;
		StabilizeSoldierSelf = 0.0;
		StabilizeSoldierOther = 0.0;
		StabilizeSoldierWithBandageSelf = 0.5;
		StabilizeSoldierWithBandageOther = 1.0;
		StabilizeMedicWithBandageSelf = 1.0;
		StabilizeMedicWithBandageOther = 1000.0;
		StabilizeMedicWithMedikitSelf = 1000.0;
		StabilizeMedicWithMedikitOther = 1000.0;
		BleedingRate = 0.011;
		CancelThreshold = 0;
		CancelTime = 2.0;
		DivingLimitMultiplier = 0.65;
		recoilCoef = 1;
		autoReload = 0;
		animSpeedCoef = 0;
		class Flags
		{
			armor[] = {0,0};
			friendlyTag[] = {0,0};
			enemyTag[] = {0,0};
			mineTag[] = {0,0};
			hud[] = {0,0};
			hudPerm[] = {0,0};
			hudWp[] = {0,0};
			hudWpPerm[] = {0,0};
			autoSpot[] = {0,0};
			map[] = {0,0};
			weaponCursor[] = {0,0};
			autoGuideAT[] = {0,0};
			clockIndicator[] = {0,0};
			3rdPersonView[] = {0,0};
			stanceIndicator[] = {1,0};
			autoAim[] = {0,0};
			unlimitedSaves[] = {0,0};
			deathMessages[] = {0,0};
			netStats[] = {0,0};
			vonID[] = {1,0};
			cameraShake[] = {1,0};
			hudGroupInfo[] = {0,0};
			extendetInfoType[] = {0,0};
			roughLanding[] = {0,0};
			windEnabled[] = {1,0};
			autoTrimEnabled[] = {0,0};
			stressDamageEnabled[] = {1,0};
		};
	};
};
//};
