if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.1 BUILD 230202")

	ISL_VERSION = "110-230202"
end

-- локализация
STR_PUNISH_BANDITS = "Проучить бандитов"
STR_FIGHT_WITH_CLAW_R1M4 = "Босс-кран"
STR_FIGHT_WITH_CLAW_R2M1 = "Босс-погрузчик"
STR_BOSS_CHOOSE = "Перед Оракулом"
STR_BOSS_NJERI = "Битва с Ньери"

-- r1m1, показ текста рассказчика в начале игры
function r1m1_ShowNarratorText()
	AddCinematicMessage( 77771, 0.1)
end

-- r1m1, появление первого врага
function r1m1_FirstEnemyStart()
	Fly("cam01", CINEMATIC_NO_AIM, 0, 5, 1, 1 )
	StartCinematic()
end

function r1m1_FirstEnemySpawn()
	CreateVehicleEx("Sml101","FirstB_0",CVector(2888.161, 346.333, 2342.007), 1002)

	local FVehicle = GetEntityByName("FirstB_0")
	if FVehicle then
		FVehicle:SetRandomSkin()
		FVehicle:SetRotation(Quaternion(0.021, 0.472, 0.040, 0.880))
		FVehicle:SetThrottle( 1 )
		FVehicle:SetCustomLinearVelocity( 25 )
		FVehicle:SetExternalPathByName("fun1_5road")
		FVehicle:setGodMode(1)
	end
end