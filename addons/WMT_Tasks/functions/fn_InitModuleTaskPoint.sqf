/*
 	Name: WMT_fnc_InitModuleTaskPoint
 	
 	Author(s):
		Ezhuk
*/
#include "defines.sqf"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

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

			PR(_func_create_trigger) = {
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

			PR(_func_sideToColor) = {
				switch (_this) do 
				{
					case WEST:		{"ColorBlufor"};
					case EAST:		{"ColorOpfor"};
					case RESISTANCE:{"ColorIndependent"};
					case CIVILIAN:	{"ColorCivilian"};
					default 		{"ColorBlack"}
				};
			};

			PR(_getUnitList) = {
				PR(_arrTrg) = _this select 0;
				PR(_unitList) = [];

				if(count _arrTrg > 0) then {
					// Add units from first trigger in list 
					_unitList = list (_arrTrg select 0);

					for "_i" from 1 to ((count _arrTrg)-1) do {
						PR(_lst) = list (_arrTrg select _i);

						for "_k" from 0 to ((count _lst)-1) do {
							PR(_unit) = _lst select _k;
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

			PR(_getCountUnits) = {
				private ["_sideUnits", "_units", "_marker", "_arrTrg", "_minZ", "_maxZ"];
				_arrTrg  = _this select 0;
				_minZ = _this select 1;
				_maxZ = _this select 2;
				_sideUnits = [0,0,0,0,0];

				{
					private ["_side", "_unit", "_id"];
					_unit = _x;
					_pos  = getPos _unit;

					if(_pos select 2 > _minZ && _pos select 2 < _maxZ) then {
						_side = side _unit;
						_id = [WEST, EAST, RESISTANCE, CIVILIAN] find _side;

						if(_id != -1 ) then {
							_sideUnits set [_id, (_sideUnits select 0) + ({isPlayer _x && alive _x} count (crew _unit))];
						};
					};
				}forEach ([_arrTrg] call _getUnitList);

				_sideUnits
			};

			PR(_logic) = _this select 0;
			PR(_units) = _this select 1;
			PR(_delay) = _this select 2;

			PR(_markerStr) 	= _logic getVariable "Marker";
			PR(_owner)		= [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Owner");
			PR(_message)	= _logic getVariable "Message";
			PR(_defCount)	= _logic getVariable "DefCount";
			PR(_lock)		= _logic getVariable "Lock";
			PR(_minHeight)	= _logic getVariable "MinHeight";
			PR(_maxHeight)	= _logic getVariable "MaxHeight";
			PR(_autoLose) 	= _logic getVariable "AutoLose";
			PR(_timer) 		= _logic getVariable ["Timer",0];
			PR(_captureCount) = _logic getVariable "CaptureCount";
			PR(_easyCapture)  = _logic getVariable "EasyCapture";

			// Remove spaces 
			_markerStr = toString ((toArray _markerStr) - [32]);

			PR(_arrMarkers) = [_markerStr,","] call Bis_fnc_splitString;
			PR(_arrTrgs)	= [];
			PR(_brush) 		= if(count _arrMarkers == 1)then{"SolidBorder"}else{"Solid"};

			// Init point
			for "_i" from 0 to ((count _arrMarkers)-1) do {
				PR(_marker) = _arrMarkers select _i;

				_marker setMarkerColor (_owner call _func_sideToColor);
				_marker setMarkerBrush _brush;

				_arrTrgs set [count _arrTrgs, ([_marker] call _func_create_trigger)];
			};

			// Set variable
			_logic setVariable ["WMT_PointOwner", _owner];

			sleep _delay;

			PR(_objs)   = _units;
			PR(_locked) = false;
			PR(_timeB)  = -1;
			PR(_typeB)	= 0;

			while {!_locked} do {
				PR(_unitCount) = [_arrTrgs, _minHeight, _maxHeight] call _getCountUnits;
				PR(_curOwner)  = _logic getVariable "WMT_PointOwner";

				PR(_dc) = _unitCount select ([WEST, EAST, RESISTANCE, CIVILIAN, sideLogic] find _curOwner);
				PR(_cs) = sideLogic;
				PR(_cc) = 0;

				// Calculate units and detect side that have more units in zone
				{
					if(_curOwner != _x) then {
						if(_cc < _unitCount select _foreachindex) then {
							_cc = _unitCount select _foreachindex;
							_cs = _x;
						};
					};
				} foreach [WEST, EAST, RESISTANCE, CIVILIAN];

				PR(_captured) = 0;

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
						_cs = [east,west,resistance,civilian,sideLogic] select _autoLose;
						if(_cs != _curOwner) then {
							_captured = 3;
						};
					};
				};

				if (_captured > 0) then {
					if (_typeB!= _captured) then {
						// Timecount
						_timeB = diag_tickTime;
						_typeB = _captured;
					};

					if (diag_tickTime - _timeB >= _timer) then {
						// Capture the zone
						_logic setVariable ["WMT_PointOwner", _cs];
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