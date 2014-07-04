// by Zealot
#include "defines.sqf"

if (not isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) exitwith {diag_log "DefaultFreqServer TF radio not initialized"};
DBGMSG("S1")

tf_same_sw_frequencies_for_side = false;
tf_same_lr_frequencies_for_side = true;		

PR(_radio) = [-2,2,32,64,100,400];
PR(_genFreq) = {
	private ["_state","_num","_isinbl","_l1","_l2"];
	PR(_state) = _this select 0; 
	if (isNil "wmt_frqBlackList") then {
		wmt_frqBlackList = [0];
	};

	_num = 0;
	_l1 = _radio select 0;
	_l2 = _radio select 1;
	_isinbl = true;
	if (_state == 0) then {
		_l1 = _radio select 2; _l2 = _radio select 3;
	};
	if (_state == 1) then {
		_l1 = _radio select 4; _l2 = _radio select 5;
	};

	while {_isinbl} do {
		_num = round (([_l1,_l2] call bis_fnc_randomnum) * 10) / 10 ;
		if not (_num in wmt_frqBlackList) then {
			 wmt_frqBlackList set [count wmt_frqBlackList, _num ];
			_isinbl = false;
		};
	};
	_num;
};


PR(_genFreqArray) = {
	[_this call _genFreq, _this call _genFreq, _this call _genFreq];
};

PR(_freqList) = [];

DBGMSG("S2")

{
	_num = 0;
	switch true do {
		case (_x == resistance and ([west, resistance] call BIS_fnc_areFriendly) ) : {
			_num = (_freqList select 1) select 1;
		};
		case (_x == resistance and ([east, resistance] call BIS_fnc_areFriendly) ) : {
			_num = (_freqList select 0) select 1;
		};
		default {
			_num = [0] call _genFreqArray ;
		};	
	};
	_data = [_x, _num]; 
	
	_freqList set [count _freqList,  _data];
} foreach [east, west, resistance];

DBGMSG("S3")



//waitUntil { not isNil "TF_server_addon_version" or time > 10};

DBGMSG("S3.5")

/*if (isNil "TF_MAX_CHANNELS") then {
	call compile preprocessFileLineNumbers "\task_force_radio\common.sqf";
};*/


[] spawn {
	
	waitUntil{not isNil "TF_MAX_CHANNELS"};
	DBGMSG("TF INIT");

};

call TFAR_fnc_processGroupFrequencySettings;

DBGMSG("S5")

{
	_num = [1] call _genFreqArray ;
	_freqList set [count _freqList, [_x, _num] ];				
	_vl3 = _x getVariable "tf_sw_frequency"; 			
	(_vl3 select 2) set [0, str (_num select 0)];
	_x setVariable["tf_sw_frequency", _vl3, true];
} foreach allgroups;

wmt_global_freqList = _freqList;
publicVariable "wmt_global_freqList";

DBGMSG("S6")
