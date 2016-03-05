/*
	 Name: WMT_fnc_InitModuleTaskDestroy

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
		[_logic, _units, DELAY] spawn {
			params ["_logic", "_units", "_delay"];
			private ["_notice", "_message", "_endCount", "_winner", "_condition", "_objs", "", "", "", "", ""];

			_notice   = _logic getVariable "Notice";
			_message  = _logic getVariable "Message";
			_endCount = _logic getVariable "EndCount";
			_winner   = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");

			_condition = compile (_logic getVariable ["Condition","true"]);

			sleep _delay;

			_objs = _units;

			while { !((count _objs <= _endCount) && (call _condition)) } do {
				_tempObjs = _objs;
				{
					if !(alive _x) then {
						// Object has been destroyed
						if(_notice==1) then {
							WMT_Global_Notice_ObjectDestroy = [_winner, _x];
							publicVariable "WMT_Global_Notice_ObjectDestroy";

							private _name = _x getVariable ["WMT_DisplayName", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
							private _text = _name + " " + localize "STR_WMT_Destroyed";

							[_winner, _text] call WMT_fnc_ShowTaskNotification;
						};

						_objs = _objs - [_x];
					};
				} foreach _tempObjs;

				sleep 7.12;
			};

			if ( {typeOf _x == "WMT_Task_Compose"} count synchronizedObjects _logic == 0) then {
				// End mission
				[[[_winner, _message], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
			} else {
				_logic setVariable ["WMT_TaskEnd", true, true];
			};
		};
	};
	//===============================================================
	// 							Client part
	//===============================================================
	if(!isDedicated) then {
		if(isNil "WMT_ClientInit_Destroy") then {
			WMT_ClientInit_Destroy = true;
			"WMT_Global_Notice_ObjectDestroy" addPublicVariableEventHandler {
				if(count (_this select 1) == 2) then {
					private ["_winner", "_obj", "_name", "_text"];

					_winner = (_this select 1) select 0;
					_obj 	= (_this select 1) select 1;

					_name = _obj getVariable ["WMT_DisplayName", getText (configFile >> "CfgVehicles" >> typeOf _obj >> "displayName")];
					_text = _name + " " + localize "STR_WMT_Destroyed";

					[_winner, _text] call WMT_fnc_ShowTaskNotification;
				};
			};
		};
	};
};
