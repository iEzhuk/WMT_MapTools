/*
 	Name: WMT_fnc_Init
 
 	Author(s):
		Ezhuk

 	Description:
		Initialize all  
*/
#include "defines.sqf"

if(isNil "wmt_param_ViewDistance") then {
	wmt_param_ViewDistance = getNumber (MissionConfigFile >> "WMT_Params" >> "ViewDistance");
};
if(isNil "wmt_param_TI") then {
	wmt_param_TI = getNumber (MissionConfigFile >> "WMT_Params" >> "EnableTI");
};
if(isNil "wmt_param_NameTag") then {
	wmt_param_NameTag = getNumber (MissionConfigFile >> "WMT_Params" >> "WinnerByTime");
};
if(isNil "wmt_param_MissionTime") then {
	wmt_param_MissionTime = getNumber (MissionConfigFile >> "WMT_Params" >> "MissionTime");
};
if(isNil "wmt_param_WinnerByTime") then {
	PR(_txt) = getText (MissionConfigFile >> "WMT_Params" >> "WinnerByTime");
	if(_txt != "") then {
		wmt_param_WinnerByTime = call compile _txt;
	}else {
		wmt_param_WinnerByTime = sideLogic;
	};
};
if(isNil "wmt_param_WinnerByTimeText") then {
	wmt_param_WinnerByTimeText = getText (MissionConfigFile >> "WMT_Params" >> "MessageOfEnd");
};	
if(isNil "wmt_param_PrepareTime") then {
	wmt_param_PrepareTime = getNumber (MissionConfigFile >> "WMT_Params" >> "PrepareTime");
};
if(isNil "wmt_param_StartZone") then {
	wmt_param_StartZone = getNumber (MissionConfigFile >> "WMT_Params" >> "StartZone");
};
if(isNil "wmt_param_RemoveBots") then {
	wmt_param_RemoveBots = getNumber (MissionConfigFile >> "WMT_Params" >> "RemoveBots");
};

if(isNil "wmt_param_HeavyLossesCoeff") then {
	wmt_param_HeavyLossesCoeff = getNumber (MissionConfigFile >> "WMT_Params" >> "HeavyLossesCoeff");
};

// Check variables 
wmt_param_ViewDistance = 10 max wmt_param_ViewDistance;
wmt_param_TI = 0 max (2 min wmt_param_TI);
wmt_param_NameTag = 0 max (1 min wmt_param_NameTag);
wmt_param_MissionTime = 0 max wmt_param_MissionTime;
wmt_param_PrepareTime = 0 max wmt_param_PrepareTime;
wmt_param_StartZone = 10 max wmt_param_StartZone;
wmt_param_RemoveBots = 0 max wmt_param_RemoveBots;
wmt_param_HeavyLossesCoeff = 0.01 max wmt_param_HeavyLossesCoeff;

//================================================
//					SERVER
//================================================
if(isServer || isDedicated) then {
	[] spawn {
		["vehicle", [(wmt_param_TI==1)]] call WMT_fnc_DisableTI;
		[wmt_param_PrepareTime] call WMT_fnc_PrepareTime_server;
		if(wmt_param_MissionTime>0) then {
			[wmt_param_MissionTime,wmt_param_WinnerByTime,wmt_param_WinnerByTimeText] call WMT_fnc_EndMissionByTime;
		};
		[wmt_param_HeavyLossesCoeff, wmt_param_PrepareTime] call WMT_fnc_HeavyLossesCheck;
	};

}; 

//================================================
//					CLIENT
//================================================
if(hasInterface) then {
	[] spawn {
		waitUntil{player==player};
		waitUntil{alive player};
		waitUntil{local player};

		WMT_Local_Killer = [];
		WMT_Local_Kills = [];
		WMT_Local_PlayerName = name player;
		WMT_Local_PlayerSide = side player;

		player setVariable ["WMT_PlayerName",WMT_Local_PlayerName,true];
		player setVariable ["WMT_PlayerSide",WMT_Local_PlayerSide,true];

		// Control veiw distance 
		["loop"] spawn WMT_fnc_handlerOptions;

		// Update information about admin (1 time in 15s)
		["loop"] spawn WMT_fnc_handlerFeedback;

		// Disable TI with using RscTitle 
		if(wmt_param_TI == 2) then {
			IDD_DISABLETI cutRsc ["RscDisableTI","PLAIN"];
		};

		// Show tag with name for near unit
		if(wmt_param_NameTag>0) then {
			IDD_NAMETAG cutRsc ["RscNameTag","PLAIN"];
		};

		// Add rating to disable change side to ENEMY 
		if(rating player < 100000) then {
			[] spawn {sleep 1;player addRating 500000;};
		};

		[] spawn {
			waitUntil {!(isNull (findDisplay 46))};
			(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call WMT_fnc_KeyDown"];
		};

		player addEventHandler ["killed", "_this spawn WMT_fnc_PlayerKilled"];

		// Public variable handlers 
		"WMT_Global_EndMission" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_EndMission };
		"WMT_Global_Announcement" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_Announcement };
		"WMT_Global_AddKills" addPublicVariableEventHandler { WMT_Local_Kills=WMT_Local_Kills+(_this select 1) };

		// briefing
		[] call WMT_fnc_BriefingVehicles;
		[] call WMT_fnc_BriefingSquads;

		[wmt_param_PrepareTime,wmt_param_StartZone] spawn WMT_fnc_PrepareTime_client;
	};
};