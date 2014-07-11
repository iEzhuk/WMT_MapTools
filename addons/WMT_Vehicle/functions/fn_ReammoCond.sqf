/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
private ["_res","_obj","_repairVeh"];
_obj = cursorTarget;
_res = false;
if(!WMT_mutexAction) then
{
	if(!(isNull _obj)) then 
	{
		if(alive _obj && player == vehicle player) then 
		{
			if( ( locked _obj == 0 || locked _obj == 1) && _obj distance player < 8) then 
			{
				if( _obj isKindOf "LandVehicle" || _obj isKindOf "Ship" || _obj isKindOf  "Air" ) then 
				{
					if(not isNull (call wmt_fnc_ReammoGetNearest)) then {
						_res = true;
					};
				};
			};
		};
	};
};
_res