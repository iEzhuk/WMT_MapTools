/*
 	Name: WMT_fnc_InitModuleMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#include "defines.sqf"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	if ( not isnil "wmt_Main_ModuleRunning" ) exitWith {};
	wmt_Main_ModuleRunning = true;

	if(isNil "wmt_param_TI") then {
		wmt_param_TI = _logic getVariable "TI";
	};
	if(isNil "wmt_param_MaxViewDistance") then {
		wmt_param_MaxViewDistance = _logic getVariable "MaxViewDistance";
	};
	if(isNil "wmt_param_NameTag") then {
		wmt_param_NameTag = _logic getVariable "NameTag";
	};
	if(isNil "wmt_param_IndetifyTheBody") then {
		wmt_param_IndetifyTheBody = _logic getVariable "IndetifyTheBody";
		if(isNil "wmt_param_IndetifyTheBody") then {
			wmt_param_IndetifyTheBody = 1;
		};
	};
	if(isNil "wmt_param_HeavyLossesCoeff") then {
		wmt_param_HeavyLossesCoeff = _logic getVariable "HeavyLossesCoeff";
	};
	if(isNil "wmt_param_ShowEnemyVehiclesInNotes") then {
		wmt_param_ShowEnemyVehiclesInNotes = _logic getVariable "ShowEnemyVehiclesInNotes";
	};
	if(isNil "wmt_param_GenerateFrequencies") then {
		wmt_param_GenerateFrequencies = _logic getVariable "GenerateFrequencies";
	};
	if(isNil "wmt_param_AI") then {
		wmt_param_AI = _logic getVariable "AI";
	};
	if(isNil "wmt_param_ShowVehiclesBriefing") then {
		wmt_param_ShowVehiclesBriefing = _logic getVariable "ShowVehiclesBriefing";
	};
	if(isNil "wmt_param_ShowSquadsBriefing") then {
		wmt_param_ShowSquadsBriefing = _logic getVariable "ShowSquadsBriefing";
	};
	if(isNil "wmt_param_Statistic") then {
		wmt_param_Statistic = _logic getVariable "Statistic";
	};
	if(isNil "wmt_param_ExtendedBriefing") then {
		wmt_param_ExtendedBriefing = _logic getVariable "ExtendedBriefing";
		if (isNil "wmt_param_ExtendedBriefing") then {
			wmt_param_ExtendedBriefing = 1;
		};
	};


	
	
	wmt_param_MaxViewDistance  = 10 max wmt_param_MaxViewDistance;
	wmt_param_HeavyLossesCoeff = 0 max wmt_param_HeavyLossesCoeff;

	if(wmt_param_AI==0) then {
		[] call WMT_fnc_DisableAI;
	};

	setViewDistance wmt_param_MaxViewDistance;
	//================================================
	//					SERVER
	//================================================
	if(isServer) then {
		[] spawn {
			if (wmt_param_GenerateFrequencies == 1) then {
				[] spawn WMT_fnc_DefaultFreqsServer;
			};
	
			["vehicle", [(wmt_param_TI==1)]] call WMT_fnc_DisableTI;

			[wmt_param_HeavyLossesCoeff] spawn WMT_fnc_HeavyLossesCheck;

			// briefing
			if (wmt_param_ExtendedBriefing == 1) then {
				[] spawn wmt_fnc_preparebriefinginfo;
			};

		};
	}; 

	//================================================
	//					CLIENT
	//================================================
	if(!isDedicated) then {
		[] spawn {
			waitUntil{!isNil {player}};

			WMT_Local_PlayerName = name player;

			player setVariable ["WMT_PlayerName",WMT_Local_PlayerName,true];
			player setVariable ["WMT_PlayerSide",playerSide,true];

			WMT_Local_Killer = [];
			WMT_Local_Kills = [];

			[] call WMT_fnc_HideSideMarkers;

			// Control veiw distance 
			["loop"] spawn WMT_fnc_handlerOptions;

			// Update information about admin (1 time in 15s)
			["loop"] spawn WMT_fnc_handlerFeedback;

			// Disable TI with using RscTitle 
			if(wmt_param_TI == 2) then {
				IDD_DISABLETI cutRsc ["RscWMTDisableTI","PLAIN"];
			};

			// Show tag with name for near unit
			if(wmt_param_NameTag>0) then {
				IDD_NAMETAG cutRsc ["RscWMTNameTag","PLAIN"];
			};
			//#define IDD_NAMETAG 		59100

			[] spawn WMT_fnc_RatingControl;

			[] spawn {
				waitUntil {!(isNull (findDisplay 46))};
				(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call WMT_fnc_KeyDown"];
				(findDisplay 46) displayAddEventHandler ["KeyUp", "_this call WMT_fnc_KeyUp"];
			};

			player addEventHandler ["killed", "_this spawn WMT_fnc_PlayerKilled"];

			// Public variable handlers 
			"WMT_Global_Announcement" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_Announcement };

			// briefing
			[] call WMT_fnc_BriefingMissionParameters;
			if (wmt_param_ExtendedBriefing == 1) then {
				[] spawn wmt_fnc_showbriefinginfo;
			};

			// Show frequencies
			if (wmt_param_GenerateFrequencies == 1) then {
				[] spawn WMT_fnc_DefaultFreqsClient;
			};

			[] call WMT_fnc_UpdateMainActions;
			player addEventHandler ["Respawn", {[] call WMT_fnc_UpdateMainActions;}];
		};
	};
};

