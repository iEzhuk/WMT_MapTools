/*
 	Name: WMT_fnc_InitModuleTaskDestroy
 	
 	Author(s):
		Ezhuk
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	//===============================================================
	// 							Server part
	//===============================================================
	if(isServer) then {
		[_logic, _units] spawn {
			PR(_logic) = _this select 0;
			PR(_units) = _this select 1;

			PR(_notice) 	= _logic getVariable "Notice";
			PR(_message)	= _logic getVariable "Message";
			PR(_endCount) 	= _logic getVariable "EndCount";
			PR(_winner)		= [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");
			PR(_delay) 		= 0.0001 max (_logic getVariable "Delay");

			sleep _delay;

			PR(_objs) = _units;
			while {count _objs > _endCount} do {
				PR(_o) = _objs;
				{
					if !(alive _x) then {
						// Object has been destroyed 

						if(_notice==1) then {
							WMT_Global_Notice_ObjectDestroy = [_winner, _x];
							publicVariable "WMT_Global_Notice_ObjectDestroy";

							PR(_name) = _x getVariable ["WMT_DisplayName", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
							PR(_text) = _name + " " + localize "STR_WMT_Destroyed";

							[_winner, _text] call WMT_fnc_ShowTaskNotification;
						};

						_objs = _objs - [_x];
					};
				} foreach _o;

				sleep 3.12;
			};

			// End mission
			[[[_winner, _message], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
		};
	};
};