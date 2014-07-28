/*
 	Name: WMT_fnc_InitModuleTaskCapturePoints

 	Author(s):
		Ezhuk
*/

#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	//===============================================================
	// 							Server part
	//===============================================================
	if(isServer) then {
		[_logic] spawn {
			PR(_logic) = _this select 0;

			PR(_winner)	= [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");
			PR(_count)	= _logic getVariable "Count";
			PR(_msg) 	= _logic getVariable "Message";
			PR(_delay)	= 0.001 max (_logic getVariable "Delay");

			sleep _delay;

			PR(_points) = WMT_Local_PointArray;

			while { {_x getVariable "WMT_PointOwner" == _winner}  count _points < _count} do {
				sleep 2.3;
			};

			// End mission
			[[[_winner, _msg], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
		};
	};
};