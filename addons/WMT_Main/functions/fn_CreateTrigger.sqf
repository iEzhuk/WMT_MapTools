
private ["_pos","_isrectangle","_dir","_size","_tb","_timeout","_by","_type","_condition","_activation","_deactivation","_vehicle"];	
_tb = [_this, 0, false ] call BIS_fnc_param;
_timeout = [_this, 1, 3 ] call BIS_fnc_param;
/* Side': "EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY"
* Radio: "ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLF", "HOTEL", "INDIA", "JULIET"
* Object: "STATIC", "VEHICLE", "GROUP", "LEADER", "MEMBER"
* Status: "WEST SEIZED", "EAST SEIZED" or "GUER SEIZED" */
_by = [_this, 2, "ANY" ] call BIS_fnc_param;
/* Presence: "PRESENT", "NOT PRESENT"
Detection: "WEST D", "EAST D", "GUER D" or "CIV D" */
_type = [_this, 3, "PRESENT" ] call BIS_fnc_param;
_condition = [_this, 4, "this" ] call BIS_fnc_param;
_activation = [_this, 5, "" ] call BIS_fnc_param;
_deactivation = [_this, 6, "" ] call BIS_fnc_param;
_text = [_this, 7, "" ] call BIS_fnc_param;
_pos = [_this, 8, [0,0]] call BIS_fnc_param;
_isrectangle = [_this, 9, true] call BIS_fnc_param;
_dir = [_this, 10, 0] call BIS_fnc_param;
_size = [_this, 11, [50,50] ] call BIS_fnc_param;
_vehicle = [_this, 12, objNull ] call BIS_fnc_param;
_trg=createTrigger["EmptyDetector",_pos];
_trg setTriggerArea[_size select 0,_size select 1,_dir,_isrectangle];
_trg setTriggerActivation[_by,_type,_tb];
_trg setTriggerTimeout [_timeout, _timeout, _timeout, true ];
_trg setTriggerText _text;
if (_condition != "" ) then {	
	_trg setTriggerStatements[_condition,_activation,_deactivation];
};
if (not isNull(_vehicle) ) then {
	_trg triggerAttachVehicle [_vehicle];
};
_trg;

