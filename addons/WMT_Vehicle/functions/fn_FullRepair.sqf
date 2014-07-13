/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		

*/
#include "defines.sqf"
#define DEFAULT_FULLREPAIR_LENGTH 320
#define DEFAULT_REPAIR_TRUCK_USES 1000
#define DISTANCE_TO_REPAIRVEHICLE 15

PR(_veh) = cursorTarget;
PR(_objs) = nearestObjects [player, ["Car","Tank","Air","Ship"], DISTANCE_TO_REPAIRVEHICLE];
PR(_truck) = objNull;
{ if ( alive _x and {_x getVariable ["wmt_repair_cargo", -1] > -0.5} ) then {_truck = _x;}; } foreach _objs;
if (isNull _truck) exitWith { localize("STR_NO_REPAIR_TRUCK") call WMT_fnc_NotifyText;};

PR(_canRepair) = [_veh, WMT_fullRepairClasses] call WMT_fnc_CheckKindOfArray;
if (not _canRepair) exitWith { localize("STR_NO_ENOGH_SKILLS") call WMT_fnc_NotifyText;};

if (WMT_mutexAction) exitWith {
	localize("STR_ANOTHER_ACTION") call WMT_fnc_NotifyText;
};
if (_truck getVariable ["wmt_repair_cargo", 0] <= 0) then {
	localize("STR_REPAIR_TRUCK_DEPLETED") call WMT_fnc_NotifyText;
};

PR(_repairFinished) = false;
WMT_mutexAction = true;	
PR(_maxlength) = _veh getVariable["wmt_longrepairTruck",DEFAULT_FULLREPAIR_LENGTH];
PR(_vehname) = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
PR(_length) = _maxlength;
while { player distance _veh < 7 and alive player and alive _truck and alive _veh and vehicle player == player and speed _veh <= 3 and speed _truck <=3 and not _repairFinished and WMT_mutexAction and _veh distance _truck <= DISTANCE_TO_REPAIRVEHICLE } do {			
	(format[localize("STR_REPAIR_MSG_STRING"), _length, _vehname] ) call WMT_fnc_NotifyText;
	if (_length <= 0) then {_repairFinished = true;};
	_length = _length - 1;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 1;
};

if (_repairFinished) then {
	localize("STR_REPAIR_FINISHED") call WMT_fnc_NotifyText;
	[ [ [_veh], {(_this select 0) setDamage 0;} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;
	_truck setVariable ["wmt_repair_cargo", ( (_truck getVariable ["wmt_repair_cargo", 0] )- (1 / DEFAULT_REPAIR_TRUCK_USES) ), true] ;
	
	_veh setVariable["wmt_longrepairTruck", nil, true];
	_veh setVariable["wmt_fullrepair_times", (_veh getVariable ["wmt_fullrepair_times",0]) + 1 , true ];
} else {
	localize("STR_REPAIR_INTERRUPTED") call WMT_fnc_NotifyText;
	_veh setVariable["wmt_longrepairTruck",_length, true];
};
WMT_mutexAction = false;  
player playActionNow "medicstop";	