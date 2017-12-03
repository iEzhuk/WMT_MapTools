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
    private _unit = _x;
    {
        _unit disableAI _x;

    } foreach ["AUTOTARGET","TARGET","FSM","MOVE","PATH","AIMINGERROR","SUPPRESSION","CHECKVISIBLE","COVER","AUTOCOMBAT","MINEDETECTION"];
    _unit stop true;
    _unit setBehaviour "CARELESS";
    _unit allowFleeing 0;
    _unit disableConversation true;
    _unit setVariable ["BIS_noCoreConversations", false];
    _unit setSpeaker "NoVoice";
}forEach (if (count playableUnits == 0) then {allUnits} else {playableUnits});
