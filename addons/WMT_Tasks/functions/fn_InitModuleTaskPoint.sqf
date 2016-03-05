/*
	 Name: WMT_fnc_InitModuleTaskPoint

	 Author(s):
		Ezhuk
*/

#include "defines.sqf"

private _logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
private _units = [_this,1,[],[[]]] call BIS_fnc_param;
private _activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	//===============================================================
	// 							Server part
	//===============================================================
	if(isServer) then {
		if(isNil "WMT_Local_PointArray") then {
			WMT_Local_PointArray = [];
		};
		WMT_Local_PointArray set [count WMT_Local_PointArray, _logic];

		[_logic, _units, DELAY] spawn {
			private ["_func_create_trigger", "_func_sideToColor", "_getUnitList"];
			_func_create_trigger = {
				private ["_trigger","_marker","_markerPos","_markerDir"];
				_marker = _this select 0;
				_markerPos = markerPos _marker;
				_markerDir = markerDir _marker;
				_markerSize = markerSize _marker;
				_isRectangle = (markerShape _marker) == "RECTANGLE";

				_trigger = createTrigger ["EmptyDetector", [_markerPos select 0,_markerPos select 1] ];
				_trigger setTriggerArea  [_markerSize select 0,_markerSize select 1,_markerDir,_isRectangle];
				_trigger setTriggerActivation["ANY","PRESENT",true];
				_trigger setTriggerStatements ["this", "", ""];
				_trigger
			};

			_func_sideToColor = {
				switch (_this) do
				{
					case WEST:		{"ColorBlufor"};
					case EAST:		{"ColorOpfor"};
					case RESISTANCE:{"ColorIndependent"};
					case CIVILIAN:	{"ColorCivilian"};
					default 		{"ColorBlack"}
				};
			};

			_getUnitList = {
				params ["_arrTrg"];
				private ["_unitList", "_lst", "_unit"];
				private _unitList = [];

				if (count _arrTrg > 0) then {
					// Add units from first trigger in list
					_unitList = list (_arrTrg select 0);
					for "_i" from 1 to ((count _arrTrg)-1) do {
						_lst = list (_arrTrg select _i);
						for "_k" from 0 to ((count _lst)-1) do {
							_unit = _lst select _k;
							// Checking the  double detection
							if !(_unit in _unitList) then {
								// Push in unit list
								_unitList = _unitList + [_unit];
							};
						};
					};
				};
				_unitList
			};

			_getCountUnits = {
				private ["_sideUnits", "_units", "_marker"];
				params ["_arrTrg", "_minZ", "_maxZ"];

				_sideUnits = [0,0,0,0,0];
				{
					private ["_side", "_unit", "_id"];
					_unit = _x;
					_pos  = if(surfaceIsWater getPos _unit)then{getPosASL _unit}else{getPosATL _unit};

					if(_pos select 2 > _minZ && _pos select 2 < _maxZ) then {
						_side = side _unit;
						_id = [west, east, resistance, civilian] find _side;

						if(_id != -1 ) then {
							_sideUnits set [_id, (_sideUnits select _id) + ({isPlayer _x && alive _x} count (crew _unit))];
						};
					};
				}forEach ([_arrTrg] call _getUnitList);

				_sideUnits
			};

			params ["_logic", "_units", "_delay"];

			private _markerStr 	  = _logic getVariable "Marker";
			private _owner		  = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Owner");
			private _message	  = _logic getVariable "Message";
			private _defCount	  = _logic getVariable "DefCount";
			private _lock		  = _logic getVariable "Lock";
			private _minHeight	  = _logic getVariable "MinHeight";
			private _maxHeight	  = _logic getVariable "MaxHeight";
			private _autoLose 	  = _logic getVariable "AutoLose";
			private _timer 		  = _logic getVariable ["Timer",0];
			private _captureCount = _logic getVariable "CaptureCount";
			private _easyCapture  = _logic getVariable "EasyCapture";

			private _condition = compile (_logic getVariable ["Condition","true"]);

			// Remove spaces
			_markerStr = toString ((toArray _markerStr) - [32]);

			private _arrMarkers = [_markerStr,","] call Bis_fnc_splitString;
			private _arrTrgs	= [];
			private _brush 		= if(count _arrMarkers == 1)then{"SolidBorder"}else{"Solid"};

			// Init point
			for "_i" from 0 to ((count _arrMarkers)-1) do {
				private _marker = _arrMarkers select _i;

				_marker setMarkerColor (_owner call _func_sideToColor);
				_marker setMarkerBrush _brush;

				_arrTrgs set [count _arrTrgs, ([_marker] call _func_create_trigger)];
			};

			// Set variable
			_logic setVariable ["WMT_PointOwner", _owner, true];

			sleep _delay;

			private _objs   = _units;
			private _locked = false;
			private _timeB  = -1;
			private _typeB	= 0;

			while {!_locked} do {
				private _unitCount = [_arrTrgs, _minHeight, _maxHeight] call _getCountUnits;
				private _curOwner  = _logic getVariable "WMT_PointOwner";

				private _dc = _unitCount select ([west, east, resistance, civilian, sideLogic] find _curOwner);
				private _cs = sideLogic;
				private _cc = 0;

				// Calculate units and detect side that have more units in zone
				{
					if (_curOwner != _x) then {
						if (_cc < _unitCount select _foreachindex) then {
							_cc = _unitCount select _foreachindex;
							_cs = _x;
						};
					};
				} foreach [west, east, resistance];

				private _captured = 0;

				//Checking conditions
				switch (true) do {
					// Standart
					case (_dc < _defCount && _cc >= _captureCount) : {
						_captured = 1;
					};
					// Easy capture
					case (_dc==0 && _easyCapture==1 && _cc > 0) : {
						_captured = 2;
					};
					// Auto lose
					case (_dc==0 && _autoLose != -1) : {
						_cs = [west, east, resistance, civilian, sideLogic] select _autoLose;
						if(_cs != _curOwner) then {
							_captured = 3;
						};
					};
				};

				if ((_captured>0) && (call _condition)) then {
					if (_typeB!= _captured) then {
						// Timecount
						_timeB = diag_tickTime;
						_typeB = _captured;
					};

					if (diag_tickTime - _timeB >= _timer) then {
						// Capture the zone
						_logic setVariable ["WMT_PointOwner", _cs, true];
						{_x setMarkerColor (_cs call _func_sideToColor)} forEach _arrMarkers;

						if(_message != "") then {
							WMT_Global_Notice_ZoneCaptured = [_cs, _logic];
							publicVariable "WMT_Global_Notice_ZoneCaptured";

							[_cs, _message] call WMT_fnc_ShowTaskNotification;
						};

						if(_lock == 1) then {
							_locked = true;
						};
					};
				} else {
					// Stop timecount
					_timeB = -1;
					_typeB = 0;
				};

				sleep 3.12;
			};

			//Remove trigers
			{deleteVehicle  _x} foreach _arrTrgs;

			_logic setVariable ["WMT_TaskEnd", true, true];
		};
	};
	//===============================================================
	// 							Client part
	//===============================================================
	if(!isDedicated) then {
		if(isNil "WMT_ClientInit_Point") then {
			WMT_ClientInit_Point = true;
			"WMT_Global_Notice_ZoneCaptured" addPublicVariableEventHandler {
				if(count (_this select 1) == 2) then {
					private ["_side", "_logic", "_msg"];

					_side  = (_this select 1) select 0;
					_logic = (_this select 1) select 1;

					_msg = _logic getVariable "Message";

					[_side, _msg] call WMT_fnc_ShowTaskNotification;
				};
			};
		};
	};
};
