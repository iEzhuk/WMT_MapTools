/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
#define REAMMOTIME 180
#define CLEARTIME 300
/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
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
_reammoTime_left = _veh getVariable["VH_ReammoTime_left",[0,0]];
_reammoTime_left = if(time - (_reammoTime_left select 1) < CLEARTIME)then{(_reammoTime_left select 0)}else{0};
_startTime = time;
_startPos  = getPos player;
_totalTime = REAMMOTIME;

while{ (time-(_startTime-_reammoTime_left))<_totalTime && WMT_mutexAction} do {
	if( !(alive player) || (speed _veh > 0.5) || (speed _ammoVeh > 0.5) || (_startPos distance (getPos player))>0.3) then {
		WMT_mutexAction = false;
	}else{
		 (format [ "%1 %2", (localize "STR_REARM_TIMELEFT"), [_totalTime - (time-(_startTime-_reammoTime_left)), "MM:SS"] call BIS_fnc_secondsToString ] ) call WMT_fnc_NotifyText;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
	};
};

if(WMT_mutexAction)then 
{
	[ [ [_veh], {_this call WMT_fnc_RearmVehicle;} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;

	_veh setVariable ["VH_ReammoTime_left",[0,0],true];
	WMT_mutexAction = false;
	(localize "STR_COMPLETED_REAMMO") call WMT_fnc_NotifyText; 
}else{
	_veh setVariable ["VH_ReammoTime_left",[time-(_startTime-_reammoTime_left),time],true];
};