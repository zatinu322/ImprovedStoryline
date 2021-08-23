-- ----------------------------------------------------------------------------
-- 
-- Workfile: dialoghelpers.lua
-- Created by: Anton
-- Copyright (C) 2000-2004 Targem Ltd. All rights reserved.
-- 
-- Some helper functions for working with quests and dialogs
-- Also to inform game designers about this functionality :)
-- 
-- ----------------------------------------------------------------------------
--  $Id: dialoghelpers.lua,v 1.32 2005/07/04 06:43:04 lena Exp $
-- ----------------------------------------------------------------------------

-- Quest helpers --------------------------------------------------------------

function TakeQuest( questName )
	g_QuestStateManager:TakeQuest( questName )

	if g_QuestStateManager:IsQuestTaken( questName ) then
 		AddImportantFadingMsgId( "fm_take_quest" )
	end
end

function CompleteQuest( questName )
	g_QuestStateManager:CompleteQuest( questName )
	if g_QuestStateManager:IsQuestTaken( questName ) and g_QuestStateManager:IsQuestComplete( questName ) then
 		AddImportantFadingMsgId( "fm_complete_quest" )
	end
end

function CompleteQuestIfTaken( questName )
	g_QuestStateManager:CompleteQuestIfTaken( questName )

	if g_QuestStateManager:IsQuestComplete( questName ) then
 		AddImportantFadingMsgId( "fm_complete_quest" )
	end
end

function FailQuest( questName )
	g_QuestStateManager:FailQuest( questName )

	if g_QuestStateManager:IsQuestTaken( questName ) and g_QuestStateManager:IsQuestFailed( questName ) then
 		AddImportantFadingMsgId( "fm_fail_quest" )
	end
end

function FailQuestIfTaken( questName )
	g_QuestStateManager:FailQuestIfTaken( questName )

	if g_QuestStateManager:IsQuestFailed( questName ) then
 		AddImportantFadingMsgId( "fm_fail_quest" )
	end
end

function IsQuestTaken( questName )
	return g_QuestStateManager:IsQuestTaken( questName )
end

function IsQuestComplete( questName )
	return g_QuestStateManager:IsQuestComplete( questName )
end

function IsQuestFailed( questName )
	return g_QuestStateManager:IsQuestFailed( questName )
end

function CanQuestBeGiven( questName )
	return g_QuestStateManager:CanQuestBeGiven( questName )
end

function IsQuestTakenAndNotComplete( questName )
	return IsQuestTaken( questName ) and not IsQuestComplete( questName )
end

-- Dialog helpers -------------------------------------------------------------

-- ������ ������ � NPC. ���� ������� ��������� �� ���� �� ������, �� �� ������������,
-- ���� ������ ��� ���, �� ������������� �� ������ NPC
function StartConversation( npcName )
	npc = g_ObjCont:GetEntityByObjName( npcName )
	if npc then
		TalkWithNpcDlg:Show( npc:GetId() )
	end
end


-- ��������� ������ � NPC
function EndConversation()
	ConversationWnd:EndConversation()
end


-- �������� ������ � NPC � �������� �����
-- ���� �������� bQuick = true �� �� ����������� ����� ������ � ������,
-- ������ ����� ������ ����� ������ ������ � �������� ����� ���� ������

function LeaveTown( bQuick )
	if not bQuick then
		MotherPanel:LeaveTown( false )	
	else
		MotherPanel:LeaveTown( bQuick )
	end
end



-- Player helpers -------------------------------------------------------------

-- ���������� ������ ������
function GetPlayerVehicle()
	return g_Player:GetVehicle()
end

-- ���������� id ������ ������
function GetPlayerVehicleId()
	return g_Player:GetVehicle():GetId()
end

function GetPlayerMoney()
	return g_Player:GetMoney()
end

function AddPlayerMoney( amount )
	if amount>0 then
	AddFadingMsgByStrIdFormatted( "fm_player_add_money", amount )
	elseif 0> amount then
		AddFadingMsgByStrIdFormatted( "fm_player_give_money", abs(amount ))
	end
	g_Player:AddMoney( amount )
end

function GetPlayerHealth()
	return g_Player:GetHealth()
end

function GetPlayerMaxHealth()
	return g_Player:GetMaxHealth()
end

function GetPlayerFuel()
	return g_Player:GetFuel()
end

function GetPlayerMaxFuel()
	return g_Player:GetMaxFuel()
end

-- ���� �� � ������ ��������� ����� ��� �����
function HasPlayerFreePlaceForItems( prototypeName, amount )
	if not amount then
		amount = 1
	end

	return g_Player:CanPlaceItemsToRepository( prototypeName, amount )
end


-- ��������� amount ���� ����� �������� � ���������� prototypeName � ����������� ������
-- ���� amount �� ������, �� �� ����� 1
-- ���������� 1, ���� �������� �������
function AddItemsToPlayerRepository( prototypeName, amount )
	if not amount then
		amount = 1
	end

	return g_Player:AddItemsToRepository( prototypeName, amount )
end


-- ������� amount ���� �������� � ���������� prototypeName �� ����������� ������ (������ ����������)
-- ���� amount �� ������, �� �� ����� 1
-- ���������� 1, ���� �������� �������
function RemoveItemsFromPlayerRepository( prototypeName, amount )
	if not amount then
		amount = 1
	end

	return g_Player:RemoveItemsFromRepository( prototypeName, amount )
end


-- ��������, ����� �� ����� ������ ���������� ���������
-- ���� amount �� ������, �� �� ����� 1
-- ���������� 1, ���� �������� �������
function HasPlayerAmountOfItems( prototypeName, amount )
	if not amount then
		amount = 1
	end

	if not g_Player then
		println("error: no g_Player")
	end

	return g_Player:HasAmountOfItemsInRepository( prototypeName, amount )
end


-- Cinematic helpers ----------------------------------------------------------

-- �������� � ������� ���������� ��������� � ��������������� msgId
-- delay  - ��� �������� ����� ��������� ������ ����������� ���������,
-- ���� ����� ������ ����������, ���� ��� ��������� ������
function AddCinematicMessage( msgId, delay )
	if not msgId then
		LOG( "Error adding message to cinematic" )
		return
	end

	if not delay then
		delay = 0
	end

	g_CinemaPanel:AddMessage( msgId, delay )
end


-- ������� ���������� ������� � ������ -----------------------------------------

-- ��������� ������� � ������, �������� - ��������� ������������� (��� ����� �.�. � ����� �� ��������� ������)
function AddHistory( strHistoryId )
	Journal:AddHistory( strHistoryId, g_ObjCont:GetGameTime())
end


-- ��������� ����� � ������; �������� - ��������� ������������� �������� �����
-- (���� �������� �.�. � ��������� �����; ����� ����� ����� �.�. � ��������� �����,
-- ��� ���� ��� ������������� �.�. <Id ��������> + "_diz" )
function AddBook( strBookNameId , strBookTextId)
    if strBookTextId==nil then
	strBookTextId = strBookNameId.."_diz"
	end
	if not BookExists( strBookNameId ) then Journal:AddBook( strBookNameId, strBookTextId ) end	
end


-- ��������, ���� �� ��� ����� � ����� ��������� ��������� �����
function BookExists( strBookNameId )
	return Journal:BookExists( strBookNameId )
end



-- ��������� ��������� � ������������; �������� - ������ ���� ���������� (��� ��������� - table lua)
-- ������ ������: AddToEncyclopaedia( {"Belaz01", "Molokovoz01"} )
function AddToEncyclopaedia( prototypeNamesTable )
	for i = 1, getn( prototypeNamesTable ) do
		Journal:AddPrototypeToEncyclopaedia( prototypeNamesTable[ i ] )
	end 
end


-- ��������� ����������� � ������������; �������� - ������

function AddBelongToEncyclopaedia( belong )
	Journal:AddClanToEncyclopaedia( belong )
end                              



-- ������� ��� �������� ������ -------------------------------------------------

-- �������� ��������� ������.
-- ���������� ���� ������� ������������ ������ ����� ����-����������,
-- ��������� ������������� ��������� ������.
-- ��������� ������:
--	���������/��������� ����� ����� - Radar:AllowVehicles( allow )
--	���������/��������� ����� ���������� - Radar:AllowNavPoints( allow )
--	���������/��������� ����� ���������� - Radar:AllowDistances( allow )
--	�������� ������ - Radar:SetScanRadius( <������ � ������> )
-- (�������� ������� upgradeStatus - ������������ �����, ����� ����� ���� ������� �� ������������)
function SetRadarUpgrade( upgradeStatus )
	if( upgradeStatus == 0 ) then
		Radar:AllowNavPoints( true )
		Radar:AllowVehicles( false )
		Radar:AllowTurrets( false )
		Radar:AllowDistances( false )
	elseif( upgradeStatus == 1 ) then 
		Radar:AllowNavPoints( true )
		Radar:AllowVehicles( true )
		Radar:AllowTurrets( true )
		Radar:AllowDistances( true )
		Radar:SetScanRadius( 200 )
	else
		LOG( "SetRadarUpgrade error - invalid upgrade status ("..upgradeStatus..")" )

	end
end


-- ������� ��� ������ � ���������� -------------------------------------------------
-- ���� ��� ������ ����� ����� � ������ ��� ������ ������� �������
function ShowCircleOnMinimap( levelName, origin, radius )
	local rad = 100
	if radius then
		rad = radius
	end

	return LevelInfoManager:AddVisibilityCircleForLevel( levelName, origin, rad )
end

-- ������������ ��� ������ ����� ����
function ShowRectOnMinimap( levelName, x0, y0, w, h )
	return LevelInfoManager:AddVisibilityRectForLevel( levelName, x0, y0, w, h )
end

-- ������� ��� ������ ����� � ����������	
function ShowSquareOnMinimap( levelName, origin, halfside )
	return LevelInfoManager:AddVisibilityRectForLevel( levelName, origin.x - halfside, origin.z - halfside, halfside * 2, halfside * 2 )
end

-- ��������� ������ ������ �� ���������� �����
function AddKnownLevel( levelName )
	return LevelInfoManager:AddKnownLevel( levelName )
end

-- ���� �� �� ���������� �����
function IsLevelKnown( levelName )
	return LevelInfoManager:IsLevelKnown( levelName )
end

-- �������� ��� ���, ����� ���������� ������� ��� ���
function IsLevelVisited( levelName )
	return LevelInfoManager:IsLevelVisited( levelName )
end



-- ���������� ------------------------------------------------------------------------

-- ��������� ���� (������ �������������� ����� ������������)
function AutoSave()
	SavesManager:AutoSave( "" );
end

-- ���������� ���������------------------------------------------------------------------------

-- �������� ���������, �������� - ����� ���������.
-- �� ������������� ������������ � ����� � ��������� �����������.
-- ������ ����� ����� ����������� ������� AddFadingMsgId
function AddFadingMsg( msg )
	AddFadingMsgFormatted( msg )
end


-- �������� ����������� ��������� � ������ "������" ���������
-- �������� - ���������� ���������� �������
function AddImportantFadingMsg( msg )
	AddImportantFadingMsgFormatted( msg )
end



-- �������� ���������, �������� - ��������� ������������� ��������� (��� ����� �.�. � ����� �����)
function AddFadingMsgId( msgId )
	AddFadingMsgByStrIdFormatted( msgId )
end


-- �������� ����������� ��������� � ������ "������" ���������
-- �������� - ���������� ���������� �������
function AddImportantFadingMsgId( msgId )
	AddImportantFadingMsgByStrIdFormatted( msgId )
end                                        


-- ������� ����� -----------------------------------------------------------------------------------

-- �������� ���� ��������� � �������� ������ ������.
-- �������� - ������������� ��������� (���� ��������� �.�. � "data\maps\<��������>\strings.xml")
-- � ��������� ��������� � ��������� numButtons ����������� ���������� ������ (1-OK; 2-OK+cancel, 3-OK+NO+cancel).
-- ������������ �������� - ����� ������.

function SpawnMessageBox( msgId, pause )
	if not pause then
		pause = true
	end
	
	return MsgManager:ShowMsgBox( msgId, pause )
end



-- �������� �������� ���� ������ ---------------------------------------------------------------------------

-- ������ ������� ��������� �������� ����� �����, ��� �������� ���� ������ ����� ����������� ������ �� �������.
-- ��� ������� ������������ ������� ���� ������ ����� ������������� ��������� GE_TOWN_CONDITIONAL_CLOSING �� ����� ������
-- ���������: 
-- 	townName		- ��� ������
-- 	levelName		- �������, �� ������� ����� ���������
-- 	bConditionalClosing	- ��������� ��������, ����������/�������� ���� �������� �������������

function SetConditionalClosingForTown( townName, levelName, bConditionalClosing )
	TownDlg:SetConditionalClosingForTown( townName, levelName, bConditionalClosing )
end


-- ������, �������� �� ���� ��� ������� ������ ������� �����������

function IsTownWithConditionalClosing( townName, levelName )
	return TownDlg:IsTownWithConditionalClosing( townName, levelName )
end




-- ��������� �������� ----------------------------------------------------------------------


-- ���� ��������� ������� ������. �������� - ��� ��������� ��������

function AddQuestItem( itemPrototypeName )
	g_Player:AddQuestItem( itemPrototypeName )
end


-- ������� ��������� ������� � ������. �������� - ��� ��������� ��������

function RemoveQuestItem( itemPrototypeName )
	g_Player:RemoveQuestItem( itemPrototypeName )
end


-- ���������, ���� �� � ������ ��������� ������� � �������� ����������.

function IsQuestItemPresent( itemPrototypeName )
	return g_Player:IsQuestItemPresent( itemPrototypeName )
end



-- ������ ������ - ���������� � �������������� ------------------------------------------------

-- ���������� ������� ����� ������.
-- (���������� �������� �� ���� ��� � ������ �������� ������)

function SaveWeaponGroups()
	WeaponGroupManager:SaveWeaponGroups()
end

-- �������������� ����������� ����� ������
-- (���������� �������� ����� ���� ��� ������ ������� ������)

function RestoreWeaponGroups()
	WeaponGroupManager:RestoreWeaponGroups()
end


-- ���������/��������� ���������� ����
function AllowSave( allow )
	if allow == nil then
		allow = true
	end
	
	g_ObjCont:AllowSave( allow )
end



-- ������ ---------------------------------------------------------------------------------------

-- ���������/��������� �������������� ����� ������ ��� �������

function EnableAutoHelp( bEnable )
	HelpManager:EnableAutoHelp( bEnable )
end


-- ������, ��������� �� ������������ �� �������������� ������

function IsAutoHelpEnabled()
	return HelpManager:IsAutoHelpEnabled()
end


-- �������� ���� ������. �������� - ������������� ������ ������*. 
-- * � ������, ���� ���������� �������� ����� ����������� ���� (��������, ������ ��� �������� ����������),
-- �� �������� - ��� ������������� ������ ����.
-- 	������ ��������������� ����������� ���� ������:
-- 	HELP_ID_MAIN_GAME_INTERFACE		- ������ ��� �������� ����������

function ShowHelp( helpId )
	HelpManager:ShowHelp( helpId, true )
end



-- ��������� ����� ����� ----------------------------------------------------------------------------

function ShowBossIndicator( bossId )
	MainGameInterface:SetupForBoss( bossId )
end


function HideBossIndicator()
	MainGameInterface:SetupForBoss( -1 )	
end