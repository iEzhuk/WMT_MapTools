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

			PR(_getCountUnits) = {
				private ["_sideUnits", "_units", "_marker", "_trigger", "_minZ", "_maxZ"];
				_trigger  = _this select 0;
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
				}forEach (list _trigger);

				_sideUnits
			};

			PR(_logic) = _this select 0;
			PR(_units) = _this select 1;
			PR(_delay) = _this select 2;

			PR(_marker) 	= _logic getVariable "Marker";
			PR(_owner)		= [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Owner");
			PR(_message)	= _logic getVariable "Message";
			PR(_defCount)	= _logic getVariable "DefCount";
			PR(_lock)		= _logic getVariable "Lock";
			PR(_minHeight)	= _logic getVariable "MinHeight";
			PR(_maxHeight)	= _logic getVariable "MaxHeight";
			PR(_autoLose) 	= _logic getVariable "AutoLose";
			PR(_captureCount) = _logic getVariable "CaptureCount";
			PR(_easyCapture)  = _logic getVariable "EasyCapture";

			// Init point
			PR(_trg) = [_marker] call _func_create_trigger;

			// Marker settings 
			_marker setMarkerColor (_owner call _func_sideToColor);
			_marker setMarkerBrush "SolidBorder";

			// Set variable
			_logic setVariable ["WMT_PointOwner", _owner];

			sleep _delay;

			PR(_objs)   = _units;
			PR(_locked) = false;

			while {!_locked} do {
				PR(_unitCount) = [_trg, _minHeight, _maxHeight] call _getCountUnits;
				PR(_curOwner)  = _logic getVariable "WMT_PointOwner";

				PR(_dc) = _unitCount select ([WEST, EAST, RESISTANCE, CIVILIAN, sideLogic] find _curOwner);
				PR(_cs) = sideLogic;
				PR(_cc) = 0;

				{
					if(_curOwner != _x) then {
						if(_cc < _unitCount select _foreachindex) then {
							_cc = _unitCount select _foreachindex;
							_cs = _x;
						};
					};
				} foreach [WEST, EAST, RESISTANCE, CIVILIAN];

				PR(_captured) = false;
				if (_dc < _defCount) then {
					if (_cs >= _captureCount) then {
						// Standart
						_captured = true;
					};
				} else {
					if (_dc==0) then {
						if (_easyCapture==1 && _cc > 0) then {
							// Easy capture
							_captured = true;
						} else {
							if (_autoLose != -1) then {
								// Auto lose
								_cs = [east,west,resistance,civilian,sideLogic] select _autoLose;
								_captured = true;
							};
						};
					};
				};

				if (_captured) then {
					_logic setVariable ["WMT_PointOwner", _cs];
					_marker setMarkerColor (_cs call _func_sideToColor);

					if(_message != "") then {
						WMT_Global_Notice_ZoneCaptured = [_cs, _logic];
						publicVariable "WMT_Global_Notice_ZoneCaptured";

						[_cs, _message] call WMT_fnc_ShowTaskNotification;
					};

					if(_lock == 1) then {
						_locked = true;
					};
				};

				sleep 4.12;
			};
			deleteVehicle  _trg; 
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