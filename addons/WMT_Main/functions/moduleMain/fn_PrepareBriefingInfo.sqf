
  /*
 	Name:  
 	
 	Author(s):
		Zealot

 	Description:
		 

	Parameters:
 		Nothing
 	Returns:
		Nothing 
*/
#define PR(x) private ['x']; x

if (not isServer) exitWith {};
wmt_global_srvBrfData = [];


PR(_tempData) = [];
PR(_vehinfo) = [];
PR(_grpinfo) = [];
PR(_side) = civilian;
PR(_units) = [];
PR(_group) = [];
PR(_playersGr) = 0;
PR(_vehicles)= (call WMT_fnc_GetVehicles);

// данные техники ["V", [координаты], "класс", сторона]
{
 	if(!(_x isKindOf "Strategic") && !(_x isKindOf "Thing") && (_x getVariable ["wmt_show", true]) )then {
 		_vehinfo = ["V"];
 		_vehinfo pushback getPos _x;
 		_vehinfo pushback typeOf _x;
 		_side = _x getVariable ["WMT_Side", [getNumber (configfile >> "CfgVehicles" >> typeof _x >> "side")] call BIS_fnc_sideType];
 		_vehinfo pushback _side;

 		_tempData pushback _vehinfo;
 	};
} foreach _vehicles;

// данные отряда ["S", [координаты], "GroupID", сторона, число игроков, "имя лидера",[юниты] ]

{
	if ((leader _x) in playableUnits and (_x getVariable ["wmt_show", true]) ) then {
		_grpinfo = ["S"];

		_grpinfo pushback getPos leader _x;
		_grpinfo pushback groupID _x;
		_grpinfo pushback side leader _x;
	
		_units = [];
		{
			_units pushback [typeOf _x, if(isPlayer _x) then {name _x} else {""}];

		} foreach units _x;

		_playersGr = 0;
		{
			if (isPlayer _x) then {_playersGr=_playersGr+1;};
		} foreach units _x;


		_x setVariable ["WMT_BriefingUnitsInfo", _units, true];

		_grpinfo pushback _playersGr;
		_grpinfo pushback (if (isPlayer leader _x) then {name leader _x} else {""});
		_grpinfo pushback _units;

		_tempData pushback _grpinfo;
	};
} foreach allGroups;

wmt_global_srvBrfData = _tempData;
publicVariable "wmt_global_srvBrfData";
