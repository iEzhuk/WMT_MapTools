/*
 	Name: WMT_fnc_InitModuleVehicle
 	
 	Author(s):
		Zealot

 	Description:
		Initialize vehicle module
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;


if(_activated) then {

	if(isNil "wmt_param_FullRepair") then {
		wmt_param_FullRepair = _logic getVariable "FullRepair";
	};	
	if(isNil "wmt_param_VehicleCrew") then {
		wmt_param_VehicleCrew = _logic getVariable "VehicleCrew";
	};
	if(isNil "wmt_param_LowGear") then {
		wmt_param_LowGear = _logic getVariable "LowGear";
	};	
	if(isNil "wmt_param_PushBoat") then {
		wmt_param_PushBoat = _logic getVariable "PushBoat";
	};
	if(isNil "wmt_param_Reammo") then {
		wmt_param_Reammo = _logic getVariable "Reammo";
	};	
};
