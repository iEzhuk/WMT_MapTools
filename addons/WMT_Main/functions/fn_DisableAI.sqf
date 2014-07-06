/*
 	Name: WMT_fnc_DisableAI
 	
 	Author(s):
		Ezhuk

 	Description:
		Disable AI for all units
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/

{
	_x disableAI "ANIM";
	_x disableAI "AUTOTARGET";
	_x disableAI "TARGET";
	_x disableAI "FSM";
	_x disableAI "MOVE";
	_x disableAI "PATHPLAN";
	_x stop true;
	_x setBehaviour "CARELESS";
	_x allowFleeing 0;
	_x disableConversation true;
	_x setVariable ["BIS_noCoreConversations", false];
}forEach playableUnits;