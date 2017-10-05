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

if (playerside == civilian) exitwith {};

waitUntil {uisleep 1; !isNil "wmt_global_freqList" or time > 30};

if(isNil "wmt_global_freqList" ) exitwith {diag_log "WMT_fnc_DefaultFreqsClient: wmt_global_freqList is null"};

PR(_sideToColor) = {
    switch(_this select 0) do {
//start redesigned by MODUL
        case WEST:{"#5ba2ea"};
        case EAST:{"#eb5858"};
        case RESISTANCE:{"#95ef59"};
		default{"#ececec"};
//end
    };
};

PR(_printFrq) = {
    PR(_str) = _this;
    PR(_txt) = "";
    PR(_arrFrq) = _str select 1;

    switch ( typename (_str select 0)) do {
        case ("SIDE") : {
//start redesigned by MODUL
            _txt = "<font size='18' color='#e4c844'>" + format[localize "STR_WMT_FREQ_LR",_arrFrq select 0, _arrFrq select 1,_arrFrq select 2] + "</font><br/><br/>";
//end
         };
        case ("GROUP") : {
            PR(_leader) = leader (_str select 0);
            PR(_tcolor) = [side (_str select 0)] call _sideToColor;
//start author unknown
			if (_leader == leader player) then { 
				_tcolor = "#eaac49";
//end author unknown
			};
//start redesigned by MODUL
            _txt = format["<font size='14' color='%3'>%1  %2</font><br/>", (groupid(_str select 0)) call wmt_fnc_LongGroupNameToShort, if(isPLayer _leader)then{name _leader}else {""}, _tcolor ];
            _txt = _txt + "<font size='14'>            " + format[localize "STR_WMT_FREQ_SR", _arrFrq select 0,_arrFrq select 1,_arrFrq select 2] + "</font><br/>";
//end
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
    if ( typename (_x select 0) == typename grpNull and {side (_x select 0) in _friends} and { leader (_x select 0) in allUnits} ) then {
        _txt = _txt + (_x call _printFrq);
    };
} foreach wmt_global_freqList;


["diary",localize "STR_WMT_FREQ_HDR", _txt] call WMT_fnc_CreateDiaryRecord;
