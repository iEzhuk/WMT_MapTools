/*
	Name: WMT_fnc_IndetifyTheBody

	Author(s):
		Ezhuk

	Description:
		Show name of player in center of the screen
*/

#include "defines_IDC.sqf"

disableSerialization;

private ["_unit","_name","_ctrl","_display","_pic"];
_unit = cursortarget;
_name = _unit getvariable ["PlayerName", localize "STR_WMT_Unknow"];

cutRsc ["RscWMTDogTag","PLAIN"];
_display = (uiNamespace getVariable 'RscWMTDogTag');

// Set text
_ctrl = _display displayCtrl IDC_WMT_DOGTAGTEXT;
_ctrl ctrlSetText  _name;
_ctrl ctrlCommit 0;

// Set image
_pic = _unit getVariable ["DogtagPic", -1];
if( _pic < 0) then {
	_pic = floor random 7.99;
	_pic = _pic - 3;
	_pic = 0 max _pic;
	// P(0) = 3/8
	// P(1...5) = 1/5
	_unit setVariable ["DogtagPic", _pic];
};

_ctrl = _display displayCtrl IDC_WMT_DOGTAGPIC;
_ctrl ctrlSetText format ["\wmt_main\pic\dogtag%1.paa",_pic];
_ctrl ctrlCommit 0;
