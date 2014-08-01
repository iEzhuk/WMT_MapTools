/*
 	Name: WMT_fnc_Reammo
 	
 	Author(s):
		Ezhuk

 	Description:
		Reammo vehicle for some time 

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
#define REAMMOTIME 180
#define CLEARTIME 300

private ["_repairVeh","_veh","_vehType","_damagedParts","_reammoTime_left","_startTime","_startPos","_totalTime"];
_veh 			 = cursorTarget;
_vehType 		 = typeOf _veh;
_ammoVeh 		 = call wmt_fnc_ReammoGetNearest;
_damagedParts 	 = [];

if( isNull _ammoVeh ) exitWith { 
	(localize "STR_WARNING_NoAmmoVehcile") call WMT_fnc_NotifyText; 
};

if(isNull _veh)exitWith{};
if(!(_veh isKindOf "LandVehicle" || _veh isKindOf  "Air" || _veh isKindOf "Ship"))exitWith{};

WMT_mutexAction = true;
_reammoTime = _veh getVariable ["WMT_ReammoTime",[0,0]];
_reammoTime = if(time - (_reammoTime select 1) < CLEARTIME)then{(_reammoTime select 0)}else{0}; 
_startPos  = getPos player;

[true] call WMT_fnc_ProgressBar;

while {_reammoTime <= REAMMOTIME && WMT_mutexAction} do {
	if( !(alive player) || (speed _veh > 0.5) || (speed _ammoVeh > 0.5) || (_startPos distance player)>0.3) then {
		WMT_mutexAction = false;
	} else {	
		[_reammoTime/REAMMOTIME] call WMT_fnc_ProgressBar;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";

		_reammoTime = _reammoTime + 1;
		sleep 1;
	};
};

if(WMT_mutexAction)then 
{
	// Finished
	[[[_veh], {_this call WMT_fnc_RearmVehicle;} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;
	_veh setVariable ["WMT_ReammoTime",[0,0],true];
	WMT_mutexAction = false;
}else{
	// Interrapted
	_veh setVariable ["WMT_ReammoTime",[_reammoTime,time],true];
};

sleep 0.5;
[false] call WMT_fnc_ProgressBar;