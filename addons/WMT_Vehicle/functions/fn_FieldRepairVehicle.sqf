/*
 	Name: WMT_fnc_FieldRepairVehicle
 	
 	Author(s):
		Zealot

 	Description:
		Field repair 

	Parameters:
		0: OBJECT
 		1: vehcile parts

 	Returns:
		Nothing
*/

#include "defines.sqf"
#define DEFAULT_FREE_REPAIRS 1
#define DEFAULT_FIELDREPAIR_EACH_PART_TIME 30
#define DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME 100
		
PR(_fnc_hastk) = {
	private ["_ret"];
	_ret = 0;
	if ("ToolKit" in (items player)) then {_ret = 1;};
	if ("ToolKit" in (itemCargo _veh)) then {_ret = 2;};
	if ( (_veh getVariable ["wmt_fieldrepair_times",0] ) < DEFAULT_FREE_REPAIRS) then {_ret = 3;};
	_ret;
};

PR(_fnc_getPartsRepairTime) = {
	private ["_veh","_vehtype","_flag","_rprTime"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {1};
	_rprTime = 0;
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			diag_log str ["REPAIR ", _x, _cdmg];
			if (_cdmg > 0.64) exitWith {_rprTime = _rprTime + ( if (_x in WMT_hardFieldRepairParts) then {DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME} else {DEFAULT_FIELDREPAIR_EACH_PART_TIME}); };
		};
	}  forEach WMT_fieldRepairHps;
	_rprTime;
};

PR(_fnc_removeitemfromcargo) = {
	private ["_veh"];
	_item = [_this,0,""] call BIS_fnc_param;
	_veh = [_this,1] call BIS_fnc_param;
	_allitems = itemcargo _veh;
	clearItemCargoGlobal _veh;
	_allitems = _allitems call BIS_fnc_consolidateArray;
	_n = [_allitems, _item] call BIS_fnc_findInPairs;
	_allitems set [_n, [(_allitems select _n) select 0, ((_allitems select _n) select 1) - 1]];
    { _veh addItemCargoGlobal [_x select 0, _x select 1 ];} foreach _allitems;
};


PR(_veh) = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
if (isNil {_veh}) exitWith {};
if (WMT_mutexAction) exitWith {
	localize("STR_ANOTHER_ACTION") call WMT_fnc_NotifyText;
};

if (not alive player or (player distance _veh) > 7 or (vehicle player != player) or speed _veh > 3) exitWith {localize("STR_REPAIR_CONDITIONS") call WMT_fnc_NotifyText;};
PR(_hastk) = [] call _fnc_hastk;

if ( _hastk == 0 ) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText;};

WMT_mutexAction = true;  
PR(_repairFinished)  = false;
PR(_lastPlayerState) = animationState player;
PR(_vehname) 		 = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
PR(_length) 		 = _veh getVariable["wmt_fieldrepair",0];

while {(alive player) and ((player distance _veh) < 7) and (vehicle player == player) and (speed _veh < 3) and (not _repairFinished) and WMT_mutexAction} do {
	//Check toolkit 
	_hastk = [] call _fnc_hastk;
	if (_hastk <= 0) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText; sleep 1.;};

	// Calculate repair time 
	PR(_repairTime) = [_veh] call _fnc_getPartsRepairTime;	

	// Show left time 
	(format[localize ("STR_REPAIR_MSG_STRING"), (_repairTime-_length), _vehname]) call WMT_fnc_NotifyText;

	// Finish repair 
	if ((_repairTime-_length) <= 0) exitWith {_repairFinished = true;};

	_length = _length + 1;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 1;
};

if (_repairFinished) then {
	_hastk = [] call _fnc_hastk;

	if (_hastk == 0) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText; sleep 1.;};	

	localize("STR_REPAIR_FINISHED") call WMT_fnc_NotifyText;
	[_veh,"WMT_fnc_partrepair", _veh] call bis_fnc_MP;

	switch (_hastk) do {
		case 1: {player removeItem "ToolKit";};
		case 2: {["ToolKit",_veh] call _fnc_removeitemfromcargo;};
	};

	_veh setVariable["wmt_fieldrepair",nil, true];
	_veh setVariable["wmt_fieldrepair_times", (_veh getVariable ["wmt_fieldrepair_times",0]) + 1 , true ];
} else {
	localize("STR_REPAIR_INTERRUPTED") call WMT_fnc_NotifyText;
	_veh setVariable["wmt_fieldrepair",_length, true];
};

WMT_mutexAction = false;  
player playActionNow "medicstop";