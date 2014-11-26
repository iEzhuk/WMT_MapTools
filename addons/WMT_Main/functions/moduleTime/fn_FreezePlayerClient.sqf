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
#define PR(x) private ['x']; x

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
{ 
	PR(_evh) = _x addEventHandler ["Fired",{if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}];
	_x setVariable ["frz_evh", _evh];
	wmt_frz_vehs pushback _x;

	PR(_handler) = _x addEventHandler ["Engine", {
		_car = _this select 0;
		_engineon = _this select 1;
		if ( WMT_pub_frzState < 3 and local _car and _engineon) then {
			player action ["engineoff", _car];
		};
	}];
	_x setVariable ["wmtfrzEngine", _handler];

} foreach (call WMT_fnc_GetVehicles);

// Check UAV terminal
["itemAdd", ["wmtfrzuav", {
	if(!isNull (findDisplay 160)) then {
		(findDisplay 160) closeDisplay 0;
		["<t size='0.7' color='#ff2222'>"+localize "STR_WMT_FreezeUAVTerminal"+"</t>", 0, 0.2*safeZoneH+safeZoneY, 3, 0, 0, 273] spawn bis_fnc_dynamicText;
	};
}, 15, "frames", {time > 0.5}, {WMT_pub_frzState >= 3} ]] call BIS_fnc_loop;

["itemAdd", ["wmtfrzdate", {setDate WMT_pub_frzBeginDate; }, 0.1, "seconds", {!isNil "WMT_pub_frzBeginDate"}, {WMT_pub_frzState >= 3} ]] call BIS_fnc_loop;


// check position 
["itemAdd", ["wmtfrzstart", {
	if (!isNil "wmt_freeze_startpos" and {count wmt_freeze_startpos > 0}) then {
		PR(_dist) = player distance wmt_freeze_startpos;
		if ( _dist > _distance and _dist < _maxdistance ) then {
			_msg = "<t size='0.75' color='#ff0000'>"+localize "STR_WMT_FreezeZoneFlee" +"</t>";
			[_msg, 0, 0.25, 3, 0, 0, 27] spawn bis_fnc_dynamicText;

		};
		if (_dist > _maxdistance) then {
			player setVelocity [0,0,0];
			player setPos wmt_freeze_startpos;
		};
	};
	if (player != (vehicle player) and {local (vehicle player)} and {isEngineOn (vehicle player)}) then {
		(vehicle player) engineOn false;
	};
}, 20, "frames", {time > 0.5}, {WMT_pub_frzState >= 3} ]] call BIS_fnc_loop;

["itemAdd", ["wmtfrzend", {
	enableEngineArtillery true;
	deleteMarkerLocal "WMTPlayerFreeze";
	player removeEventHandler ["Fired",wmt_freezeGrenadeHandler];
	wmt_freezeGrenadeHandler = nil;
	{
		PR(_evh) = _x getVariable "frz_evh";
		if (!isNil "_evh") then {
			_x removeEventHandler ["Fired", _evh];
		};
		_x removeEventHandler ["Engine", (_x getVariable ["wmtfrzEngine",0]) ];
	} foreach wmt_frz_vehs;
	wmt_frz_vehs = nil;
	wmt_frzdistance = nil;
	wmt_frzmaxdistance = nil;
}, nil, nil, {WMT_pub_frzState >= 3}, {false}, true]] call BIS_fnc_loop;




