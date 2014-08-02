/*
 	Name: WMT_fnc_BriefingVehicles
 	
 	Author(s):
		Ezhuk

 	Description:
		Add list of vehicles to briefing 

	Parameters:
 		Nothing
 	Returns:
		Nothing 
*/

#include "defines.sqf"

PARAM(_showEnemyVehs, 0, 0);

PR(_text) = "";
PR(_vehsName) = [];
PR(_vehsCount) = [];

//Enemy vehicles
PR(_enemyText) = "";
PR(_enemyVehsName) = [];
PR(_enemyVehsCount) = [];


{
	if(!(_x isKindOf "Strategic") && !(_x isKindOf "Thing"))then
	{
		PR(_nearestUnit) = nearestObject [_x, "Man"];
		PR(_show) = false;
		PR(_showAsEnemy) = false;
		if(_x getVariable ["WMT_side",sideLogic] == side player) then
		{
			_show = true;
		}else{
			_nearestUnit = nearestObject [_x, "Man"];
			if(!(isNil "_nearestUnit") ) then
			{
				if(side player in ([side _nearestUnit] call BIS_fnc_friendlySides)) then
				{
					_show = true;
				} else {
					_showAsEnemy = true;
				};
			};
		};

		if(_show) then
		{
			PR(_veh) = getText (configFile >> "CfgVehicles" >> typeOf _x >> "Displayname");
			PR(_i) = _vehsName find _veh;

			if(_i >= 0)then{
				_vehsCount set [_i,(_vehsCount select _i) + 1 ];
			}else{
				_vehsName  set [count _vehsName , _veh];
				_vehsCount set [count _vehsCount,   1 ];
			};
		};
		if(_showAsEnemy) then
		{
			PR(_veh) = getText (configFile >> "CfgVehicles" >> typeOf _x >> "Displayname");
			PR(_i) = _enemyVehsName find _veh;

			if(_i >= 0)then{
				_enemyVehsCount set [_i,(_enemyVehsCount select _i) + 1 ];
			}else{
				_enemyVehsName  set [count _enemyVehsName , _veh];
				_enemyVehsCount set [count _enemyVehsCount,   1 ];
			};
		};		
	};
}forEach vehicles;

if (_showEnemyVehs == 1) then {
	for "_i" from 0 to ((count _enemyVehsName)-1) do
	{
		_enemyText = _enemyText + format ["<font color='#c7861b'>%1</font> - %2",_enemyVehsCount select _i,_enemyVehsName select _i];
		_enemyText = _enemyText + "<br/>";
	};

	["diary",localize "STR_WMT_EnemyVehicles", _enemyText] call WMT_fnc_CreateDiaryRecord;
};


for "_i" from 0 to ((count _vehsName)-1) do
{
	_text = _text + format ["<font color='#c7861b'>%1</font> - %2",_vehsCount select _i,_vehsName select _i];
	_text = _text + "<br/>";
};

["diary",localize "STR_WMT_Vehicles", _text] call WMT_fnc_CreateDiaryRecord;


