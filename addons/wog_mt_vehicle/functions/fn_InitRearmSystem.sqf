/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
//=========================================================================================================
//								Rearm system						
//=========================================================================================================

#define DISTANCE_TO_REAMMOVEHICLE 15
#define REAMMOTIME 180
#define CLEARTIME 300

if(isDedicated) exitWith {};
if(true && (!(["engineer" ,str(typeOf player)] call BIS_fnc_inString) && !(["crew" ,str(typeOf player)] call BIS_fnc_inString) && !(["pilot",str(typeOf player)] call BIS_fnc_inString))) exitWith {};
// Player is crewman or pilot

if (isNil "wmt_ammoCargoVehs") then {
	wmt_ammoCargoVehs = [];
};

waitUntil {time > 0};
{
	if (getAmmoCargo _x > 0) then {
		wmt_ammoCargoVehs set [count wmt_ammoCargoVehs, _x];
		_x setAmmoCargo 0;
	};
} foreach vehicles;

wmt_fnc_GetNearestAmmoSource = {
	private ["_res"];
	_res = objNull;
	{
		if( player distance _x < DISTANCE_TO_REAMMOVEHICLE) exitWith {_res = _x;};
	} foreach (wmt_ammoCargoVehs);
	_res
};

Func_Reammo_cond = {
	private ["_res","_obj","_repairVeh"];
	_obj = cursorTarget;
	_res = false;
	if(!wog_mt_mutexAction) then
	{
		if(!(isNull _obj)) then 
		{
			if(alive _obj && player == vehicle player) then 
			{
				if( ( locked _obj == 0 || locked _obj == 1) && _obj distance player < 8) then 
				{
					if( _obj isKindOf "LandVehicle" || _obj isKindOf "Ship" || _obj isKindOf  "Air" ) then 
					{
						if(not isNull (call wmt_fnc_GetNearestAmmoSource)) then {
							_res = true;
						};
					};
				};
			};
		};
	};
	_res
};

Func_Reammo = {
	private ["_repairVeh","_veh","_vehType","_damagedParts","_reammoTime_left","_startTime","_startPos","_totalTime"];
	_veh 			 = cursorTarget;
	_vehType 		 = typeOf _veh;
	_ammoVeh 		 = call wmt_fnc_GetNearestAmmoSource;
	_damagedParts 	 = [];

	if( isNull _ammoVeh ) exitWith { 
		(localize "STR_WARNING_NoAmmoVehcile") call WMT_fnc_NotifyText; 
	};
	
	if(isNull _veh)exitWith{};
	if(!(_veh isKindOf "LandVehicle" || _veh isKindOf  "Air" || _veh isKindOf "Ship"))exitWith{};

	wog_mt_mutexAction = true;
	_reammoTime_left = _veh getVariable["VH_ReammoTime_left",[0,0]];
	_reammoTime_left = if(time - (_reammoTime_left select 1) < CLEARTIME)then{(_reammoTime_left select 0)}else{0};
	_startTime = time;
	_startPos  = getPos player;
	_totalTime = REAMMOTIME;

	while{ (time-(_startTime-_reammoTime_left))<_totalTime && wog_mt_mutexAction} do {
		if( !(alive player) || (speed _veh > 0.5) || (speed _ammoVeh > 0.5) || (_startPos distance (getPos player))>0.3) then {
			wog_mt_mutexAction = false;
		}else{
			 (format [ "%1 %2", (localize "STR_REARM_TIMELEFT"), [_totalTime - (time-(_startTime-_reammoTime_left)), "MM:SS"] call BIS_fnc_secondsToString ] ) call WMT_fnc_NotifyText;
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 1;
		};
	};

	if(wog_mt_mutexAction)then 
	{
		//finished rearm
		//[BIS_fnc_MP, [[_veh], "Func_Common_Rearm"],_veh] call Func_Common_Spawn;
		//[ [ [_x,false], {(_this select 0) allowDamage (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
		[ [ [_veh], {_this call WMT_fnc_RearmVehicle;} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;

		_veh setVariable ["VH_ReammoTime_left",[0,0],true];
		wog_mt_mutexAction = false;
		(localize "STR_COMPLETED_REAMMO") call WMT_fnc_NotifyText; 
	}else{
		//repair was cancel
		_veh setVariable ["VH_ReammoTime_left",[time-(_startTime-_reammoTime_left),time],true];
	};
};

player addAction[ format ["<t color='#ff0000'>%1</t>", (localize "STR_ACTION_REAMMO") ] , Func_Reammo, [], 1, false, false, '','[] call Func_Reammo_cond'];


