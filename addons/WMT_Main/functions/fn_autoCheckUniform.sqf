[] spawn {
    if (!isServer) exitWith {};
    sleep 1.5;
    if (isNil "wmt_autocheck_uniform" || !wmt_autocheck_uniform) exitWith {diag_log "WMT_Main:autoCheckUniform: wmt_autocheck_uniform is disabled, exititng.";};

    {

    /*     _x addEventHandler ["SeatSwitchedMan", {
            params ["_unit1", "_unit2", "_vehicle"];
            if (uniform _unit isEqualTo "") then {
                [_unit] remoteExec ["WMT_fnc_reequip",_unit];
            };

        }]; */

        _x addEventHandler ["GetOutMan", {
            params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];
            if (uniform _unit isEqualTo "") then {
                [_unit] remoteExec ["WMT_fnc_reequip",_unit];
            };
        }];



    } forEach playableUnits;

};