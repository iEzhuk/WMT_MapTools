/*
    Name:
        WMT_fnc_BriefingTimer

    Author(s):
        Zealot, Ezhuk

    Description:
        Add timer in briefing on top panel.
        Disable posability to sart mission by key.

    Parameters:
        Nothing

    Returns:
        Nothing
*/

if (!hasInterface) exitwith {};
private["_display", "_ctrl", "_timeStart", "_eh"];

disableSerialization;
uisleep 1.;

_display = uinamespace getVariable ["RscDiary",displaynull];
if (isnull _display) exitwith {};
_ctrl = _display ctrlCreate ["RscText", -1];
_ctrl ctrlSetPosition [0.5, safezoneY, 0.15, 0.05];
_ctrl ctrlSetText "00:00";
_ctrl ctrlSetTextColor [0.75, 0.75, 0.75, 1];
_ctrl ctrlCommit 0;

_ctrl2 = _display ctrlCreate ["RscStructuredText", -1];
_ctrl2 ctrlSetPosition [0.67, safezoneY, 0.15, 0.05];
_ctrl2 ctrlSetStructuredText parseText format[ ""];
_ctrl2 ctrlCommit 0;

_timeStart = diag_ticktime;
_eh = _display displayAddEventHandler ["keyDown", "(_this select 1) in [28,57,156];"];

while {time < 30 || missionNamespace getVariable["WMT_pub_frzState",100] < 3} do {
    _s1 = [diag_ticktime - _timeStart, "MM:SS"] call BIS_fnc_secondsToString;
    _ctrl ctrlSetText _s1;
    _ctrl ctrlCommit 0;


	_bluforPlayers=  { side _x == west && isPlayer _x} count playableUnits;
	_opforPlayers= { side _x == east && isPlayer _x} count playableUnits;
	_resPlayers = { side _x == resistance && isPlayer _x} count playableUnits;
	_civPlayers = { side _x == civilian && isPlayer _x} count playableUnits;
	_s2="";
	if(_bluforPlayers>0) then{_s2=_s2+format["<t color='#004d99' align='left' size='1.3'>%1</t> ",_bluforPlayers];};
	if(_opforPlayers>0) then{_s2=_s2+format["<t color='#7f0000' align='left' size='1.3'>%1</t> ",_opforPlayers];};
	if(_resPlayers>0) then{_s2=_s2+format["<t color='#007f00' align='left' size='1.3'>%1</t> ",_resPlayers];};
	if(_civPlayers>0) then{_s2=_s2+format["<t color='#66007f' align='left' size='1.3'>%1</t> ",_civPlayers];};
	
	_ctrl2 ctrlSetStructuredText parseText _s2;
	_ctrl2 ctrlCommit 0;
    uisleep 0.1;
};

ctrlDelete _ctrl;
ctrlDelete _ctrl2;
_display displayRemoveEventHandler ["keyDown",_eh];
