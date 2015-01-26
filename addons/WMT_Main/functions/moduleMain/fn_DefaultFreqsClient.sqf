/*
 	Name: WMT_fnc_DefaultFreqsClient
 	
 	Author(s):
		Zealot

 	Description:
		Show frequences
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/

#define PR(x) private ['x']; x

if (not isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) exitwith {diag_log "DefaultFreqClient TF radio not initialized"};

PR(_sideToColor) = {
	switch(_this select 0) do {
		case WEST:{"#288cf0"};
		case EAST:{"#cd2e2e"};
		case RESISTANCE:{"#2bed2b"};
		default{"#ececec"};
	};
};

private ['_lr_settings','_sw_settings','_txt1'];

PR(_friends) = ([side player] call BIS_fnc_friendlySides) - [civilian];
PR(_friendsids) = [];
PR(_playersideid) = [playerside] call BIS_fnc_sideID;
PR(_txt) = "";

waitUntil {!isNil {(group player) getVariable "tf_lr_frequency"}};
_lr_settings = ((group player) getVariable "tf_lr_frequency") select 2;
_txt = "<font>" + format[localize "STR_WMT_FREQ_LR",_lr_settings select 0, _lr_settings select 1, _lr_settings select 2 ] + "</font><br/><br/>";

{
	if (side _x in _friends) then {
		waitUntil {!isNil {_x getVariable "tf_sw_frequency"}};
		_sw_settings = (_x getVariable "tf_sw_frequency") select 2;
		PR(_leader) = leader _x;
		PR(_tcolor) = [side _x] call _sideToColor;
		_txt1 = format["<font color='%3'>%1 %2</font><br/>", (groupid(_x)) call wmt_fnc_LongGroupNameToShort, if(isPLayer _leader)then{name _leader}else {""}, _tcolor ];
		_txt = _txt + _txt1 + format[localize "STR_WMT_FREQ_SR", _sw_settings select 0,_sw_settings select 1,_sw_settings select 2] + "<br/><br/>";
	};
} foreach allGroups;

["diary",localize "STR_WMT_FREQ_HDR", _txt] call WMT_fnc_CreateDiaryRecord;
