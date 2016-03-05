/*
    Name: WMT_fnc_FreezeVoteStart

    Author(s):
        Zealot

    Description:
        Using for vote for end of prepare time

    Parameters:
        Nothing

    Returns:
        Nothing
*/
if ((name player) in WMT_pub_frzVoteWait) then {
    WMT_pub_frzVoteWait = WMT_pub_frzVoteWait - [name player];
    publicVariable "WMT_pub_frzVoteWait";
} else {
    if not ((name player) in WMT_pub_frzVoteStart) then {
        WMT_pub_frzVoteStart = WMT_pub_frzVoteStart + [name player];
        publicVariable "WMT_pub_frzVoteStart";
    };
};
0 call WMT_fnc_FreezeVoteInfo;
