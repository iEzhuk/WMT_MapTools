/*
    Name:
        WMT_fnc_ServerKilled
    Author(s):
        Kurt

    Description:
		Handles MP kills and updates public variable
    Parameters:
        NULL
    Returns:
        NULL
*/

if(!isServer) exitWith {
    "Error. WMT_fnc_ServerKilled called on client" call BIS_fnc_log;
};

WMT_UIDKilledList = [];
publicVariable "WMT_UIDKilledList";

{
	_x addMPEventHandler [
        "MPKilled",
        {
            params ["_unit"];
            _uid = getPlayerUID _unit;
            if(_uid != "") then {
                WMT_UIDKilledList = WMT_UIDKilledList + [_uid];
                publicVariable "WMT_UIDKilledList";
            };
        }
    ];
}forEach allUnits;

// when jip asks to delete his bot after he leaves
"pDeleteJIP" addPublicVariableEventHandler {
    params ["", "_data"];
    _data spawn {
        params ["_unit"];
        // wait until players leaves mission
        waitUntil {local _unit};
        deleteVehicle _unit;
    };
};
