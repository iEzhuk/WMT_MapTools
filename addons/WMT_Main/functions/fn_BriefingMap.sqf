/*
 	Name:  
 	
 	Author(s):
		Zealot

 	Description:
		 

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