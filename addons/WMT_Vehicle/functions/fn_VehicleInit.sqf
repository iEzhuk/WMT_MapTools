/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Entry point for all mod

*/

WMT_mutexAction = false;  

WMT_flagDisableRepair = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableRepair");
WMT_flagDisableStaticWeaponDrag = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableStaticWeaponDrag");
WMT_flagDisableShowVehicleCrew = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableShowVehicleCrew");
WMT_flagDisablePushBoat = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisablePushBoat");
WMT_flagDisableLowGear = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableLowGear");
WMT_flagDisableRearmSystem = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableRearmSystem");


if (isNil "WMT_flagDisableRepair" or { WMT_flagDisableRepair == 0}) then {[] call WMT_fnc_fieldrepair;};
if (isNil "WMT_flagDisableStaticWeaponDrag" or { WMT_flagDisableStaticWeaponDrag ==0}) then {[] call WMT_fnc_StaticWpnInit;};
if (isNil "WMT_flagDisableShowVehicleCrew" or { WMT_flagDisableShowVehicleCrew ==0}) then {[] call WMT_fnc_ShowVehicleCrew;};
if (isNil "WMT_flagDisablePushBoat" or { WMT_flagDisablePushBoat==0}) then {[] call WMT_fnc_PushBoatInit;};
if (isNil "WMT_flagDisableLowGear" or {  WMT_flagDisableLowGear==0}) then {[] call WMT_fnc_LowGearInit;};
if (isNil "WMT_flagDisableRearmSystem" or { WMT_flagDisableRearmSystem==0 }) then {[] call WMT_fnc_InitRearmSystem;};

if (isDedicated) exitWith {};
waitUntil {sleep 0.39; player == player};

player addAction ["<t color='#FF9900'>"+localize('STR_PUSH_BOAT')+"</t>",WMT_fnc_pushboat,[],-1,false,false,"",'vehicle player == player and {not isNull cursorTarget} and {cursorTarget isKindOf "Ship"} and {player distance cursorTarget < 8} and {not WMT_mutexAction}'];  
player addAction["<t color='#ff0000'>"+localize("STR_DRAG_STATIC")+"</t>", WMT_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["WMT_drag", false])} and {count crew cursorTarget == 0};'];

player addEventHandler ["Respawn", {
	player addAction ["<t color='#FF9900'>"+localize('STR_PUSH_BOAT')+"</t>",WMT_fnc_pushboat,[],-1,false,false,"",'vehicle player == player and {not isNull cursorTarget} and {cursorTarget isKindOf "Ship"} and {player distance cursorTarget < 8} and {not WMT_mutexAction}'];  
	player addAction["<t color='#ff0000'>"+localize("STR_DRAG_STATIC")+"</t>", WMT_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["WMT_drag", false])} and {count crew cursorTarget == 0};'];
}];

