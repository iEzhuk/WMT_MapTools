 // by [STELS]Zealot

private ["_losses","_westalive","_eastalive","_resalive","_reseastfriend","_reswestfriend","_sides","_inittotal", "_initialwest","_initialeast","_initialres","_i"];

_losses =  [_this, 0, 0.1] call BIS_fnc_param; 
_freeztime = [_this, 1, 60] call BIS_fnc_param; 

waitUntil { time > _freeztime };

zlt_fnc_countAliveForSidesOnly = {
	private "_sides";
	_sides =  [_this, 0, [east]] call BIS_fnc_param;
	_res = 0;
	{ _i = _x; _res = _res + ({(isPlayer _x) and (alive _x) and (side _x == _i)} count playableUnits); } foreach _sides;
	_res;
};

zlt_fnc_getBeginForSidesOnly = {
	private "_sides";
	_sides =  [_this, 0, [east]] call BIS_fnc_param;
	_res = 0;
	{_res = _res + (zlt_ls_beginUnitsCount select ([_x] call BIS_fnc_sideID)) } foreach _sides;
	_res;
};



zlt_ls_beginUnitsCount = []; // без учета союзников
zlt_ls_sides = [east,west,resistance];
_nullSides = [civilian];

{
	_i = _x;
	_count = [[_x]] call zlt_fnc_countAliveForSidesOnly;
	zlt_ls_beginUnitsCount set [count zlt_ls_beginUnitsCount, _count];
	if (_count == 0) then {_nullSides = _nullSides + [_x]};
} foreach zlt_ls_sides;

diag_log ("LOSSES.SQF INITIALIZED UNITS:"+str(zlt_ls_beginUnitsCount) + " NULL:" + str(_nullSides)) ;  

zlt_ls_sides = zlt_ls_sides - _nullSides;

_winside = [east];
scopename "main";

while {true} do {
	sleep 5.5;
	
	// для каждой стороны - все их враги понесли потери
	{
		_enemies = [_x] call BIS_fnc_enemySides;
		_beginEnemies = [_enemies] call zlt_fnc_getBeginForSidesOnly;
		_aliveEnemies = [_enemies] call zlt_fnc_countAliveForSidesOnly;
//		diag_log str ["LOSSES.sQF ", _enemies, _beginEnemies, _aliveEnemies ] ;
		
		if (_beginEnemies > 0) then {
			if (_aliveEnemies / _beginEnemies < _losses ) then {
				diag_log ("LOSSES.SQF TRIGGERED BEGIN:"+str(_beginEnemies)+" ALIVE:"+str(_aliveEnemies)+" INITIAL:"+str(zlt_ls_beginUnitsCount) + " NULL:"+str(_nullSides));
				_winside = ([_x] call BIS_fnc_friendlySides) - _nullSides ;
				breakTo "main";
			};
		};
	} foreach zlt_ls_sides;
};

_s = "";
{_s = _s +' ' +([_x]call BIS_fnc_sideName);} foreach _winside;
[[_winside select 0,format["Войска%1 победили. Их противники понесли тяжелые потери!",_s]],"zlt_fnc_endmission"] call BIS_fnc_MP;
