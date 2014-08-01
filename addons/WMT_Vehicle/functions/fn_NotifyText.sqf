 /*
 	Name: WMT_fnc_NotifyText
 	
 	Author(s):
		Zealot

 	Description:
		Show notify

	Parameters:
		STRING

 	Returns:
		Nothing
*/

[format["<t size='0.75' color='#0353f5'>%1</t>", _this], 0, 0.75*safezoneH + safezoneY, 5, 0, 0, 301] spawn bis_fnc_dynamicText;