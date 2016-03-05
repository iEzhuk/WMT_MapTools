/*
    Name: WMT_fnc_FreezeVoteWait

    Author(s):
        Zealot

    Description:
        Using for vote for wait the end of prepare time

    Parameters:
        Nothing

    Returns:
        Nothing
*/
if ((name player) in WMT_pub_frzVoteStart) then {
    WMT_pub_frzVoteStart = WMT_pub_frzVoteStart - [name player];
    publicVariable "WMT_pub_frzVoteStart";
} else {
    if not ((name player) in WMT_pub_frzVoteWait) then {
        WMT_pub_frzVoteWait = WMT_pub_frzVoteWait + [name player];
        publicVariable "WMT_pub_frzVoteWait";
    };
};
0 call WMT_fnc_FreezeVoteInfo;
