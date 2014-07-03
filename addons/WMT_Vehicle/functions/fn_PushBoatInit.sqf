/*
 	Name: 
 	
 	Author(s):
		Zealot
		
 	Description:
		

*/


if (isDedicated) exitWith {};
waitUntil {sleep 0.39; player == player};

private ["_veh"];
_veh = [_this, 0, objNull] call BIS_fnc_param;

zlt_fnc_pushboat = {
	private ["_veh","_unit"];
	_veh = (nearestObjects [player,["Ship"], 8]) select 0;
	_unit =  player;
	_spd = if (surfaceIsWater getpos _veh) then {3} else {3};
	if (isNil "_veh") exitwith {};
	_withcrew = (count crew _veh != 0);
	if (_withcrew) exitwith {titleText [localize("STR_BOAT_ERR"),"PLAIN",1];};
	
	WMT_mutexAction = true;  
	
	_unit playActionNow "PutDown";
	sleep 1.;
	if (not WMT_mutexAction) exitWith {};
	_dir = direction _unit;
	_veh setOwner (owner _unit); _veh setVelocity [(sin _dir)*_spd, (cos _dir)*_spd, 0]; 
	
	if ( not isNil 'zlt_fnc_pushboat_script' and {not scriptdone zlt_fnc_pushboat_script}) then {
		terminate zlt_fnc_pushboat_script;
	};
	
	zlt_fnc_pushboat_script = _veh spawn {
		_t1 = time;
		waituntil { sleep 0.3; time - 1.6 > _t1};
		_vel = velocity _this;
		_this setvelocity [(_vel select 0) * 0.1, (_vel select 1) * 0.1, (_vel select 2) * 0.1 ];
	};
	
	WMT_mutexAction = false;  
};


WMT_mutexAction = false; 


player addAction ["<t color='#FF9900'>"+localize('STR_PUSH_BOAT')+"</t>",zlt_fnc_pushboat,[],-1,false,false,"",'vehicle player == player and {not isNull cursorTarget} and {cursorTarget isKindOf "Ship"} and {player distance cursorTarget < 8} and {not WMT_mutexAction}'];  

player addEventHandler ["Respawn", {
	player addAction ["<t color='#FF9900'>"+localize('STR_PUSH_BOAT')+"</t>",zlt_fnc_pushboat,[],-1,false,false,"",'vehicle player == player and {not isNull cursorTarget} and {cursorTarget isKindOf "Ship"} and {player distance cursorTarget < 8} and {not WMT_mutexAction}'];  
}];






