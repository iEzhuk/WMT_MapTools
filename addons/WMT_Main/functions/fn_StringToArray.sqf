/*
 	Name: WMT_fnc_StringToArray
 	
 	Author(s):
		Ezhuk

 	Description:
		Split string by [,]

	Parameters:
 		0: String 

 	Returns:
		ARRAY: splited string by [,]

	Example: 
		["one, two"] WMT_fnc_StringToArray;
		RESULT: ["one","two"]
*/
private ["_func_split", "_string", "_arrstr", "_cntStr", "_sep", "_result", "_sepInd"];

_func_split = {
	private ["_arr", "_ind", "_pre", "_post", "_preInd", "_postInd"];

	_arr = _this select 0;
	_ind = _this select 1;

	_pre     = [];
	_post    = [];
	_preInd  = 0;
	_postInd = 0;

	for "_i" from 0 to ((count _arr)-1) do {
		if (_i < _ind) then {
			_pre set [_preInd, (_arr select _i)];
			_preInd = _preInd + 1;
		};
		if (_i > _ind) then {
			_post set [_postInd, (_arr select _i)];
			_postInd = _postInd + 1;
		};
	};

	[_pre,_post]
};


_string = _this select 0;
_arrstr = toArray _string;
_cntStr = count _arrstr;
_sep = 44;	// separete is [,]
_result = [];

// Remove spaces 
_arrstr = _arrstr - [32];

while {_sepInd = _arrstr find _sep; _sepInd > 1} do {
	_splTmp = [_arrstr,_sepInd] call _func_split;

	_result set [count _result, toString (_splTmp select 0)];
	
	_arrstr = (_splTmp select 1);
};

_result set [count _result, toString _arrstr];
_result