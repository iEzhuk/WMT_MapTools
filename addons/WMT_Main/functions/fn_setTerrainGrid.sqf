[] spawn {
    if (!hasInterface) exitWith {};
    sleep 1.5;
    if (isNil "wmt_flag_terrainGrid" || !wmt_flag_terrainGrid) exitWith {diag_log "WMT_Main:setTerrainGrid: wmt_flag_terrainGrid is disabled, exititng.";};
    setTerrainGrid 3.125;
};