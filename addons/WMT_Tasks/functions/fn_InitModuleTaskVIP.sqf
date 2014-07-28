/*
 	Name: WMT_fnc_InitModuleTaskVIP
 	
 	Author(s):
		Ezhuk
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;
systemChat str(_this);
if(_activated) then {
	//===============================================================
	// 							Server part
	//===============================================================
	if(isServer) then {
		[_logic,_units] spawn {
			PR(_logic) = _this select 0;
			PR(_arr) = _this select 1;

			
			PR(_winner)	= [east,west,resistance,civilian,sideLogic] select (_logic getVariable "Winner");
			PR(_count ) = _logic getVariable "Count";
			PR(_msg)	= _logic getVariable "Message";
			PR(_delay) 	= 0.001 max (_logic getVariable "Delay");
			PR(_notice) = _logic getVariable "Notice";

			PR(_units) = [];
			{
				if(_x isKindOf "Man") then {
					_units set [count _units,_x];
				};
			} foreach _arr;

			sleep _delay;

			while {count _units > _count} do {
				PR(_v) = _units;
				{
					if !(alive _x) then {
						_units = _units - [_x];

						if(_notice == 1) then {
							WMT_Global_Notice_ZoneCaptured = [_winner, _x];
							publicVariable "WMT_Global_Notice_VIP";

							PR(_text) = format ["%1 %2", _x getVariable ["WMT_DisplayName", "VIP"], localize "STR_WMT_Eliminated"];
							[_winner, _text] call WMT_fnc_ShowTaskNotification;
						};
					};
				} foreach _v;

				sleep 1.41;
			};

			// End mission
			[[[_winner, _message], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
		};
	};

	//===============================================================
	// 							Client part
	//===============================================================
	if(!isDedicated) then {
		if(player in _units) then {
			[_logic] spawn {
				PR(_logic) = _this select 0;

				PR(_returnTime) = _logic getVariable "ReturnTime";
				PR(_marker) 	= _logic getVariable "Marker";
				PR(_timeCount) = 0;

				while {_timeCount < _returnTime} do {
					if([player,_marker] call WMT_fnc_IsTheUnitInsideMarker) then {
						_timeCount = 0;
					}else {
						PR(_text) = format ["<t size='1' color='#bb0101'>" + localize "STR_WMT_LeaveAllowedArea" + "</t>", _returnTime - _timeCount];

						[format ["<t size='1' color='#bb0000'>%1</t>", _text], 0,0.75*safezoneH + safezoneY,1.2,0,0,27] spawn bis_fnc_dynamicText;

						_timeCount = _timeCount + 1;
					};
					sleep 1;
				};

				player setDamage 1; 
			};
		};
	};
};