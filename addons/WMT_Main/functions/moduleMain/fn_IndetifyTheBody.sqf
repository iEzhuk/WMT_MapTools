/*
 	Name: WMT_fnc_IndetifyTheBody
 	
 	Author(s):
		Ezhuk

 	Description:
		Show name of player in center of the screen
*/

#include "defines_IDC.sqf"

disableSerialization;

private ["_unit","_name","_ctrl","_display"];
_unit = cursortarget;
_name = _unit getvariable ["PlayerName", localize "STR_WMT_Unknow"];

cutRsc ["RscWMTDogTag","PLAIN"];
_display = (uiNamespace getVariable 'RscWMTDogTag');
_ctrl = _display displayCtrl IDC_WMT_DOGTAGTEXT;
_ctrl ctrlSetText  _name;
_ctrl  ctrlCommit 0;

["CALL","BodyIdentified",[_unit, _name]] call wmt_fnc_evh;

