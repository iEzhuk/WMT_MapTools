/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Add list of squads and players to briefing 

*/


#define DEFAULT_FIELDREPAIR_EACH_PART_TIME 30
#define DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME 100
#define DEFAULT_FULLREPAIR_LENGTH 320
#define DEFAULT_REPAIR_TRUCK_USES 1000
#define DEFAULT_FREE_REPAIRS 1
#define DISTANCE_TO_REPAIRVEHICLE 15


zlt_repair_loop = [_this, 0, false] call BIS_fnc_param;


wog_mt_repairEnabled = true;
wog_mt_fullRepairClasses = [];
wog_mt_fullRepairEnabled = false;

if (isServer) then {
	[] spawn {
		_first = true;
		while {_first or zlt_repair_loop} do {
			{ 
				if (getRepairCargo _x > 0) then {
					_x setRepairCargo 0;
					_x setVariable ["zlt_repair_cargo", 1, true]; 
				};
			} foreach vehicles;
			_first = false;
			sleep 26.1;
		};
	};
};

wog_mt_hardFieldRepairParts = ["HitEngine", "HitLTrack","HitRTrack"];
wog_mt_fieldRepairHps = ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel"] + wog_mt_hardFieldRepairParts;

//wog_mt_fieldRepairHps = ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel" ,"HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitVRotor","HitHRotor"];
//wog_mt_hardFieldRepairParts = ["HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitHRotor"];

zlt_fnc_partrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	if (isNil {_veh} ) exitWith {}; 
	{
		_dmg = (_veh getHitPointDamage _x);
		if (not isNil {_dmg}) then {
			if ( _dmg > 0.64 ) then {
				if (_x in wog_mt_hardFieldRepairParts) then {
					_veh setHitPointDamage [_x,0.64];
				} else {
					_veh setHitPointDamage [_x,0];
				};
			};
		};
	} foreach wog_mt_fieldRepairHps; 
};

zlt_fnc_fullrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	_veh setDamage 0;
};

if (isDedicated) exitWith {};
waitUntil {player == player};
wog_mt_mutexAction = false;

zlt_frpr_getPartsRepairTime = {
	private ["_veh","_vehtype","_flag"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {1};
	_rprTime = 0;
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			diag_log str ["REPAIR ", _x, _cdmg];
			if (_cdmg > 0.64) exitWith {_rprTime = _rprTime + ( if (_x in wog_mt_hardFieldRepairParts) then {DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME} else {DEFAULT_FIELDREPAIR_EACH_PART_TIME}); };
		};
	}  forEach wog_mt_fieldRepairHps;
	_rprTime;
};

zlt_fnc_hastk = {
	private ["_ret"];
	_ret = 0;
	if ("ToolKit" in (items player)) then {_ret = 1;};
	if ("ToolKit" in (itemCargo _veh)) then {_ret = 2;};
	if ( (_veh getVariable ["zlt_longrepair_times",0] ) < DEFAULT_FREE_REPAIRS) then {_ret = 3;};
	_ret;
};


zlt_fnc_removeitemfromcargo = {
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

zlt_prc_repairvehicle = {
	private ["_veh"];
	_veh = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
	if (isNil {_veh}) exitWith {};
	if (wog_mt_mutexAction) exitWith {
		localize("STR_ANOTHER_ACTION") call WMT_fnc_NotifyText;
	};
	if (not alive player or (player distance _veh) > 7 or (vehicle player != player) or speed _veh > 3) exitWith {localize("STR_REPAIR_CONDITIONS") call WMT_fnc_NotifyText;};
	_hastk = [] call zlt_fnc_hastk;
	if ( _hastk == 0 ) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText;};
	_repairFinished = false;
	wog_mt_mutexAction = true;  
	_lastPlayerState = animationState player;
//	player playActionNow "medicStartRightSide";
//	sleep 0.5;
	_maxlength = _veh getVariable["zlt_longrepair",[_veh] call zlt_frpr_getPartsRepairTime];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	while {alive player and (player distance _veh) < 7 and (vehicle player == player) and speed _veh < 3 and not _repairFinished and wog_mt_mutexAction} do {		
	//	diag_log ("ANIM STATE = "+str(animationState player));	
		(format[localize ("STR_REPAIR_MSG_STRING"), _length, _vehname] ) call WMT_fnc_NotifyText;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
		_hastk = [] call zlt_fnc_hastk;
		if (_hastk <= 0) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText; sleep 1.;};	
	};
	if (_repairFinished) then {
		_hastk = [] call zlt_fnc_hastk;
		if (_hastk == 0) exitWith {localize("STR_NEED_TOOLKIT") call WMT_fnc_NotifyText; sleep 1.;};	
		localize("STR_REPAIR_FINISHED") call WMT_fnc_NotifyText;
		[_veh,"zlt_fnc_partrepair", _veh] call bis_fnc_MP;
		if (_hastk == 1) then {player removeItem "ToolKit";};
		if (_hastk == 2) then { ["ToolKit",_veh] call zlt_fnc_removeitemfromcargo;};
		_veh setVariable["zlt_longrepair",nil, true];
		_veh setVariable["zlt_longrepair_times", (_veh getVariable ["zlt_longrepair_times",0]) + 1 , true ];
	} else {
		localize("STR_REPAIR_INTERRUPTED") call WMT_fnc_NotifyText;
		_veh setVariable["zlt_longrepair",_length, true];
	};
	wog_mt_mutexAction = false;  
	player playActionNow "medicstop";
};

zlt_fnc_heavyRepair = {
	_veh = cursorTarget;

	_objs = nearestObjects [player, ["Car","Tank","Air","Ship"], DISTANCE_TO_REPAIRVEHICLE];
	_truck = objNull;
	{ if ( alive _x and {_x getVariable ["zlt_repair_cargo", -1] > -0.5} ) then {_truck = _x;}; } foreach _objs;
	if (isNull _truck) exitWith { localize("STR_NO_REPAIR_TRUCK") call WMT_fnc_NotifyText;};

	_canRepair = [_veh, wog_mt_fullRepairClasses] call WMT_fnc_CheckKindOfArray;
	if (not _canRepair) exitWith { localize("STR_NO_ENOGH_SKILLS") call WMT_fnc_NotifyText;};
	 
	
	if (wog_mt_mutexAction) exitWith {
		localize("STR_ANOTHER_ACTION") call WMT_fnc_NotifyText;
	};
	if (_truck getVariable ["zlt_repair_cargo", 0] <= 0) then {
		localize("STR_REPAIR_TRUCK_DEPLETED") call WMT_fnc_NotifyText;
	};
	
	
	
	_repairFinished = false;
	wog_mt_mutexAction = true;	
	_maxlength = _veh getVariable["zlt_longrepairTruck",DEFAULT_FULLREPAIR_LENGTH];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	while { player distance _veh < 7 and alive player and alive _truck and alive _veh and vehicle player == player and speed _veh <= 3 and speed _truck <=3 and not _repairFinished and wog_mt_mutexAction and _veh distance _truck <= DISTANCE_TO_REPAIRVEHICLE } do {			
		(format[localize("STR_REPAIR_MSG_STRING"), _length, _vehname] ) call WMT_fnc_NotifyText;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
	};
	
	if (_repairFinished) then {
		localize("STR_REPAIR_FINISHED") call WMT_fnc_NotifyText;
		[_veh,"zlt_fnc_fullrepair", _veh] call bis_fnc_MP;
		_truck setVariable ["zlt_repair_cargo", ( (_truck getVariable ["zlt_repair_cargo", 0] )- (1 / DEFAULT_REPAIR_TRUCK_USES) ), true] ;
		
		_veh setVariable["zlt_longrepairTruck", nil, true];
		_veh setVariable["zlt_fullrepair_times", (_veh getVariable ["zlt_fullrepair_times",0]) + 1 , true ];
	} else {
		localize("STR_REPAIR_INTERRUPTED") call WMT_fnc_NotifyText;
		_veh setVariable["zlt_longrepairTruck",_length, true];
	};
	wog_mt_mutexAction = false;  
	player playActionNow "medicstop";	
};


_playerClass= toUpper (typeof player);

wog_mt_fullRepairClasses = [];
wog_mt_fullRepairEnabled = false;

switch ( true ) do {
	case (_playerClass in ["B_CREW_F","I_CREW_F","O_CREW_F"]) : {wog_mt_fullRepairClasses = ["Car","Tank","Ship"];wog_mt_fullRepairEnabled = true; };
	case (_playerClass in ["O_ENGINEER_F","B_ENGINEER_F","I_ENGINEER_F","B_SOLDIER_REPAIR_F","I_SOLDIER_REPAIR_F","O_SOLDIER_REPAIR_F","B_G_ENGINEER_F"]) : {wog_mt_fullRepairClasses = ["Car","Tank","Ship","Air"];wog_mt_fullRepairEnabled = true; };
	case (_playerClass in ["O_PILOT_F","B_PILOT_F","I_PILOT_F","O_HELICREW_F","I_HELICREW_F","B_HELICREW_F","O_HELIPILOT_F","B_HELIPILOT_F","I_HELIPILOT_F"]) : {wog_mt_fullRepairClasses = ["Car","Tank","Ship","Air"];wog_mt_fullRepairEnabled = true; };
	case (_playerClass in ["O_SOLDIER_UAV_F","I_SOLDIER_UAV_F","B_SOLDIER_UAV_F"]) : {wog_mt_fullRepairClasses = ["UGV_01_base_F","UAV_01_base_F","UAV_02_base_F"];wog_mt_fullRepairEnabled = true; };



};


if (isNil "zlt_cancelActionId") then {
zlt_cancelActionId = player addAction["<t color='#0000ff'>"+localize("STR_CANCEL_ACTION")+"</t>", {wog_mt_mutexAction = false}, [], 10, false, true, '',' wog_mt_mutexAction  '];
	
	player addAction["<t color='#ff0000'>"+localize ("STR_FIELD_REPAIR")+"</t>", zlt_prc_repairvehicle, [], -1, false, true, '','(not isNull cursorTarget) and {alive player} and {(player distance cursortarget) <= 7} and {(vehicle player == player)} and {speed cursortarget < 3} and {not wog_mt_mutexAction} and {alive cursortarget} and {cursortarget call WMT_fnc_vehicleIsDamaged}'];
	if (wog_mt_fullRepairEnabled) then {
		player addAction["<t color='#ff0000'>"+localize ("STR_SERIOUS_REPAIR")+ "</t>", zlt_fnc_heavyRepair, [], -1, false, true, '','(not isNull cursorTarget) and {vehicle player == player} and {player distance cursortarget <= 7 and damage cursortarget != 0} and {alive player and alive cursortarget} and {speed cursortarget < 3} and {not wog_mt_mutexAction}'];
	};
	/* TODO
	player createDiarySubject [STR_SCRIPTS_NAME,STR_SCRIPTS_NAME];
	player createDiaryRecord [STR_SCRIPTS_NAME,[STR_SCRIPT_NAME, STR_HELP]];
	*/

};

player addEventHandler ["Respawn", {
	zlt_cancelActionId = player addAction["<t color='#0000ff'>"+localize("STR_CANCEL_ACTION")+"</t>", {wog_mt_mutexAction = false}, [], 10, false, true, '',' wog_mt_mutexAction  '];
	
	player addAction["<t color='#ff0000'>"+localize ("STR_FIELD_REPAIR")+"</t>", zlt_prc_repairvehicle, [], -1, false, true, '','(not isNull cursorTarget) and {alive player} and {(player distance cursortarget) <= 7} and {(vehicle player == player)} and {speed cursortarget < 3} and {not wog_mt_mutexAction} and {alive cursortarget} and {cursortarget call WMT_fnc_vehicleIsDamaged}'];
	if (wog_mt_fullRepairEnabled) then {
		player addAction["<t color='#ff0000'>"+localize ("STR_SERIOUS_REPAIR")+ "</t>", zlt_fnc_heavyRepair, [], -1, false, true, '','(not isNull cursorTarget) and {vehicle player == player} and {player distance cursortarget <= 7 and damage cursortarget != 0} and {alive player and alive cursortarget} and {speed cursortarget < 3} and {not wog_mt_mutexAction}'];
	};
}];

