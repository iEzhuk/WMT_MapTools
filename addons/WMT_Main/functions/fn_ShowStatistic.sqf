/*
 	Name: WMT_fnc_ShowStatistic
 	
 	Author(s):
		Ezhuk

 	Description:
		show statistic of kills
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/
#include "defines.sqf"

if(wmt_param_DisableStat)exitWith{};

PR(_text) = "";
_text = _text + format ["<t color='#c7861b'>%1</t>:<br/>",localize "STR_Killer"];

if(count WMT_Local_Killer > 0) then {
	PR(_killerName) = WMT_Local_Killer select 0;
	PR(_killerSide) = WMT_Local_Killer select 1;

	if(_killerName != WMT_Local_PlayerName) then {
		_text = _text + _killerName;
		if(_killerSide == WMT_Local_PlayerSide) then {
			_text = _text + format [" (%1)", localize "STR_WMT_Ally"];
		};
	} else {
		_text = _text + format ["%1", localize "STR_WMT_Suicide"];
	};
} else {
	_text = _text + format ["%1", localize "STR_WMT_Unknow"];
};

_text = _text + "<br/>";

{
	if(_x select 2 == 1 ) then { 
		if(Local_PlayerSide == _x select 1) then {
			_text = _text + format ["+ %1 <t color='#c7861b'>(%2)</t><br/>", _x select 0, localize "STR_WMT_TEAMMATE"];
		}else{
			_text = _text + format ["+ %1<br/>", _x select 0];
		};
	}else{
		if(Local_PlayerSide == _x select 1) then {
			_text = _text + format ["%1 <t color='#c7861b'>(%2)</t><br/>", _x select 0, localize "STR_WMT_TEAMMATE"];
		}else{
			_text = _text + format ["%1<br/>", _x select 0];
		};
	};
} foreach Local_Kills;

[ (format [ "<t size='0.6'>%1</t>",_text]), 0,0.3,10,0,0,35] spawn bis_fnc_dynamicText;