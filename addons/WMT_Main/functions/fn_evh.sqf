// by [STELS]Zealot


// Example:
// ["push","Id123","FreezeEnded", {hint "hello";}] call wmt_fnc_evh;
// ["pop", "Id123", "FreezeEnded"] call call wmt_fnc_evh;
// ["CALL","FreezeEnded"] call wmt_fnc_evh;

private ['_id','_ehname','_code','_ehvarname','_evhs','_allevhs','_i','_params'];

_action = _this select 0; 

diag_log ["wmt_fnc_evh", _this];

switch (toUpper (_this select 0)) do {
	case "PUSH": {
		_id = toLower(_this select 1);
		_ehname = toLower(_this select 2);
		_code = _this select 3;
		_ehvarname = "wmt_evh_" + _ehname;
		_evhs = missionNamespace getVariable [_ehvarname, []];
		_evhs pushBack [_id, _code ];
		missionNamespace setVariable [_ehvarname, _evhs];
		_allevhs = missionNamespace getVariable ["wmt_evh_all",[]];
		if !(_ehvarname in _allevhs) then {_allevhs pushBack "_ehvarname"; missionNamespace setVariable ["wmt_evh_all", _allevhs];};

	};

	case "POP" : {
		_id = toLower(_this select 1);
		_ehname = toLower(_this select 2);
		_ehvarname = "wmt_evh_" + _ehname;
		_evhs = missionNamespace getVariable [_ehvarname, []];
		_i = [_evhs, _id ] call BIS_fnc_findInPairs;
		if (_i != -1) then {
			_evhs deleteAt _i;
			missionNamespace setVariable [_ehvarname, _evhs];
		};
	};

	case "CALL" : {
		_ehname = toLower(_this select 1);
		_params = []; if (count _this > 2) then {_params = _this select 2;};

		_ehvarname = "wmt_evh_" + _ehname;
		_evhs = missionNamespace getVariable [_ehvarname, []];		
		{
			_params call (_x select 1);
		} foreach _evhs;
	};

};


