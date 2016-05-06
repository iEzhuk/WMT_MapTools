	params ["_name"];
	private _cfgPath = "";
	switch (true) do {
		case (isClass (configFile / "CfgWeapons" / _name)) : {
			_cfgPath = "CfgWeapons";
		};
		case (isClass (configFile / "CfgMagazines" / _name)) : {
			_cfgPath = "CfgMagazines";
		};
		case (isclass (configFile / "CfgVehicles" / _name)) : {
			_cfgPath = "CfgVehicles";
		};
		case (isclass (configFile / "CfgGlasses" / _name)) : {
			_cfgPath = "CfgGlasses";
		};
	};
	private _image = getText (configFile / _cfgPath / _name / "picture") ;
	private _text = getText (configFile / _cfgPath / _name / "displayName") ;
	private _tooltip = getText (configFile / _cfgPath / _name / "descriptionShort");
//	diag_log ["wmt_fnc_getitemConfig",_this, _image, _text, _tooltip, _cfgPath] ;
	[_image, _text, _tooltip, _cfgPath]
