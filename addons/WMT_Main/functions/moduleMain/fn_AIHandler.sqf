/*
    Name:
        WMT_fnc_AIHandler
    Author(s):
        Kurt

    Description:
		Handles units' locality changes and en/disables AI
    Parameters:
        NULL
    Returns:
        NULL
*/


if (!isServer) exitWith {
	"Error. WMT_fnc_AIHandler called on client" call BIS_fnc_log;
};

{
	[_x] call WMT_fnc_DisableAI;
}forEach allUnits;

// check if server = player
if(!isDedicated) then {
	[player] call WMT_fnc_EnableAI;
};

{
	_x addEventHandler [
		"Local",
		{
			params ["_obj", "_isLocal"];

			diag_log str ["WMT locality", time, _obj, _isLocal];
			systemChat str _this;

			if(_isLocal) then {
				[_obj] call WMT_fnc_DisableAI;
			} else {
				[
					[obj],
					WMT_fnc_EnableAI
				] remoteExecCall ["call", _obj];
			};

		}
	];
}forEach allUnits;