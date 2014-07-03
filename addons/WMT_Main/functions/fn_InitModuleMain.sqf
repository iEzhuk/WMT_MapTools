/*
 	Name: WMT_fnc_InitModuleMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;


if(_activated) then {
	//================================================
	//					SERVER
	//================================================
	if(isServer) then {
		// Disable TI in vehicles
		["vehicle", [(_logic getVariable "TI"==1)]] call WMT_fnc_DisableTI

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
		WMT_Param_ViewDistance = _logic getVariable "MaxViewDistance";
		["loop"] spawn WMT_fnc_handlerOptions;

		// Update information about admin (1 time in 15s)
		["loop"] spawn WMT_fnc_handlerFeedback;

		// Disable TI with using RscTitle 
		if(_logic getVariable "TI" == 2) then {
			IDD_DISABLETI cutRsc ["RscDisableTI","PLAIN"];
		};

		// Show tag with name for near unit
		if(_logic getVariable "NameTag") then {
			IDD_NAMETAG cutRsc ["RscNameTag","PLAIN"];
		};

		// Add rating to disable change side to ENEMY 
		if(_logic getVariable "AddRating") then {
			if(rating player < 100000) then {
				[] spawn {sleep 1;player addRating 500000;};
			};
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

	};
};
