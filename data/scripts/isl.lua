-- Special settings for ISL (ComRem version)

if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.1 HD BUILD 230518")

	ISL_VERSION = "110-HD-230518"
end

-- локализация
EXECUTE_SCRIPT "data\\scripts\\localization.lua"

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
	AddCinematicMessage( 77772, 0.1)
end

-- r1m1, начальные титры
function r1m1_ShowTitlesOnGameStart(title, delay)
	titles = {5990, 5991, 5992, 5993}

	AddCinematicMessage(titles[title], delay)
end

-- r1m1, появление первого врага
function r1m1_FirstEnemyStart()
	local FVehicle = CreateVehicleEx("Sml101","FirstB_0",CVector(2888.161, 346.333, 2342.007), 1002)
	local FVehicleID = FVehicle:GetId()

	Fly("cam01_hd", CINEMATIC_AIM_TO_ID, FVehicleID, 5, 1, 1 )
	StartCinematic()
end

function r1m1_FirstEnemySpawn()
	local FVehicle = GetEntityByName("FirstB_0")
	if FVehicle then
		FVehicle:SetRandomSkin()
		FVehicle:SetRotation(Quaternion(0.021, 0.472, 0.040, 0.880))
		FVehicle:SetThrottle( 1 )
		FVehicle:SetCustomLinearVelocity( 29 )
		FVehicle:SetExternalPathByName("fun1_5road")
		FVehicle:setGodMode(1)
	end
end

-- r1m1, титры отличной концовки
function r1m1_ShowGoodEndingTitles()
	AddCinematicMessage( 5981, 0)
	AddCinematicMessage( 5996, 0.1)
	AddCinematicMessage( 5997, 0.1)
	AddCinematicMessage( 5994, 0.1)
	AddCinematicMessage( 5995, 0.1)
end

-- r1m2, перебивка "На следующий день"
function r1m2_ShowNextDayMessage()
	AddCinematicMessage(88063, 1)
end

-- r1m2, перебивка "Спустя час"
function r1m2_ShowNextHourMessage()
	AddCinematicMessage(88064, 1)
end

-- r1m2, титры плохой концовки
function r1m2_ShowBadEndingTitles()
	AddCinematicMessage( 5968, 0)
	AddCinematicMessage( 5977, 0.1)
	AddCinematicMessage( 5978, 0.1)
	AddCinematicMessage( 5975, 0.1)
	AddCinematicMessage( 5976, 0.1)
end

-- r1m2, титры нормальной концовки
function r1m2_ShowNormalEndingTitles()
	AddCinematicMessage( 5968, 0)
	AddCinematicMessage( 5981, 0.1)
	AddCinematicMessage( 5982, 0.1)
	AddCinematicMessage( 5979, 0.1)
	AddCinematicMessage( 5980, 0.1)
end

-- r1m4, титры истинной концовки
function r1m4_ShowTrueEndingTitles()
	AddCinematicMessage( 5971, 0)
	AddCinematicMessage( 5976, 0.1)
	AddCinematicMessage( 5977, 0.1)
	AddCinematicMessage( 5974, 0.1)
	AddCinematicMessage( 5975, 0.1)
end

-- r1m5, перебивка "Некоторое время спустя"
function r1m5_ShowFewMomentsLaterMessage()
	AddCinematicMessage( 27, 1 )
end

-- r1m6, перебивка "Спустя несколько часов"
function r1m6_ShowFewHoursLaterMessage()
	AddCinematicMessage( 117, 1 )
end

-- r1m8, титры бонусной концовки
function r1m8_ShowBonusEndingTitles()
	AddCinematicMessage( 5971, 0)
	AddCinematicMessage( 5975, 0.1)
	AddCinematicMessage( 5978, 0.1)
	AddCinematicMessage( 5979, 0.1)
	AddCinematicMessage( 5976, 0.1)
	AddCinematicMessage( 5977, 0.1)
	AddCinematicMessage( 5972, 0)
	AddCinematicMessage( 5980, 0)
end

-- activating bonus ending if avaliable
EXECUTE_SCRIPT "data\\scripts\\bonus.lua"