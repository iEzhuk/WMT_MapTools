/*
	Name: WMT_fnc_FreezePlayerClient

	Author(s):
		Zealot

	Description:

	Parameters:
		0 - size of start zone

	Returns:
		Nothing
*/
wmt_frzdistance = [_this, 0, 150] call BIS_fnc_param;
wmt_frzmaxdistance = wmt_frzdistance + 20;


if (isNil "wmt_freeze_startpos") then {
	wmt_freeze_startpos = getpos player;
};

if (isNil "wmt_freeze_marker") then {
	["WMTPlayerFreeze",wmt_freeze_startpos,"","ColorGreen","EMPTY",[wmt_frzdistance, wmt_frzdistance],"ELLIPSE",0,"Solid"] call WMT_fnc_CreateLocalMarker;
};

sleep 0.01;

wmt_freezeGrenadeHandler = player addEventHandler ["Fired", { if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}];

enableEngineArtillery false;

wmt_frz_vehs = [];
private ["_evh", "_handler"];
{
	_evh = _x addEventHandler ["Fired",{if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}];
	_x setVariable ["frz_evh", _evh];
	wmt_frz_vehs pushback _x;

	_handler = _x addEventHandler ["Engine", {
		_car = _this select 0;
		_engineon = _this select 1;
		if ( WMT_pub_frzState < 3 and local _car and _engineon) then {
			player action ["engineoff", _car]; _car engineOn false;
		};
	}];
	_x setVariable ["wmtfrzEngine", _handler];

} foreach (call WMT_fnc_GetVehicles);



0 spawn {
	while {WMT_pub_frzState < 3} do {
		setDate WMT_pub_frzBeginDate;
		sleep 30;
	};
};


while {WMT_pub_frzState < 3} do {
	// Check UAV terminal
	if(!isNull (findDisplay 160)) then {
		(findDisplay 160) closeDisplay 0;
		["<t size='0.7' color='#ff2222'>"+localize "STR_WMT_FreezeUAVTerminal"+"</t>", 0, 0.2*safeZoneH+safeZoneY, 3, 0, 0, 273] spawn bis_fnc_dynamicText;
	};
	// check position
	if (!isNil "wmt_freeze_startpos" and {count wmt_freeze_startpos > 0}) then {
		private _dist = player distance wmt_freeze_startpos;
		if ( _dist > wmt_frzdistance and _dist < wmt_frzmaxdistance ) then {
			_msg = "<t size='0.75' color='#ff0000'>"+localize "STR_WMT_FreezeZoneFlee" +"</t>";
			[_msg, 0, 0.25, 3, 0, 0, 27] spawn bis_fnc_dynamicText;

		};
		if (_dist > wmt_frzmaxdistance) then {
			player setVelocity [0,0,0];
			player setPos wmt_freeze_startpos;
		};
	};
	if (player != (vehicle player) and {local (vehicle player)} and {isEngineOn (vehicle player)}) then {
		(vehicle player) engineOn false;
	};
	sleep 1.05;
};

setDate WMT_pub_frzBeginDate;
enableEngineArtillery true;
deleteMarkerLocal "WMTPlayerFreeze";
if !(isNil "wmt_freezeGrenadeHandler") then {
	player removeEventHandler ["Fired",wmt_freezeGrenadeHandler];
	wmt_freezeGrenadeHandler = nil;
};
{
	private _evh = _x getVariable "frz_evh";
	if (!isNil "_evh") then {
		_x removeEventHandler ["Fired", _evh];
	};
	_x removeEventHandler ["Engine", (_x getVariable ["wmtfrzEngine",0]) ];
} foreach wmt_frz_vehs;
wmt_frz_vehs = nil;
wmt_frzdistance = nil;
wmt_frzmaxdistance = nil;
if ((profilenamespace getvariable ['WMT_BeepAfterFreezeOption', 0]) == 1) then {playSound "wmt_beep";};
