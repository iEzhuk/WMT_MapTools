if (hasInterface) then {
	0 spawn
	{
		disableSerialization;
		uisleep 1.;
		_display = uinamespace getVariable "RscDiary";
		_ctrl = _display ctrlCreate ["RscText", -1];
		_ctrl ctrlSetPosition [0.5, safezoneY, 0.15, 0.05];
		_ctrl ctrlSetText "00:00";
		_ctrl ctrlSetTextColor [0.75, 0.75, 0.75, 1];
		_ctrl ctrlCommit 0;
		_time1 = diag_ticktime;
		_eh = _display displayAddEventHandler ["keyDown", "(_this select 1) in [28,57,156];"];
		while {time < 0.1} do {
			_s1=  [ diag_ticktime - _time1  ,"MM:SS"] call BIS_fnc_secondsToString;
			_ctrl ctrlSetText _s1;
			_ctrl ctrlCommit 0;
			uisleep 1.2;
		};
		ctrlDelete _ctrl;
		_display displayRemoveEventHandler ["keyDown",_eh];
	};
};
