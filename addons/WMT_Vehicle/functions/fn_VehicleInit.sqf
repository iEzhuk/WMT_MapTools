/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Entry point for all mod

*/


WMT_flagDisableRepair = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableRepair");
WMT_flagDisableStaticWeaponDrag = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableStaticWeaponDrag");
WMT_flagDisableShowVehicleCrew = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableShowVehicleCrew");
WMT_flagDisablePushBoat = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisablePushBoat");
WMT_flagDisableLowGear = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableLowGear");
WMT_flagDisableRearmSystem = getNumber (MissionConfigFile >> "WMT_Params" >> "WMT_flagDisableRearmSystem");


if (isNil "WMT_flagDisableRepair" or { WMT_flagDisableRepair == 0}) then {[] call WMT_fnc_RepairInit;};
if (isNil "WMT_flagDisableStaticWeaponDrag" or { WMT_flagDisableStaticWeaponDrag ==0}) then {[] call WMT_fnc_StaticWpnInit;};
if (isNil "WMT_flagDisableShowVehicleCrew" or { WMT_flagDisableShowVehicleCrew ==0}) then {[] call WMT_fnc_ShowVehicleCrew;};
if (isNil "WMT_flagDisablePushBoat" or { WMT_flagDisablePushBoat==0}) then {[] call WMT_fnc_PushBoatInit;};
if (isNil "WMT_flagDisableLowGear" or {  WMT_flagDisableLowGear==0}) then {[] call WMT_fnc_LowGearInit;};
if (isNil "WMT_flagDisableRearmSystem" or { WMT_flagDisableRearmSystem==0 }) then {[] call WMT_fnc_InitRearmSystem;};



