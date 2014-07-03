
if (isDedicated) exitWith {};
waitUntil{!(isNull (findDisplay 46))};

Func_KeyHandler_ShowCrew = {
	private ["_rsc","_veh","_text","_control"];
	disableSerialization;
	_rsc  = _this select 0;
	_control = (_rsc displayCtrl 5001);
	_veh  = vehicle player;
	_text = "<br/>";


	if( (alive player) && (_veh != player) && (alive _veh)) then 
	{
		private ["_i"];
		_i = 1;
		{
			private ["_icon"];
			_icon = "getincargo_ca.paa";

			if(_x == driver _veh) then {
				_icon = "getindriver_ca.paa";
			};
			if(_x == gunner _veh) then {
				_icon = "getingunner_ca.paa";
			};
			if(_x == commander _veh) then {
				_icon = "getincommander_ca.paa";
			};
			_text = _text + format ["<t size='1.0'> <img image='\A3\ui_f\data\igui\cfg\actions\%1'></t><t size='1.2' color='#eeeeff'> %2</t>",_icon,name _x];
			if(_i == 1) then {
				_text = _text + format ["<t size='1.2' color='#eeeeff'> (%1)</t>",count crew _veh];
			};
			_text = _text + "<br/>";
			_i = _i + 1;
		} forEach crew _veh;
	};
	
	_control ctrlSetStructuredText (parseText _text);
	_control ctrlCommit 0;
};

Func_KeyHandler_VehicleCrew = {
	if((_this select 1 ) < 0)exitWith{};
	if ( (alive player) && (alive (vehicle player)) && (vehicle player != player)) then {
		if( !((vehicle player) isKindOf "StaticWeapon") ) then
		{
			50 cutRsc ["RscVechileCrew","PLAIN"];	
		};	
	};
};

(findDisplay 46) displayAddEventHandler ["MouseZChanged","_this call Func_KeyHandler_VehicleCrew;"]