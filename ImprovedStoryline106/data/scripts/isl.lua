if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.0.6 BUILD 221112")

	ISL_VERSION = "106-221112"

	-- only for development needs, should not be in release!
	EXECUTE_SCRIPT "data\\scripts\\compatch.lua"
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