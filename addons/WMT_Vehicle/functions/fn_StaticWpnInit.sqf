
/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		

*/



if (isDedicated) exitWith {};
waitUntil { sleep 0.47; player == player};

WMT_drag = false;

zlt_fnc_drag = {
	_wpn = cursorTarget;
	if (isnil "_wpn") exitWith {};
	player playMove "acinpknlmstpsraswrfldnon";
	_wpn attachto [player,[0,1,1.5]];
	WMT_drag = true;
	_wpn setVariable ["WMT_drag", true, true];
	[ [ [_wpn,true], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_wpn] call bis_fnc_mp;
	sleep 0.1;
	_reltxt = format [localize("STR_RELEASE_STATIC"), getText (configFile >> "CfgVehicles" >> typeof _wpn >> "Displayname")];
	_rel = player addaction [("<t color=""#00FF00"">") + _reltxt + "</t>",{WMT_drag = false},[],15,true,true,"","true"];
	waitUntil {not alive player or ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))};
	while {count crew _wpn == 0 and WMT_drag and vehicle player == player and alive player and ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))} do {
		sleep 0.16;
	};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";
	player removeAction _rel;
	WMT_drag = false;	
	_wpn setVariable ["WMT_drag", false, true];
	[ [ [_wpn,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_wpn] call bis_fnc_mp;
	if not (isNull _wpn) then {
		detach _wpn;
		_wpn setposatl (player modelToWorld [0,1,0]);
	};

};


player addAction["<t color='#ff0000'>"+localize("STR_DRAG_STATIC")+"</t>", zlt_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["WMT_drag", false])} and {count crew cursorTarget == 0};'];

player addEventHandler ["Respawn", {
	player addAction["<t color='#ff0000'>"+localize("STR_DRAG_STATIC")+"</t>", zlt_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["WMT_drag", false])} and {count crew cursorTarget == 0};'];
}];