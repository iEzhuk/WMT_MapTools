 /*
 	Name: WMT_fnc_StaticWpnDrag
 	
 	Author(s):
		Zealot

 	Description:
		Moving static objects

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
private ["_wpn", "_reltxt", "_rel"];

_wpn = cursorTarget;

if (isnil "_wpn") exitWith {};

player playMove "acinpknlmstpsraswrfldnon";

WMT_drag = true;
_wpn attachto [player,[0,1,1.5]];
_wpn setVariable ["WMT_drag", true, true];


[[[_wpn,true], {(_this select 0) lock (_this select 1);}], "bis_fnc_spawn",_wpn] call bis_fnc_mp;

sleep 0.1;

_reltxt = format [localize("STR_RELEASE_STATIC"), getText (configFile >> "CfgVehicles" >> typeof _wpn >> "Displayname")];
_rel 	= player addaction [("<t color=""#0353f5"">") + _reltxt + "</t>",{WMT_drag = false},[],15,true,true,"","true"];

waitUntil {not alive player or ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))};

while {count crew _wpn == 0 and WMT_drag and vehicle player == player and alive player and ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))} do {
	sleep 0.16;
};

player playMoveNow "AmovPknlMstpSrasWrflDnon";
player removeAction _rel;

WMT_drag = false;	
_wpn setVariable ["WMT_drag", false, true];

[[[_wpn,false], {(_this select 0) lock (_this select 1);}],"bis_fnc_spawn",_wpn] call bis_fnc_mp;

if not (isNull _wpn) then {
	detach _wpn;
	_wpn setposatl (player modelToWorld [0,1,0]);
};
