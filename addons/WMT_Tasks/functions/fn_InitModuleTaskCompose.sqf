/*
	 Name: WMT_fnc_InitModuleTaskCompose

	 Author(s):
		Ezhuk
*/

#include "defines.sqf"

private _logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
private _units = [_this,1,[],[[]]] call BIS_fnc_param;
private _activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	//===============================================================
	// 							Server part
	//===============================================================
	if(isServer) then {
		if(isNil "WMT_Local_PointArray") then {
			WMT_Local_PointArray = [];
		};
		[_logic, DELAY] spawn {
			params ["_logic", "_delay"];
			private _winner = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");
			private _count = _logic getVariable "Count";
			private _msg = _logic getVariable "Message";

			private _condition = compile (_logic getVariable ["Condition","true"]);
			private _tasks = [];

			{
				if (typeOf _x in ["WMT_Task_Destroy","WMT_Task_Arrive","WMT_Task_Point","WMT_Task_CapturePoint","WMT_Task_VIP"]) then {
					_tasks pushback _x;
				};
			} foreach (synchronizedObjects _logic);

			sleep _delay;

			private _points = WMT_Local_PointArray;

			while { !(({_x getVariable ["WMT_TaskEnd", false]} count _tasks >= _count) && (call _condition)) } do {
				sleep 2.3;
			};

			// End mission
			[[[_winner, _msg], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
		};
	};
};
