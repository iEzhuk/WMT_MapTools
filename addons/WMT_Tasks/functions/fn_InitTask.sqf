/*
 	Name: WMT_fnc_InitTask
 	
 	Author(s):
		Ezhuk
*/
if(isServer) then {
	WMT_Local_PointArray = [];
};

if (!isDedicated) then {
	// Public variable handlers 
	"WMT_Global_Notice_ObjectArrived" addPublicVariableEventHandler {
		private ["_winner", "_obj", "_name", "_text"];
		
		_winner = (_this select 1) select 0;
		_obj 	= (_this select 1) select 1;

		_name = _obj getVariable ["WMT_DisplayName", getText (configFile >> "CfgVehicles" >> typeOf _obj >> "displayName")];
		_text = _name + " " + localize "STR_WMT_Arrived";

		[_winner, _text] call WMT_fnc_ShowTaskNotification;
	};

	"WMT_Global_Notice_ObjectDestroy" addPublicVariableEventHandler {
		private ["_winner", "_obj", "_name", "_text"];

		_winner = (_this select 1) select 0;
		_obj 	= (_this select 1) select 1;

		_name = _obj getVariable ["WMT_DisplayName", getText (configFile >> "CfgVehicles" >> typeOf _obj >> "displayName")];
		_text = _name + " " + localize "STR_WMT_Destroyed";

		[_winner, _text] call WMT_fnc_ShowTaskNotification;
	};

	"WMT_Global_Notice_ZoneCaptured" addPublicVariableEventHandler {
		private ["_side", "_logic", "_msg"];

		_side  = (_this select 1) select 0;
		_logic = (_this select 1) select 1;

		_msg = _logic getVariable "Message";	

		[_side, _msg] call WMT_fnc_ShowTaskNotification;
	};
	
	"WMT_Global_Notice_VIP" addPublicVariableEventHandler {
		private ["_winner", "_obj", "_text"];

		_winner = (_this select 1) select 0;
		_obj  	= (_this select 1) select 1;

		_text = format ["%1 %2", _obj getVariable ["WMT_DisplayName", "VIP"], localize "STR_WMT_Eliminated"];
		[_winner, _text] call WMT_fnc_ShowTaskNotification;
	};
};