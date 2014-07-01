/*
 	Name: WMT_fnc_BriefingVehicles
 	
 	Author(s):
		Ezhuk

 	Description:
		Add list of vehicles to briefing 

	Parameters:
 		Nothing
 	Returns:
		Nothing 
*/

#define PR(x) private ['x']; x

PR(_text) = "";
PR(_vehsName) = [];
PR(_vehsCount) = [];
{
	if(!(_x isKindOf "Strategic") && !(_x isKindOf "Thing"))then
	{
		PR(_nearestUnit) = nearestObject [_x, "Man"];
		PR(_show) = false;
		if(_x getVariable ["WMT_side",sideLogic] == side player) then
		{
			_show = true;
		}else{
			_nearestUnit = nearestObject [_x, "Man"];
			if(!(isNil "_nearestUnit") ) then
			{
				if( side player == side _nearestUnit) then
				{
					_show = true;
				};
			};
		};
		if(_show) then
		{
			PR(_veh) = getText (configFile >> "CfgVehicles" >> typeOf _x >> "Displayname");
			PR(_i) = _vehsName find _veh;

			if(_i >= 0)then{
				_vehsCount set [_i,(_vehsCount select _i) + 1 ];
			}else{
				_vehsName  set [count _vehsName , _veh];
				_vehsCount set [count _vehsCount,   1 ];
			};
		};
	};
}forEach vehicles;

for "_i" from 0 to ((count _vehsName)-1) do
{
	_text = _text + format ["<font color='#c7861b'>%1</font> - %2",_vehsCount select _i,_vehsName select _i];
	_text = _text + "<br/>";
};

["diary",localize "STR_Vehicles", _text] call WMT_fnc_CreateDiaryRecord;
