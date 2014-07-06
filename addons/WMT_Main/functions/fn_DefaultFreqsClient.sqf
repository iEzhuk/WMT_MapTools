// by Zealot

#include "defines.sqf"

if (not isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) exitwith {diag_log "DefaultFreqClient TF radio not initialized"};


tf_same_sw_frequencies_for_side = false;
tf_same_lr_frequencies_for_side = true;	

if (playerside == civilian) exitwith {};
DBGMSG("TestTest2.5");
waitUntil {!isNil "wmt_global_freqList" or time > 10};
DBGMSG("TestTest2");

PR(_sideToColor) = {
	switch(_this select 0) do {
		case WEST:{"#288cf0"};
		case EAST:{"#cd2e2e"};
		case RESISTANCE:{"#2bed2b"};
		default{"#ececec"};
	};
};

PR(_spawnSetLrChannel) = {
	if (leader group player == player) then {
		_this spawn {					
				waituntil {sleep 0.3;(player call TFAR_fnc_haveLRRadio) or time > 10};
				sleep 0.5;
				_val = str (_this);					
				[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, _val] call TFAR_fnc_setLrFrequency;
				if (dialog) then {
					call TFAR_fnc_updateLRDialogToChannel;
				};
				
		};
	};
};

PR(_printFrq) = {
	PR(_str) = _this;
	PR(_txt) = "";
	PR(_arrFrq) = _str select 1;

	switch ( typename (_str select 0)) do {
		case ( typename east) : {
			_txt = "<font>" + format[localize "STR_WMT_FREQ_LR",_arrFrq select 0, _arrFrq select 1,_arrFrq select 2] + "</font><br/>";
		 };
		case ( typename grpnull) : {
			PR(_leader) = leader (_str select 0);
			PR(_tcolor) = [side (_str select 0)] call _sideToColor;
			_txt = format["<font color='%3'>%1 %2</font><br/>", (groupid(_str select 0)) call wmt_fnc_LongGroupNameToShort, if(isPLayer _leader)then{name _leader}else {""}, _tcolor ];
			_txt = _txt + format[localize "STR_WMT_FREQ_SR", _arrFrq select 0,_arrFrq select 1,_arrFrq select 2] +
				"<br/>";
		};
	};
	_txt;
};


PR(_friends) = ([side player] call BIS_fnc_friendlySides) - [civilian];
PR(_friendsids) = [];
PR(_playersideid) = [playerside] call BIS_fnc_sideID;
PR(_txt) = "";

_txt = (wmt_global_freqList select _playersideid) call _printFrq;

{
//if ( typename (_x select 0) == typename grpNull and {side (_x select 0) in _friends} and { leader (_x select 0) in playableunits} ) then {		
	if ( typename (_x select 0) == typename grpNull and {side (_x select 0) in _friends} and { leader (_x select 0) in allUnits} ) then {		
		_txt = _txt + (_x call _printFrq);
	};
} foreach wmt_global_freqList;


(((wmt_global_freqList select _playersideid) select 1) select 0) call _spawnSetLrChannel;


["diary",localize "STR_WMT_FREQ_HDR", _txt] call WMT_fnc_CreateDiaryRecord;
