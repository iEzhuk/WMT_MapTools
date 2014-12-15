/*
 	Name: WMT_fnc_FullRepair
 	
 	Author(s):
		Zealot

 	Description:
		Full repair vehcile by repair truck

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
#include "defines.sqf"
#define DEFAULT_FULLREPAIR_LENGTH 320
#define DEFAULT_REPAIR_TRUCK_USES 1000
#define DISTANCE_TO_REPAIRVEHICLE 15

PR(_veh) 	= cursorTarget;
PR(_objs) 	= nearestObjects [player, ["Car","Tank","Air","Ship"], DISTANCE_TO_REPAIRVEHICLE];
PR(_truck) 	= objNull;

{ if ( alive _x and {_x getVariable ["wmt_repair_cargo", -1] > -0.5} ) then {_truck = _x;}; } foreach _objs;

if (isNull _truck) exitWith {localize("STR_NO_REPAIR_TRUCK") call WMT_fnc_NotifyText;};

/* ХЗ что такое
PR(_canRepair) = [_veh, WMT_Local_fullRepairClasses] call WMT_fnc_CheckKindOfArray;
if (not _canRepair) exitWith {localize("STR_NO_ENOGH_SKILLS") call WMT_fnc_NotifyText;};
*/

if (WMT_mutexAction) exitWith {
	localize("STR_ANOTHER_ACTION") call WMT_fnc_NotifyText;
};
if (_truck getVariable ["wmt_repair_cargo", 0] <= 0) then {
	localize("STR_REPAIR_TRUCK_DEPLETED") call WMT_fnc_NotifyText;
};

WMT_mutexAction 	= true;	
PR(_repairFinished) = false;
PR(_maxlength) 		= _veh getVariable["wmt_longrepairTruck",[DEFAULT_FULLREPAIR_LENGTH, serverTime]];
if (serverTime - (_maxlength select 1) > 300 ) then { _maxlength = DEFAULT_FULLREPAIR_LENGTH;} else {_maxlength = _maxlength select 0;};

PR(_vehname) 		= getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
PR(_length)			= _maxlength;
PR(_startPos)		= getPos player;

[true] call WMT_fnc_ProgressBar;

while { player distance _veh < 7 and (player distance _startPos) < 0.4 and alive player and alive _truck and alive _veh and vehicle player == player and speed _veh <= 3 and speed _truck <=3 and not _repairFinished and WMT_mutexAction and _veh distance _truck <= DISTANCE_TO_REPAIRVEHICLE } do {	

	// Show progress bar
	[1-(_length/_maxlength)] call WMT_fnc_ProgressBar;

	if (_length <= 0) then {_repairFinished = true;};
	_length = _length - 1;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 1;
};

if (_repairFinished) then {
	[ [ [_veh], {(_this select 0) setDamage 0;} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;
	_truck setVariable ["wmt_repair_cargo", ( (_truck getVariable ["wmt_repair_cargo", 0] )- (1 / DEFAULT_REPAIR_TRUCK_USES) ), true] ;
	
	_veh setVariable["wmt_longrepairTruck", nil, true];
	_veh setVariable["wmt_fullrepair_times", (_veh getVariable ["wmt_fullrepair_times",0]) + 1 , true ];
} else {
	_veh setVariable["wmt_longrepairTruck",[_length,serverTime], true];
	
};

WMT_mutexAction = false;  
player playActionNow "medicstop";	

sleep 0.5;
[false] call WMT_fnc_ProgressBar;