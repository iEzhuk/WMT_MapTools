/*
 	Name: WMT_fnc_PrecompileMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Compile functions

	Parameters:
 		Nothing
 		
 	Returns:
		Nothing 
*/

WMT_fnc_Announcement				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_Announcement.sqf");
WMT_fnc_ArrayToString				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_ArrayToString.sqf");
WMT_fnc_BriefingMissionParameters 	= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_BriefingMissionParameters.sqf");
WMT_fnc_DefaultFreqsClient			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_DefaultFreqsClient.sqf"); 
WMT_fnc_DefaultFreqsServer			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_DefaultFreqsServer.sqf"); 
WMT_fnc_DisableAI					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_DisableAI.sqf");
WMT_fnc_DisableTI					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_DisableTI.sqf");
WMT_fnc_EndMissionByTime			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_EndMissionByTime.sqf");

WMT_fnc_FreezePlayerClient			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_FreezePlayerClient.sqf");
WMT_fnc_FreezeUI					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_FreezeUI.sqf");
WMT_fnc_FreezeVoteStart				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_FreezeVoteStart.sqf");
WMT_fnc_FreezeVoteWait				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_FreezeVoteWait.sqf");

WMT_fnc_HandlerAdminPanel			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HandlerAdminPanel.sqf");
WMT_fnc_HandlerFeedback				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HandlerFeedback.sqf");
WMT_fnc_HandlerMenu					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HandlerMenu.sqf");
WMT_fnc_HandlerOptions				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HandlerOptions.sqf");

WMT_fnc_HideSideMarkers				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HideSideMarkers.sqf");
WMT_fnc_HeavyLossesCheck			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_HeavyLossesCheck.sqf");
WMT_fnc_IndetifyTheBody				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_IndetifyTheBody.sqf");

WMT_fnc_InitModuleMain				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_InitModuleMain.sqf");
WMT_fnc_InitModuleTime				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_InitModuleTime.sqf");

WMT_fnc_KeyDown						= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_KeyDown.sqf");
WMT_fnc_KeyUp						= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_KeyUp.sqf");
WMT_fnc_PlayerKilled				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_PlayerKilled.sqf");
WMT_fnc_NameTag						= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_NameTag.sqf");

WMT_fnc_PrepareTime_client			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_PrepareTime_client.sqf");
WMT_fnc_PrepareTime_server			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_PrepareTime_server.sqf");

WMT_fnc_RatingControl				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_RatingControl.sqf");
WMT_fnc_RemoveBots					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_RemoveBots.sqf");
WMT_fnc_ShowStatistic				= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_ShowStatistic.sqf");
WMT_fnc_UpdateMainActions			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_UpdateMainActions.sqf");
WMT_fnc_PrepareBriefingInfo			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_PrepareBriefingInfo.sqf");
WMT_fnc_ShowBriefingInfo			= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_ShowBriefingInfo.sqf");
WMT_fnc_BriefingMap					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_BriefingMap.sqf");
WMT_fnc_GetVehicles					= compileFinal preprocessFileLineNumbers  ("WMT_Main\functions\fn_GetVehicles.sqf");