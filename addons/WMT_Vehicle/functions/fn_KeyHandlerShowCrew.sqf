/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/
if((_this select 1 ) < 0)exitWith{};
if ( (alive player) && (alive (vehicle player)) && (vehicle player != player)) then {
	if( !((vehicle player) isKindOf "StaticWeapon") ) then
	{
		50 cutRsc ["RscWMTVehicleCrew","PLAIN"];	
	};	
};