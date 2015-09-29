/*
 	Name: WMT_fnc_InitModuleMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#include "defines_WMT.sqf"
#include "defines_IDC.sqf"
#include "..\defines_KEY.sqf"
#include "..\..\features.inc"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	if ( not isnil "wmt_Main_ModuleRunning" ) exitWith {
		diag_log "WMT_fnc_InitModuleMain: double initialization";
	};
	wmt_Main_ModuleRunning = true;

	if(isNil "wmt_param_TI") then {
		wmt_param_TI = _logic getVariable "TI";
	};
	if(isNil "wmt_param_MaxViewDistance") then {
		wmt_param_MaxViewDistance = _logic getVariable "MaxViewDistance";
	};
	if(isNil "wmt_param_MaxViewDistanceTerrain") then {
		wmt_param_MaxViewDistanceTerrain = _logic getVariable ["MaxViewDistanceTerrain", 10000];
	};
	if(isNil "wmt_param_NameTag") then {
		wmt_param_NameTag = _logic getVariable "NameTag";
	};
	if(isNil "wmt_param_IndetifyTheBody") then {
		wmt_param_IndetifyTheBody = _logic getVariable ["IndetifyTheBody",1];
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
		wmt_param_ExtendedBriefing = _logic getVariable ["ExtendedBriefing",1];
	};


	
	
	wmt_param_MaxViewDistance  = 10 max wmt_param_MaxViewDistance;
	wmt_param_HeavyLossesCoeff = 0 max wmt_param_HeavyLossesCoeff;

	if(wmt_param_AI==0) then {
		[] call WMT_fnc_DisableAI;
	};


	
	["itemAdd", ["WmtMainCallEndFreeze", { ["CALL","FreezeEnded",[time, serverTime, diag_tickTime, date]] call wmt_fnc_evh; }, nil, nil, { time > 0 && { ( missionNamespace getVariable ["WMT_pub_frzState",100] ) >= 3} }, {false}, true]] call BIS_fnc_loop;


	//================================================
	//					SERVER
	//================================================
	if(isServer) then {
		[] spawn {
			setViewDistance wmt_param_MaxViewDistance;
			if (wmt_param_GenerateFrequencies == 1) then {
				[] spawn WMT_fnc_DefaultFreqsServer;
			};

			["vehicle", [(wmt_param_TI>0)]] call WMT_fnc_DisableTI;

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
			waitUntil{!isNull player};

			"WMT_fnc_InitModuleMain started" call Bis_fnc_log;

			WMT_Local_PlayerName = name player;

			if (player getVariable ["PlayerName", ""] != WMT_Local_PlayerName) then {
				player setVariable ["PlayerName",WMT_Local_PlayerName,true];
			};

			if (isNil {player getVariable "PlayerSide"}) then {
				player setVariable ["PlayerSide",playerSide,true];
			};

			WMT_Local_Killer = [];
			WMT_Local_Kills = [];

			[] call WMT_fnc_HideSideMarkers;
			[] call WMT_fnc_HideUserMarkers;
 
			["preinit"] spawn WMT_fnc_handlerOptions;
			
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
			
			// Save positive rating 
			player addEventHandler ["HandleRating","if((rating player)<-(_this select 1))then{-(rating player)}else{_this}"];

			// Key binding with cba 
			#include "keyBinding.sqf"


			#ifdef FEATURE_BRIEF_TIMER
			0 call WMT_fnc_briefTimer; 
			#endif
			
			// Disable chat
			
			 
			0 spawn {
				waitUntil {sleep 1.2;(missionNamespace getVariable ["WMT_pub_frzState",3]) >= 3 };
				if (isnil "wmt_flg_dontDisableChat") then {sleep 15; showChat false; sleep 120; showChat false;};
			};

			player addEventHandler ["killed", "_this spawn WMT_fnc_PlayerKilled"];

			// Public variable handlers 
			"WMT_Global_Announcement" addPublicVariableEventHandler { (_this select 1) call WMT_fnc_Announcement };
			
			"WMT_Global_ToAdmin" addPublicVariableEventHandler { 
				if(serverCommandAvailable("#kick")) then {
					(_this select 1) call WMT_fnc_Announcement; 
					diag_log (_this select 1); 
				};
			};

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

