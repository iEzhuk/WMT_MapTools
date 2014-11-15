/*
 	Name:  
 		WMT_fnc_BriefingMap
 	
 	Author(s):
		Zealot

 	Description:
		Add map for player in briefing time and remove after start

	Parameters:
 		Nothing
 	
 	Returns:
		Nothing 
*/

waituntil {not isNull player};
if ("ItemMap" in assignedItems player) exitWith {};
player linkItem "ItemMap";
sleep 0.001;
player unlinkItem "itemMap";