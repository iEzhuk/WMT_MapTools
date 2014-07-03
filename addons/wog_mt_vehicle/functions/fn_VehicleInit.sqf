/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Entry point for all mod

*/

if (isNil "wog_mt_flagDisableRepair" or {not wog_mt_flagDisableRepair }) then {[] call WMT_fnc_RepairInit;};
if (isNil "wog_mt_flagDisableStaticWeaponDrag" or {not wog_mt_flagDisableStaticWeaponDrag }) then {[] call WMT_fnc_StaticWpnInit;};
if (isNil "wog_mt_flagDisableShowVehicleCrew" or {not wog_mt_flagDisableShowVehicleCrew }) then {[] call WMT_fnc_ShowVehicleCrew;};
if (isNil "wog_mt_flagDisablePushBoat" or {not wog_mt_flagDisablePushBoat}) then {[] call WMT_fnc_PushBoatInit;};
if (isNil "wog_mt_flagDisableLowGear" or {not  wog_mt_flagDisableLowGear}) then {[] call WMT_fnc_LowGearInit;};
if (isNil "wog_mt_flagDisableRearmSystem" or {not wog_mt_flagDisableRearmSystem }) then {[] call WMT_fnc_InitRearmSystem;};
