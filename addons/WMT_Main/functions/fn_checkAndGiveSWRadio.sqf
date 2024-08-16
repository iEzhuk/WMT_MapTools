//params ["_unit"];
[] spawn {
    if (!hasInterface) exitWith {};
    if (isNil "TFAR_fnc_isRadio") exitWith {};
    sleep 1.5;
    if (isNil "wmt_autocheck_radio" || !wmt_autocheck_radio) exitWith {diag_log "WMT_Main:checkAndGiveSWRadio: wmt_autocheck_radio is disabled, exititng.";};
    if (!isNil "WMT_pub_frzState") then {
        waitUntil {sleep 1.5; WMT_pub_frzState >= 3};
    };

    sleep 10;
    private _unit = player;
    private _result = false;
    {
        if (_x call TFAR_fnc_isRadio) exitWith {_result = true};
    } forEach (assignedItems _unit);

    if (!_result) then {
        _unit linkItem "ItemRadio";
    };

};