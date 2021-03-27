/*
	Called when entitry killed (MissionEvent) on server side
*/

params ["_victim", "_killer", "_instigator"];
if !(_victim getvariable ["wmtIsKilled",false]) then {
    _victim setvariable ["wmtIsKilled",true];

    [_victim, _killer, _instigator] spawn {
          params ["_victim", "_killer", "_instigator"];
          if (_killer == _victim) then {
            private _time = diag_tickTime;
            [_victim, {
                _this setVariable ["ace_medical_lastDamageSource", (_this getVariable ["ace_medical_lastDamageSource", _this]), 2];
            }] remoteExec ["call", _victim];
            waitUntil {diag_tickTime - _time > 10 || !(isNil {_victim getVariable "ace_medical_lastDamageSource"})};
            _killer = _victim getVariable ["ace_medical_lastDamageSource", _killer];
        } else {
            _killer
        };
        if (isNull _instigator) then {
            _instigator = UAVControl vehicle _killer select 0
        };
        if ((isNull _instigator) || (_instigator == _victim)) then {
            _instigator = _killer
        };
        if (_instigator isKindOf "AllVehicles") then {
            // _instigator =  effectiveCommander _instigator
            _instigator = call {
                if(alive(gunner _instigator))exitWith{gunner _instigator};
                if(alive(commander _instigator))exitWith{commander _instigator};
                if(alive(driver _instigator))exitWith{driver _instigator};
                    effectiveCommander _instigator
            };
        };
        if (isNull _instigator) then {
            _instigator = _killer
        };


		private _victimName = _victim getVariable ["PlayerName", name _victim];
		private _victimSide = _victim getVariable ["PlayerSide", sideUnknown];
		if (isNil "_victimName" || _victimName isEqualTo "") exitWith {diag_log ["WMT_EntityKilled victimName is nil or empty", _victim, _killer, _instigator];};


        if (isNull _instigator) exitWith {diag_log ["WMT_EntityKilled instigator is null", _victim, _killer, _instigator];};
		private _killerName = _instigator getVariable ["PlayerName", name _instigator];
		private _KillerSide = _instigator getVariable ["PlayerSide", sideUnknown];
		if (isNil "_killerName" ||  _killerName isEqualTo "") exitWith {diag_log ["WMT_EntityKilled killerName is nil or empty", _victim, _killer, _instigator];};


		// victim
		[ [ [_killerName,_killerSide], { WMT_Local_Killer = _this; } ],"bis_fnc_spawn",_victim] call bis_fnc_mp;
		// killer
		[ [ [_victimName,_victimSide], { WMT_Local_Kills pushback (_this); } ],"bis_fnc_spawn",_instigator] call bis_fnc_mp;

    };

};