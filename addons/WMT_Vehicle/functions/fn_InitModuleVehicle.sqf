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
	if ( not isnil "wmt_Vehicle_ModuleRunning" ) exitWith {};
	wmt_Vehicle_ModuleRunning = true;

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
	if(isNil "WMT_param_StaticWeaponDrag") then {
		WMT_param_StaticWeaponDrag = _logic getVariable "StaticWeaponDrag"
	};
	WMT_mutexAction = false;

	//===============================================================
	// 							Server part
	//===============================================================
	if (isServer) then {
		// Repair 
		if (wmt_param_FullRepair==0) then {
			{ 
				if (getRepairCargo _x > 0) then {
					_x setRepairCargo 0;
					_x setVariable ["wmt_repair_cargo", 1, true]; 
				};
			} foreach vehicles;
		};

		// Reammo 
		if (isNil "wmt_ammoCargoVehs") then {wmt_ammoCargoVehs = [];};
		{
			_ammoCargo = getAmmoCargo _x ;
			if (_ammoCargo > 0 and _ammoCargo < 2) then {
				wmt_ammoCargoVehs set [count wmt_ammoCargoVehs, _x];
				_x setAmmoCargo 0;
			};
		} foreach vehicles;

	};

	//===============================================================
	// 						Client part 
	//===============================================================
	if (!isDedicated) then {
		waitUntil {player == player};

		// Reapir
		if (wmt_param_FullRepair==0) then {
			private ["_playerClass"];
			WMT_Local_fullRepairClasses 	= [];
			WMT_Local_fullRepairEnabled 	= false;
			WMT_Local_hardFieldRepairParts 	= ["HitEngine", "HitLTrack","HitRTrack"];
			WMT_Local_fieldRepairHps 		= ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel"] + WMT_Local_hardFieldRepairParts;

			_playerClass= toUpper (typeof player);
			switch ( true ) do {
				case (_playerClass in ["B_CREW_F","I_CREW_F","O_CREW_F"]) : {
					WMT_Local_fullRepairClasses = ["Car","Tank","Ship"];
					WMT_Local_fullRepairEnabled = true; 
				};
				case (_playerClass in ["O_ENGINEER_F","B_ENGINEER_F","I_ENGINEER_F","B_SOLDIER_REPAIR_F","I_SOLDIER_REPAIR_F","O_SOLDIER_REPAIR_F","B_G_ENGINEER_F"]) : {
					WMT_Local_fullRepairClasses = ["Car","Tank","Ship","Air"];
					WMT_Local_fullRepairEnabled = true; 
				};
				case (_playerClass in ["O_PILOT_F","B_PILOT_F","I_PILOT_F","O_HELICREW_F","I_HELICREW_F","B_HELICREW_F","O_HELIPILOT_F","B_HELIPILOT_F","I_HELIPILOT_F"]) : {
					WMT_Local_fullRepairClasses = ["Car","Tank","Ship","Air"];
					WMT_Local_fullRepairEnabled = true; 
				};
				case (_playerClass in ["O_SOLDIER_UAV_F","I_SOLDIER_UAV_F","B_SOLDIER_UAV_F"]) : {
					WMT_Local_fullRepairClasses = ["UGV_01_base_F","UAV_01_base_F","UAV_02_base_F"];
					WMT_Local_fullRepairEnabled = true; 
				};
			};
		};
		
		// Rearm system
		if (wmt_param_Reammo==0) then {
			WMT_Local_ReammoEnable = 	switch (true) do {
									case (["engineer", str(typeOf player)] call BIS_fnc_inString):{true};
									case (["crew" 	 , str(typeOf player)] call BIS_fnc_inString):{true};
									case (["pilot"	 , str(typeOf player)] call BIS_fnc_inString):{true};
									default {false};
								};
		};


		// Low Gear 
		if (wmt_param_LowGear==0) then {
			WMT_Local_LowGear_mutex = diag_tickTime;
			WMT_Local_LowGearOn = false;
		};

		// Rsc
		5101 cutRsc ["RscWMTProgressBar","PLAIN"];

		// Add event handler to display 46 
		[] spawn {
			waitUntil{sleep 0.36; !(isNull (findDisplay 46))};

			//Low gear 
			if (wmt_param_LowGear==0) then {
				(findDisplay 46) displayAddEventHandler ["KeyDown", {
					private ["_key"];
					_key =_this select 1;
					if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = true;
				};}];
				(findDisplay 46) displayAddEventHandler ["KeyUp"  , {
					private ["_key"];
					_key =_this select 1;
					if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = false;
				};}];
			};

			// Show list of vehicle crew
			if (wmt_param_VehicleCrew==0) then {
				(findDisplay 46) displayAddEventHandler ["MouseZChanged","_this call WMT_fnc_KeyHandlerShowCrew;"];
			};
		};

		[] call WMT_fnc_UpdateVehicleActions;
		player addEventHandler ["Respawn", {[] call WMT_fnc_UpdateVehicleActions;}];
	};
};
