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
if (not isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) exitwith {diag_log "DefaultFreqClient TF radio not initialized"};

if (playerside == civilian) exitwith {};

waitUntil {uisleep 1; !isNil "wmt_global_freqList" or time > 30};

if(isNil "wmt_global_freqList" ) exitwith {diag_log "WMT_fnc_DefaultFreqsClient: wmt_global_freqList is null"};

private _sideToColor = {
	switch(_this select 0) do {
		case WEST:{"#288cf0"};
		case EAST:{"#cd2e2e"};
		case RESISTANCE:{"#2bed2b"};
		default{"#ececec"};
	};
};

private _printFrq = {
	private _str = _this;
	private _txt = "";
	private _arrFrq = _str select 1;

	switch ( typename (_str select 0)) do {
		case ("SIDE") : {
			_txt = "<font>" + format[localize "STR_WMT_FREQ_LR",_arrFrq select 0, _arrFrq select 1,_arrFrq select 2] + "</font><br/><br/>";
		 };
		case ("GROUP") : {
			private _leader = leader (_str select 0);
			private _tcolor = [side (_str select 0)] call _sideToColor;
			if (_leader == leader player) then { 
				_tcolor = "#c7861b";
			};
			_txt = format["<font color='%3'>%1 %2</font><br/>", (groupid(_str select 0)) call wmt_fnc_LongGroupNameToShort, if(isPLayer _leader)then{name _leader}else {""}, _tcolor ];
			_txt = _txt + format[localize "STR_WMT_FREQ_SR", _arrFrq select 0,_arrFrq select 1,_arrFrq select 2];
		};
	};
	_txt;
};


private _friends = ([side player] call BIS_fnc_friendlySides) - [civilian];
private _friendsids = [];
private _playersideid = [playerside] call BIS_fnc_sideID;
private _txt = (wmt_global_freqList select _playersideid) call _printFrq;
private _groupFreq  = "";

{
	if ( typename (_x select 0) == typename grpNull and {side (_x select 0) in _friends} and { leader (_x select 0) in allUnits} ) then {
		_txt = _txt + (_x call _printFrq) + "<br/><br/>";
	};
} foreach wmt_global_freqList;


["diary", localize "STR_WMT_FREQ_HDR", _txt] call WMT_fnc_CreateDiaryRecord;
