-- Special settings for ISL

-- верси€
EXECUTE_SCRIPT "data\\scripts\\version.lua"

-- локализаци€
EXECUTE_SCRIPT "data\\scripts\\localization.lua"

-- activating bonus ending if avaliable
EXECUTE_SCRIPT "data\\scripts\\bonus.lua"

-- выставление правильных биндов в каждой катсцене
function CorrectSkippingMode()
	IMPULSES = GET_GLOBAL_OBJECT "IMPULSES"

	if GetComputerName() == "PAVLIKRPG" then
		IMPULSES:BindKey1( "GS_CINEMATIC", "KEY_SPACE", "IM_CINEMATIC_SKIP_MSG" )
	else
		IMPULSES:BindKey1( "GS_CINEMATIC", "KEY_SPACE", "IM_CINEMATIC_SKIP" )
	end

	return true
end

-- безопасное удаление объекта, который может уже не существовать
function SafeRemove(object)
	if not object then return end
	object:Remove()
	object = nil
end

-- переопределЄнна€ логика стандартных функций

-- shortcut: creates Game Object and all it's children, returns it's handler (ID)
local function _CreateNewObject( prototypeName, objName, parentId, belong )
	local prototypeId = g_ObjCont:GetPrototypeId( prototypeName )

	return g_ObjCont:CreateNewObject( prototypeId, objName, parentId, belong )
end

-- переопределение логики стандартной функции
function CreateNewDummyObject(modelName, objName, parentId, belong, pos, rot, skin, scale)
	local prototypeName 	=  	"someDummyObject"
	local dObj		=	_CreateNewObject( prototypeName, objName, parentId, belong )
	local obj		=	GetEntityByID (dObj)

	if skin == nil then skin = 0 end
	if scale == nil then scale = "1" end

	obj:SetModelName( modelName )
	obj:SetRotation ( rot )
	obj:SetPosition ( pos )
	obj:SetSkin ( skin )
	obj:SetProperty("NodeScale", scale)

	return obj
end

-- special function for creating humans
function CreateHuman(PrototypeName, Belong, Pos, HumanName, PathName, HumanSkin)
	local nameHuman = "Human"..tostring(random(9999))
	if HumanName then
		nameHuman = HumanName
	end

   	local bel = 1100
	if belong then
		bel = belong
	end

	local id = CreateNewObject{
		prototypeName = PrototypeName,
		objName = nameHuman,
		belong = bel
	}

	local human = GetEntityByID( id )
	if not human then
		println( "Error: human ".. PrototypeName .. " is not created" )
		return nil
	end

	Pos.y = g_ObjCont:GetHeight( Pos.x, Pos.z )

	human:SetPosition( Pos )

	if PathName then
		if not human:AddWalkPathByName( PathName  ) then
			println( "Error: path ".. PathName .." for human ".. nameHuman .. " is not added" )
			return nil
		end
	
		if not human:SetWalkPathByName( PathName  ) then
			println( "Error: path ".. PathName .." for human ".. nameHuman .. " is not set" )
			return nil
		end
	end

	local skin = 0
	if HumanSkin then
		skin = HumanSkin
	end

	human:SetSkin(skin)

	return human
end

-- отладочные команды
function mir(md)
	if md == nil then
		md = 0
	end

	if md == 1 then
		SaveAllToleranceStatus(RS_ALLY)
	elseif md ~= 1 then
		RestoreAllToleranceStatus()
	end
end

function yaohuel ()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddItemsToRepository("add_damage_guns_and_grouping_angle_guns", 2)
	GetPlayerVehicle():AddItemsToRepository("firing_rate_guns_and_add_damage_guns", 2)
	GetPlayerVehicle():AddItemsToRepository("add_stability_and_speed2", 4)
	GetPlayerVehicle():AddItemsToRepository("additional_durability3", 4)
	GetPlayerVehicle():AddItemsToRepository("someTurboAccelerationPusher", 1)
end

-- r1m1, показ текста рассказчика в начале игры
function r1m1_ShowNarratorText()
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 77771, 0.1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 77772, 0.1)
	end
end

-- r1m1, начальные титры
function r1m1_ShowTitlesOnGameStart(title, delay)
	local titles = {10, 11, 12, 13}

	if ISL_TYPE == "HD" then
		titles = {5990, 5991, 5992, 5993}
	end

	AddCinematicMessage(titles[title], delay)

	titles = nil
end

-- r1m1, по€вление первого врага
function r1m1_FirstEnemyStart()
	if ISL_TYPE == "SD" then
		Fly("cam01", CINEMATIC_NO_AIM, 0, 5, 1, 1 )
	elseif ISL_TYPE == "HD" then
		local FVehicle = CreateVehicleEx("Sml101","FirstB_0",CVector(2888.161, 346.333, 2342.007), 1002)
		local FVehicleID = FVehicle:GetId()

		Fly("cam01_hd", CINEMATIC_AIM_TO_ID, FVehicleID, 5, 1, 1 )
	end

	StartCinematic()
end

function r1m1_FirstEnemySpawn()
	local FVehicle = true
	local sml_velocity = 25
	
	if ISL_TYPE == "SD" then
		FVehicle = CreateVehicleEx("Sml101","FirstB_0",CVector(2888.161, 346.333, 2342.007), 1002)
	elseif ISL_TYPE == "HD" then
		FVehicle = GetEntityByName("FirstB_0")
		sml_velocity = 29
	end

	if FVehicle then
		FVehicle:SetRandomSkin()
		FVehicle:SetRotation(Quaternion(0.021, 0.472, 0.040, 0.880))
		FVehicle:SetThrottle( 1 )
		FVehicle:SetCustomLinearVelocity( sml_velocity )
		FVehicle:SetExternalPathByName("fun1_5road")
		FVehicle:setGodMode(1)
	end
end

-- r1m1, титры отличной концовки
function r1m1_ShowGoodEndingTitles()
	AddCinematicMessage( 5981, 0)
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 5980, 0.1)
		AddCinematicMessage( 5998, 0.1)
		AddCinematicMessage( 5978, 0.1)
		AddCinematicMessage( 5979, 0.1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 5996, 0.1)
		AddCinematicMessage( 5997, 0.1)
		AddCinematicMessage( 5994, 0.1)
		AddCinematicMessage( 5995, 0.1)
	end
end

-- r1m2, перебивка "Ќа следующий день"
function r1m2_ShowNextDayMessage()
	if ISL_TYPE == "SD" then
		AddCinematicMessage(88060, 1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage(88063, 1)
	end
end

-- r1m2, перебивка "—пуст€ час"
function r1m2_ShowNextHourMessage()
	if ISL_TYPE == "SD" then
		AddCinematicMessage(88062, 1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage(88064, 1)
	end
end

-- r1m2, титры плохой концовки
function r1m2_ShowBadEndingTitles()
	AddCinematicMessage( 5968, 0)
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 5967, 0.1)
		AddCinematicMessage( 59689, 0.1)
		AddCinematicMessage( 5965, 0.1)
		AddCinematicMessage( 5966, 0.1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 5977, 0.1)
		AddCinematicMessage( 5978, 0.1)
		AddCinematicMessage( 5975, 0.1)
		AddCinematicMessage( 5976, 0.1)
	end
end

-- r1m2, титры нормальной концовки
function r1m2_ShowNormalEndingTitles()
	AddCinematicMessage( 5968, 0)
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 5973, 0.1)
		AddCinematicMessage( 5974, 0.1)
		AddCinematicMessage( 5971, 0.1)
		AddCinematicMessage( 5972, 0.1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 5981, 0.1)
		AddCinematicMessage( 5982, 0.1)
		AddCinematicMessage( 5979, 0.1)
		AddCinematicMessage( 5980, 0.1)
	end
end

-- r1m4, титры истинной концовки
function r1m4_ShowTrueEndingTitles()
	AddCinematicMessage( 5971, 0)
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 5970, 0.1)
		AddCinematicMessage( 5973, 0.1)
		AddCinematicMessage( 5968, 0.1)
		AddCinematicMessage( 5969, 0.1)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 5976, 0.1)
		AddCinematicMessage( 5977, 0.1)
		AddCinematicMessage( 5974, 0.1)
		AddCinematicMessage( 5975, 0.1)
	end
end

-- r1m5, перебивка "Ќекоторое врем€ спуст€"
function r1m5_ShowFewMomentsLaterMessage()
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 3, 1 )
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 27, 1 )
	end
end

-- r1m6, перебивка "—пуст€ несколько часов"
function r1m6_ShowFewHoursLaterMessage()
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 27, 1 )
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 117, 1 )
	end
end

-- r1m8, титры бонусной концовки
function r1m8_ShowBonusEndingTitles()
	AddCinematicMessage( 5971, 0)
	if ISL_TYPE == "SD" then
		AddCinematicMessage( 5886, 0.1)
		AddCinematicMessage( 5970, 0.1)
		AddCinematicMessage( 5974, 0.1)
		AddCinematicMessage( 5968, 0.1)
		AddCinematicMessage( 5969, 0.1)
		AddCinematicMessage( 5972, 0)
		AddCinematicMessage( 5973, 0)
	elseif ISL_TYPE == "HD" then
		AddCinematicMessage( 5975, 0.1)
		AddCinematicMessage( 5978, 0.1)
		AddCinematicMessage( 5979, 0.1)
		AddCinematicMessage( 5976, 0.1)
		AddCinematicMessage( 5977, 0.1)
		AddCinematicMessage( 5972, 0)
		AddCinematicMessage( 5980, 0)
	end
end