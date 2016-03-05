/*
	 Name: WMT_fnc_InitModuleTaskCapturePoints

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
			private ["_winner", "_count", "_msg", "_points", "_condition"];

			_winner = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");
			_count  = _logic getVariable "Count";
			_msg    = _logic getVariable "Message";

			_condition = compile (_logic getVariable ["Condition","true"]);

			sleep _delay;

			_points = WMT_Local_PointArray;

			while { !(({_x getVariable "WMT_PointOwner" == _winner} count _points >= _count) && (call _condition)) } do {
				sleep 2.3;
			};

			if ( {typeOf _x == "WMT_Task_Compose"} count synchronizedObjects _logic == 0) then {
				// End mission
				[[[_winner, _msg], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
			} else {
				_logic setVariable ["WMT_TaskEnd", true, true];
			};
		};
	};
};
