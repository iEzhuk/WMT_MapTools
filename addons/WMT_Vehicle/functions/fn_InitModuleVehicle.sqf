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

	WMT_Local_hardFieldRepairParts 	= ["HitEngine", "HitLTrack","HitRTrack"];
	WMT_Local_fieldRepairHps 		= ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel"] + WMT_Local_hardFieldRepairParts;
	
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
			_ammoCargo = getAmmoCargo _x;
			if (!isNil "_ammoCargo") then {
				if (_ammoCargo > 0 and _ammoCargo < 2) then {
					wmt_ammoCargoVehs set [count wmt_ammoCargoVehs, _x];
					_x setAmmoCargo 0;
					_x setVariable ["wmt_ammo_cargo", 1, true]; 
				};	
			};
		} foreach vehicles;

	};

	//===============================================================
	// 						Client part 
	//===============================================================
	if (!isDedicated) then {
		waitUntil {player == player};

		private ["_playerClass"];
		_playerClass = toLower (typeof player);

		// Reapir
		if (wmt_param_FullRepair==0) then {
			private ["_enable"];
			WMT_Local_fullRepairClasses 	= [];
			WMT_Local_fullRepairEnabled 	= false;

			_enable = 	switch (true) do {
							case (["engineer", _playerClass] call BIS_fnc_inString):{true};
							case (["crew" 	 , _playerClass] call BIS_fnc_inString):{true};
							case (["pilot"	 , _playerClass] call BIS_fnc_inString):{true};
							case (["uav"	 , _playerClass] call BIS_fnc_inString):{true};
							case (["repair"	 , _playerClass] call BIS_fnc_inString):{true};
							default {false};
						};

			if(_enable) then {
				/*WMT_Local_fullRepairClasses = ["Car","Tank","Ship","Air"];*/
				WMT_Local_fullRepairEnabled = true; 
			};
		};
		
		// Rearm system
		if (wmt_param_Reammo==0) then {
			WMT_Local_ReammoEnable = 	switch (true) do {
									case (["engineer", _playerClass] call BIS_fnc_inString):{true};
									case (["crew" 	 , _playerClass] call BIS_fnc_inString):{true};
									case (["pilot"	 , _playerClass] call BIS_fnc_inString):{true};
									case (["uav"	 , _playerClass] call BIS_fnc_inString):{true};
									case (["repair"	 , _playerClass] call BIS_fnc_inString):{true};
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
