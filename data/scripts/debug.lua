-- Debug shit
-- $Id: debug.lua,v 1.40 2005/07/06 12:55:55 anton Exp $

-------------------------------------------------
-- some debug shit, remove it before release
-------------------------------------------------

function testLoadSave()
	RuleConsole "save test1"
	RuleConsole "load test1"
	RuleConsole "save test2"
end

-- Just for bugfixing
function SetPositionNull()
	GetPlayerVehicle():SetPosition(nil)
end

-------------------------------
-- some function for camera log
function p()
    local pos, rot, lookAt = GetCameraPos()
    pos = string.gsub(tostring(pos), "%,", "")
    rot = string.gsub(tostring(rot), "%,", "")
    LOG('<Point  coord="' .. strsub( pos, 2, strlen(pos) - 1 ) .. '" rotation="'.. strsub( rot, 2, strlen(rot) - 1 ) .. '"/>')
end


function c()
    logCameraPos()
end


------------------------------
--Player pos to log
function plp()
LOG("SetPosition( CVector"..tostring(GetPlayerVehicle():GetPosition())..")")
LOG('SetRotation(Quaternion'..tostring(GetPlayerVehicle():GetRotation(Quaternion()))..')')
end


-- writes current camera position and angles to log
function logPoint()
	local pos, rot, lookAt = GetCameraPos()
	local sPos = tostring(pos)
	sPos = strsub( sPos, 2, strlen(sPos) - 1 )
	local sRot = tostring(rot)
	sRot = strsub( sRot, 2, strlen(sRot) - 1 )
	LOG( "		<Point")
	LOG( '			coord="'.. sPos ..'"' )
	LOG( '			rotation="'.. sRot .. '"/>' )
end

-- writes current camera position and angles to log
function logPointS()
	local pos, rot, lookAt = GetCameraPos()
	local sPos = tostring(pos)
	sPos = strsub( sPos, 2, strlen(sPos) - 1 )
	local sRot = tostring(rot)
	sRot = strsub( sRot, 2, strlen(sRot) - 1 )
	writeln( "		<Point")
	writeln( '			coord="'.. sPos ..'"' )
	writeln( '			rotation="'.. sRot .. '"/>' )
end

-----------------------
-- create army (cheat!)

-- debug creation of objects in Player position
function DebugCreate( PrototypeName, Belong )
	local id = CreateNewObject{
		prototypeName = PrototypeName,
		objName = "debug_object"..tostring(random(9999)),
		belong = Belong
	}

	local obj = GetEntityByID( id )

	println( "Object created. id = "..tostring(id) )
end


function CreateVehicleEx( PrototypeName, Name, pos, belong, rot )
	local bel

	if belong then
		bel = belong
	else
		bel = 1100
	end

	local id = CreateNewObject {
		prototypeName = PrototypeName,
		objName = Name,
		belong = bel
	}

	local vehicle = GetEntityByID( id )
	
	if not vehicle then
		println( "Error: vehicle ".. PrototypeName .. " not created" )
		return nil
	end

--	by Anton: ��� �� �����, �.�. �������� SetGamePositionOnGround()
--	local hover = 1.5 * vehicle:GetSize().y
--	pos.y = g_ObjCont:GetHeight( pos.x, pos.z ) + hover


	vehicle:SetGamePositionOnGround( pos )

	if rot then vehicle:SetRotation(rot) end

	return vehicle
end




-- Moves player's vehicle to position
function MovePlayer( x, y, z )
	GetPlayerVehicle():SetPosition( CVector( x, y, z ) )
end


-- Moves player's vehicle to camera position
function MovePlayerToCamera()
	local pos, rot, lookAt = GetCameraPos()
	GetPlayerVehicle():SetPosition( pos )
end


function sss()
	local p = CreateDummy{ modelName ="StoneBridge",objName = "Bridge", pos = CVector( 2000, 2000, 255 ) }
end

function move( x, z )
	GetEntityByName("Team17"):SetDestination( CVector( x, 100, z ) )
end	

function die( x )
	GetEntityByName(x):AddModifier( "hp", "- 1000000" )
end	

function caravan()
	GetEntityByName("TheTown"):SpawnCaravanToLocation("TheEnd")
--	GetEntityByName("TheTown"):SpawnCaravanToLocation("TheTown_defend")
end


function save()
	g_ObjCont:SaveToFileFull( "aaa.xml" )
end

function load()
	g_ObjCont:LoadFromFileFull( "aaa.xml" )	
end

function ff()
	Fly("testq", 0, 0, 30, 1, 1 )
end

function ffc()
	Fly("circle", 0, 0, 10, 1, 1 )
end

function ffb()
	Fly("big", 0, 0, 35, 1, 1 )
end

function ffr()
	Fly("real", 0, 0, 15, 1, 1 )
end

function fff()
	Fly("test", 0, 0, 4, 1, 1 )
	AddCinematicMessage( 8000, 3 )
	AddCinematicMessage( 1, 0.1 )
end

function ValidateGameVersion()
	GAME_VERSION = GetVar("ISLVersion").AsString
	if GAME_VERSION ~= ISL_VERSION then

		if GetComputerName() == "PAVLIKRPG" then

			LOG("Current build "..GAME_VERSION.." is not supported in "..ISL_VERSION)

			AddImportantFadingMsgByStrIdFormatted("fm_wrong_game_version", GAME_VERSION)

			AddFadingMsgByStrIdFormatted("fm_wrong_game_version", GAME_VERSION)

			SpawnMessageBox("9999")
		else
			LOG("Current build "..GAME_VERSION.." is not supported in "..ISL_VERSION)

			SpawnMessageBox("9999")

			ShowDeathMenu()

			InvalidFunctionName() -- ����� �������, ����� ��������� ����� ���������
		end
	else
		-- AddFadingMsg("Game version validated.")
		return GAME_VERSION
	end
end

function testpath()
	GetEntityByName("enemy"):SetPathByName("testVehicle")
	GetEntityByName("enemy"):PlaceToEndOfPath()
end

function AddPlayerVehicle(modelname, PositionOnGround)
-- ��������� ������ ������ (���� ������ � ���� �� ���)
-- ����� ������������, ����� ����� ��� ���� ����.
-- modelname - ������ ������, ������� ����. �� ��������� ������ ����
    if not modelname then
		modelname="Ural01"
	end
	if PositionOnGround == nil then
		PositionOnGround = true
	end

	if GetPlayerVehicle() then
		pl_coord = GetPlayerVehicle():GetPosition()
		pl_rotate = GetPlayerVehicle():GetRotation()
		local teamID = CreateNewObject{
				prototypeName = "team",
				objName = "TempTeam",
				belong = "1100"
			}
	  	local team=GetEntityByID(teamID)
		if team then team:AddChild(GetPlayerVehicle()) end
		team:Remove()
	end
	local id = CreateNewObject{
		prototypeName = modelname,
--	 by Anton: name is set automatically in code --	objName = "PlayerVehicle"..tostring(random(9999)),
		objName = "",
		belong = 1100
	}
	local vehicle = GetEntityByID(id)
	local pl=g_Player
	if vehicle and pl then
	    println("Car name: "..vehicle:GetName())
		local hover = 1.5 * vehicle:GetSize().y
    	local pos, yaw, pitch, roll, lookAt = GetCameraPos()
		println(pos)
		vehicle:SetPosition(pos)
		pl:AddChild(vehicle)
    end
	if PositionOnGround ~= false then
		if GetPlayerVehicle() and pl_coord and pl_rotate then
			GetPlayerVehicle():SetGamePositionOnGround(pl_coord)
			GetPlayerVehicle():SetRotation(pl_rotate)
		end
	else
		if GetPlayerVehicle() and pl_coord and pl_rotate then
			GetPlayerVehicle():SetPosition(pl_coord)
			GetPlayerVehicle():SetRotation(pl_rotate)
		end
	end
	pl_coord = nil
	pl_rotate = nil
end

function AddPlayerNewVehicle(modelname)
-- ��������� ������ ������ ������ �������
-- modelname - ������ ������, ������� ����. �� ��������� ������ ����

    if not modelname then
		modelname="Ural01"
	end

	local realpos
	local Plf = GetPlayerVehicle()

	if Plf then
		realpos = Plf:GetPosition()
		local teamID = CreateNewObject{
				prototypeName = "team",
				objName = "TempTeam",
				belong = "1100"
			}
	  	local team=GetEntityByID(teamID)
		if team then team:AddChild(GetPlayerVehicle()) end
		team:Remove()
	end

	local id = CreateNewObject{
		prototypeName = modelname,
--	 by Anton: name is set automatically in code --			objName = "PlayerVehicle"..tostring(random(9999)),
		objName = "",
		belong = 1100
	}

	local vehicle = GetEntityByID(id)

	local pl = g_Player

	if vehicle and pl then
		local hover = 1.5 * vehicle:GetSize().y
		vehicle:SetPosition(realpos)
		pl:AddChild(vehicle)
    end
end

function fa()
	FlyAround( 2, -0.5, 30, 5, CVector(60, 300, 60), GetPlayerVehicleId(), 1, 1 )
end

function fl()
	GetPlayerVehicle():SetCustomControlEnabled(1)
	GetPlayerVehicle():SetThrottle(1.0)
	FlyLinked("relative", GetPlayerVehicleId(), 10, 1, 1)
end

function fl2()
	GetPlayerVehicle():SetCustomControlEnabled(1)
	GetPlayerVehicle():SetThrottle(1.0)
	FlyLinked("relative", GetPlayerVehicleId(), 10, 1, 1)
end


function dsc()
	GetPlayerVehicle():SetCustomControlEnabled(0)
end

function tec()
	CreateEffect("ET_PS_BIGWHEELGRASSSPLASH", CVector(60, 250, 60), Quaternion(0, 0, 0, 1), 100, 0 )
	CreateEffect("ET_PS_BIGWHEELGRASSSPLASH", CVector(70, 250, 70), Quaternion(0, 0, 0, 1), 0, 1 )
end 

function tgr()
	local Workshop = GetEntityByName("TheTown_Workshop")
	local Repository = Workshop:GetRepositoryByTypename("CabinsAndBaskets")
	Repository:AddItems("belazCab01", 2)
end
		
function PaintTrailer( vehicleName )
	local nametr = getObj( vehicleName ):GetTrailer()
	local trailer = getObj(nametr) 
	local skinnum = getObj( vehicleName ):GetSkin()
	trailer:SetSkin(skinnum)
end

function CreateDummy( prototype, modelName, mass, pos )
	println(prototype)

	local objId = CreateNewObject{ prototypeName = prototype, objName="ddd" }
	local obj = GetEntityByID( objId )

	obj:SetModelName( modelName )
	obj:SetMass( mass )
	obj:SetPosition( pos )
end

function PlayerDie()
	GetPlayerVehicle():AddModifier("hp", "- 1000000" )
end

function  bbb()
	getObj("boss"):StartMoving(CVector(200,300,200),CVector(1,0,0))
end

function  bbb1()
	getObj("boss"):StartMoving(CVector(100,270,100),CVector(0,0,1))
end

function relCoord(name)
	local veh=GetPlayerVehicle()
	if name then 
		local vehtmp = GetEntityByName(name)
		if vehtmp then
		   veh = vehtmp
		else
			println("Object with name "..name.." not exists")
		end
	end

	local campos, camrot = GetCameraPos()
	local vehpos = veh:GetPosition()
	local pos=campos-vehpos
	local rot=camrot
    LOG(' <Point  ')
    LOG('    coord="' .. strsub( tostring(pos), 2, strlen( tostring(pos) ) - 1 ) .. '"')
    LOG('    rotation="'.. strsub( tostring(rot), 2, strlen( tostring(rot) ) - 1 ) .. '"/>')
end


function CreateEnemy(modelname)
-- ������� ����� � ������� ������
    if not modelname then
		modelname="Ural01"
	end

	local enemyname = "EnemyTeam"..tostring(random(9999))

	local teamID = CreateNewObject{
			prototypeName = "team",
			objName = enemyname,
			belong = "1002"
		}
  	local team=GetEntityByID(teamID)

	local id = CreateNewObject{
		prototypeName = modelname,
		objName = "PlayerVehicle"..tostring(random(9999)),
		belong = "1002"
	}
	local vehicle = GetEntityByID(id)

	if vehicle and team then
		local hover = 1.5 * vehicle:GetSize().y
    	local pos = GetCameraPos()
		vehicle:SetPosition(pos)
		vehicle:SetRandomSkin()
		team:AddChild(vehicle)
    end

    println(enemyname)
end

function SetGameTime( h, m )

	if g_ObjCont ~= nil then
		local CurrentDate = g_ObjCont:GetGameTime().AsNumList

		g_ObjCont:SetGameTime( h, m, CurrentDate[2], CurrentDate[3], CurrentDate[4] )
		UpdateWeather()
	end

end

function LogObjHeight(x, z, y, objName)

	if objName == nil then
		objName = "Object name missing"
	end

	local name = objName
	local level = GET_GLOBAL_OBJECT( "CurrentLevel" ):GetLevelName()

	local cont = g_ObjCont
	if cont then
		local height = cont:GetHeight(x, z)
		if y then
			height = math.ceil((height + y)*1000)
		else
			height = math.ceil(height*1000)
		end

		LOG("\""..name.."\" on level "..level)
		LOG(string.format( "%.3f", height/1000))
		println(string.format( "%.3f", height/1000))

	else
		LOG("g_ObjCont is missing!!!")
	end

end

function GetAllTolerance(belong)
	belongs = {1100, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 
			   1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 
			   1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1040, 1041, 1042, 
			   1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 
			   1060, 1061, 1062, 1063, 1064, 1065, 1080, 1081, 1083, 1084, 1085, 1088, 
			   1089, 1090, 1091, 1092, 1093, 1094}
	i = 1
	while belongs[i] ~= nil do
		LOG("Belong_"..belongs[i].." has "..GetTolerance(belong, belongs[i]).." tolerance to "..belong..".")
		i = i + 1
	end
end