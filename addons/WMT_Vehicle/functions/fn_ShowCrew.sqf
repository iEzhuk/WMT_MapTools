/*
 	Name: WMT_fnc_ShowCrew
 	
 	Author(s):
		Ezhuk

 	Description:
		Show list of vehivle crew

	Parameters:
		ARRAY: handler from onLoad event

 	Returns:
		Nothing
*/
private ["_rsc","_veh","_text","_control"];

disableSerialization;

_rsc  	 = _this select 0;
_control = (_rsc displayCtrl 5001);
_veh  	 = vehicle player;
_text 	 = "<br/>";

if((alive player) && (_veh != player) && (alive _veh)) then 
{
	{
		private ["_icon"];
		_icon = switch (true) do {
					case (_x == driver _veh): {"getindriver_ca.paa"};
					case (_x == gunner _veh): {"getingunner_ca.paa"};
					case (_x == commander _veh): {"getincommander_ca.paa"};
					default {"getincargo_ca.paa"};
				};
		_text = _text + format ["<t size='1.2'> <img image='\A3\ui_f\data\igui\cfg\actions\%1'></t><t size='1.5' color='#eeeeff'> %2</t>",_icon,name _x];

		// Add number of crew in first line 
		if(_forEachIndex == 0) then {
			_text = _text + format ["<t size='1.5' color='#eeeeff'> (%1)</t>",count crew _veh];
		};

		_text = _text + "<br/>";
	} forEach crew _veh;
};

_control ctrlSetStructuredText (parseText _text);
_control ctrlCommit 0;