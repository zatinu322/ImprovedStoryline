if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.0.6 HD BUILD 221230")

	ISL_VERSION = "106-HD-221230"
end

-- r1m1, показ текста рассказчика в начале игры
function r1m1_ShowNarratorText()
	AddCinematicMessage( 77771, 0.1)
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