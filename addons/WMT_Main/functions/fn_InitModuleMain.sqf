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
	
	wmt_param_MaxViewDistance  = 10 max wmt_param_MaxViewDistance;
	wmt_param_HeavyLossesCoeff = 0.01 max wmt_param_HeavyLossesCoeff;

	if(wmt_param_AI==0) then {
		[] call WMT_fnc_DisableAI;
	};

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
		};
	}; 

	//================================================
	//					CLIENT
	//================================================
	if(!isDedicated) then {
		[] spawn {
			waitUntil{!isNil {player}};

			[] call WMT_fnc_HideSideMarkers;

			WMT_Local_Killer = [];
			WMT_Local_Kills = [];
			
			if(isNil "WMT_Local_PlayerName") then {
				WMT_Local_PlayerName = name player;
				player setVariable ["WMT_PlayerName",WMT_Local_PlayerName,true];
			};

			if(isNil "WMT_Local_PlayerSide") then {
				WMT_Local_PlayerSide = side player;
				player setVariable ["WMT_PlayerSide",WMT_Local_PlayerSide,true];
			};

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
			"WMT_Global_AddKills" addPublicVariableEventHandler { WMT_Local_Kills=WMT_Local_Kills+(_this select 1) };

			// briefing
			[] call WMT_fnc_BriefingMissionParameters;
			if(wmt_param_ShowVehiclesBriefing == 1) then {
				[wmt_param_ShowEnemyVehiclesInNotes] call WMT_fnc_BriefingVehicles;
			};
			if(wmt_param_ShowSquadsBriefing == 1) then {
				[] call WMT_fnc_BriefingSquads;
			};

			// Draw markers on start position vehicles and groups
			if ( wmt_param_ShowVehiclesBriefing != 0 or wmt_param_ShowSquadsBriefing != 0 ) then {
				[] spawn {
					PR(_markerPool) = [] call WMT_fnc_SpotMarkers;
					sleep 0.1;
					if (!isNil "WMT_pub_frzState") then {
						waitUntil{sleep 1.05; WMT_pub_frzState>=3};
					};
					sleep 30;
					{deleteMarkerLocal _x;} foreach _markerPool;
				};
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

