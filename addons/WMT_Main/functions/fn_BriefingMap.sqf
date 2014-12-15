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


[] spawn {
	waituntil {not isNull player};
	wmt_mapadded = false;
	while {time < 0.1} do {
		uisleep 0.7;
		if !("ItemMap" in assignedItems player) then {
			wmt_mapadded = true;
			player linkItem "ItemMap";
		};
	};
	if (wmt_mapadded) then {
		player unlinkItem "itemMap";
	};
};
