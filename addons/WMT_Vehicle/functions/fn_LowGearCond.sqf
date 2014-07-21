/*
 	Name: WMT_fnc_LowGearCond
 	
 	Author(s):
		Ezhuk

 	Description:
		Check conditions for lowgear 

	Parameters:
		Nothing

 	Returns:
		BOOL
*/
private ["_res","_veh"];
_veh = vehicle player;
_res = false;

if(!WMT_Local_LowGearOn)then{
	if(player != _veh && player==(driver _veh))then{
		if(alive player && alive _veh && canMove _veh && isEngineOn _veh)then{
			if((["APC",str(typeOf _veh)] call BIS_fnc_inString) || {["MBT",str(typeOf _veh)] call BIS_fnc_inString} || {["Truck",str(typeOf _veh)] call BIS_fnc_inString} || {["MRAP",str(typeOf _veh)] call BIS_fnc_inString} || {["Offroad",str(typeOf _veh)] call BIS_fnc_inString})then{
				if( (getPosASL _veh select 2) - (getPosATL _veh select 2) > -2) then {
					if( (abs (speed _veh)) < 25)then{
						_res = true;
					};
				};
			};
		};
	};
};
_res