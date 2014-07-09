private "_veh";
_veh = [_this, 0] call BIS_fnc_param;
if (isNil {_veh} ) exitWith {}; 
{
	_dmg = (_veh getHitPointDamage _x);
	if (not isNil {_dmg}) then {
		if ( _dmg > 0.64 ) then {
			if (_x in WMT_hardFieldRepairParts) then {
				_veh setHitPointDamage [_x,0.64];
			} else {
				_veh setHitPointDamage [_x,0];
			};
		};
	};
} foreach WMT_fieldRepairHps; 