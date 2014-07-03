/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Entry point for all mod

*/

if (isNil "WMT_flagDisableRepair" or {not WMT_flagDisableRepair }) then {[] call WMT_fnc_RepairInit;};
if (isNil "WMT_flagDisableStaticWeaponDrag" or {not WMT_flagDisableStaticWeaponDrag }) then {[] call WMT_fnc_StaticWpnInit;};
if (isNil "WMT_flagDisableShowVehicleCrew" or {not WMT_flagDisableShowVehicleCrew }) then {[] call WMT_fnc_ShowVehicleCrew;};
if (isNil "WMT_flagDisablePushBoat" or {not WMT_flagDisablePushBoat}) then {[] call WMT_fnc_PushBoatInit;};
if (isNil "WMT_flagDisableLowGear" or {not  WMT_flagDisableLowGear}) then {[] call WMT_fnc_LowGearInit;};
if (isNil "WMT_flagDisableRearmSystem" or {not WMT_flagDisableRearmSystem }) then {[] call WMT_fnc_InitRearmSystem;};
