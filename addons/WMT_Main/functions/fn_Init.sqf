/*
 	Name: WMT_fnc_Init
 
 	Author(s):
		Ezhuk

 	Description:
		Initialize all  
*/
#include "defines.sqf"

if(isNil "wmt_param_TI") then {
	wmt_param_TI = 0;
};
if(isNil "wmt_param_ViewDistance") then {
	wmt_param_ViewDistance = 2500;
};
if(isNil "wmt_param_NameTag") then {
	wmt_param_NameTag = true;
};
if(isNil "wmt_param_MissionTime") then {
	wmt_param_MissionTime = 0;
};
if(isNil "wmt_param_WinnerByTime") then {
	wmt_param_WinnerByTime = sideLogic;
};	
if(isNil "wmt_param_WinnerByTimeText") then {
	wmt_param_WinnerByTimeText = localize "STR_WMT_EndTime";
};	
if(isNil "wmt_param_PrepareTime") then {
	wmt_param_PrepareTime = 0;
};
if(isNil "wmt_param_StartZone") then {
	wmt_param_StartZone = 100;
};
if(isNil "wmt_param_RemoveBots") then {
	wmt_param_RemoveBots = 0;
};

//================================================
//					SERVER
//================================================
if(isServer) then {
	[] spawn {
		["vehicle", [(wmt_param_TI==1)]] call WMT_fnc_DisableTI;
		[wmt_param_PrepareTime] call WMT_fnc_PrepareTime_server;
		if(wmt_param_MissionTime>0) then {
			[wmt_param_MissionTime,wmt_param_WinnerByTime,wmt_param_WinnerByTimeText] call WMT_fnc_EndMissionByTime;
		};
	};

}; 


//================================================
//					CLIENT
//================================================
if(!isDedicated) then {
	waitUntil{player==player};
	waitUntil{alive player};
	waitUntil{local player};

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
	if(wmt_param_NameTag) then {
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

	// Public variable handlers 
	"WMT_Global_EndMission" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_EndMission };
	"WMT_Global_Announcement" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_Announcement };

	// briefing
	[] call WMT_fnc_BriefingVehicles;
	[] call WMT_fnc_BriefingSquads;

	[wmt_param_PrepareTime,wmt_param_StartZone] spawn WMT_fnc_PrepareTime_client;
};