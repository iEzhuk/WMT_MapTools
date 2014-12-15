
#define DISTANCE_TO_REPAIRVEHICLE 15

private ["_res","_objs","_truck"];
_truck = objNull;

_res = false;
if (not isNull cursorTarget) then {
	if (vehicle player == player) then {
		if (player distance cursortarget <= 7) then {
			if (alive player and alive cursortarget) then  {
				if  ((speed cursortarget < 3) and (not WMT_mutexAction)) then {
					if (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Ship" || cursorTarget isKindOf "Air" || cursorTarget isKindOf "Tank") then {
/*					_objs = nearestObjects [player, ["Car","Tank","Air","Ship"], DISTANCE_TO_REPAIRVEHICLE];
					{ if ( alive _x and {_x getVariable ["wmt_repair_cargo", -1] > -0.5} ) then {_truck = _x;}; } foreach _objs;
					if (not isNull _truck) then { */
						_res = true;
					};
				};
			};
		};
	};
};

_res