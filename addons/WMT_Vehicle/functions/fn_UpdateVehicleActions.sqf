/*
 	Name: WMT_fnc_UpdateVehicleActions
 	
 	Author(s):
		Ezhuk

 	Description:
		Add actions 
*/

// Repair system
if (wmt_param_FullRepair==0) then {
	// Cancle action
	player addAction ["<t color='#0353f5'>"+localize("STR_CANCEL_ACTION")+"</t>", {WMT_mutexAction = false}, [], 10, false, true, '', 'WMT_mutexAction'];
	// Field repair
	player addAction ["<t color='#0353f5'>"+localize("STR_FIELD_REPAIR")+"</t>", WMT_fnc_Fieldrepairvehicle, [], -1, false, true, '','(not isNull cursorTarget) and {alive player} and {(player distance cursortarget) <= 7} and {(vehicle player == player)} and {speed cursortarget < 3} and {not WMT_mutexAction} and {alive cursortarget} and {cursortarget call WMT_fnc_vehicleIsDamaged}'];
	// Full repair near repair truck
	if (WMT_Local_fullRepairEnabled) then {
		player addAction["<t color='#0353f5'>"+localize ("STR_SERIOUS_REPAIR")+ "</t>", WMT_fnc_FullRepair, [], -1, false, true, '','[] call WMT_fnc_FullRepairCond'];
	};
};

// Reammo system
if (wmt_param_Reammo==0) then {
	if (WMT_Local_ReammoEnable) then {
		player addAction[ format ["<t color='#0353f5'>%1</t>", (localize "STR_ACTION_REAMMO")], wmt_fnc_Reammo, [], 1, false, true, '', '[] call wmt_fnc_ReammoCond'];
	};
};

// Push boat 
if (wmt_param_PushBoat==0) then {
	player addAction ["<t color='#0353f5'>"+localize('STR_PUSH_BOAT')+"</t>",WMT_fnc_pushboat, [], -1, false, true, "", 'vehicle player == player and {not isNull cursorTarget} and {cursorTarget isKindOf "Ship"} and {player distance cursorTarget < 8} and {not WMT_mutexAction} and {isTouchingGround player}'];  
};

// Moving static weapon
if (WMT_param_StaticWeaponDrag==0) then {
	player addAction ["<t color='#0353f5'>"+localize("STR_DRAG_STATIC")+"</t>", WMT_fnc_StaticWpnDrag, [], -1, false, true, '', 'not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["WMT_drag", false])} and {count crew cursorTarget == 0};'];
};

// Low gear 
if (wmt_param_LowGear==0) then {
	player addAction[ format ["<t color='#0353f5'>%1</t>", (localize "STR_ACTION_LOWGEARON") ], WMT_fnc_LowGear, [], 1, false, true, '','[] call WMT_fnc_LowGearCond'];
	player addAction[ format ["<t color='#0353f5'>%1</t>", (localize "STR_ACTION_LOWGEAROFF")], {WMT_Local_LowGearOn=false;}, [], 1, false, true, '','WMT_Local_LowGearOn'];
};