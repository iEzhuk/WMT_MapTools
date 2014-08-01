 /*
 	Name: WMT_fnc_ProgressBar
 	
 	Author(s):
		Ezhuk

 	Description:
		Show progress bar in bottom part of center  

	Parameters:
		BOOL 
	or 
		VARIABLE 

 	Returns:
		Nothing
*/


#include "defines.sqf"

disableSerialization;

PR(_display) = uiNamespace getVariable "wMT_Disaply_ProgressBar";

if(isNil "_display")exitWith{};

PR(_ctrlBG) = _display displayCtrl 5100; 
PR(_ctrlPR) = _display displayCtrl 5101; 

PR(_pBG) = [0,0,0,0];
PR(_pPR) = [0,0,0,0];

switch (typeName (_this select 0)) do {
	case "BOOL" : {
		PR(_show) = _this select 0;
		if(_show) then {
			_pBG = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.30*safezoneW,	0.02*safezoneH];
			_pPR = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.00*safezoneW,	0.00*safezoneH];
		}else{
			_pBG = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.00*safezoneW,	0.00*safezoneH];
			_pPR = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.00*safezoneW,	0.00*safezoneH];
		};
	};
	case "SCALAR" : {
		PR(_progress) = 0 max (1 min (_this select 0));
		_pBG = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.30*safezoneW			,	0.02*safezoneH];
		_pPR = [0.35*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,	0.30*safezoneW*_progress,	0.02*safezoneH];
	};
};

_ctrlBG ctrlSetPosition _pBG;
_ctrlBG ctrlCommit 0;

_ctrlPR ctrlSetPosition _pPR;
_ctrlPR ctrlCommit 0;
