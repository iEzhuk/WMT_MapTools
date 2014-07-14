/*
 	Name: WMT_fnc_InitModuleMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;


if(_activated) then {
	// thermal image 
	if(isNil "wmt_param_TI") then {
		wmt_param_TI = _logic getVariable "TI";
	};
	// view distace 
	if(isNil "wmt_param_MaxViewDistance") then {
		wmt_param_MaxViewDistance = _logic getVariable "MaxViewDistance";
	};
	// view distace 
	if(isNil "wmt_param_NameTag") then {
		wmt_param_NameTag = _logic getVariable "NameTag";
	};
	if(isNil "wmt_param_HeavyLossesCoeff") then {
		wmt_param_HeavyLossesCoeff = _logic getVariable "HeavyLossesCoeff";
	};
	if(isNil "wmt_param_ShowEnemyVehiclesInNotes") then {
		wmt_param_ShowEnemyVehiclesInNotes = _logic getVariable "ShowEnemyVehiclesInNotes";
	};
	if(isNil "wmt_param_GenerateFrequencies") then {
		wmt_param_GenerateFrequencies = _logic getVariable "GenerateFrequencies";
	};
	if(isNil "wmt_param_ShowVehiclesBriefing") then {
		wmt_param_ShowVehiclesBriefing = _logic getVariable "ShowVehiclesBriefing";
	};
	if(isNil "wmt_param_ShowSquadsBriefing") then {
		wmt_param_ShowSquadsBriefing = _logic getVariable "ShowSquadsBriefing";
	};
	

	

};
