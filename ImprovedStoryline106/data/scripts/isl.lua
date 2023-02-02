if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.1 BUILD 230202")

	ISL_VERSION = "110-230202"
end

-- �����������
STR_PUNISH_BANDITS = "�������� ��������"
STR_FIGHT_WITH_CLAW_R1M4 = "����-����"
STR_FIGHT_WITH_CLAW_R2M1 = "����-���������"
STR_BOSS_CHOOSE = "����� ��������"
STR_BOSS_NJERI = "����� � �����"

-- r1m1, ����� ������ ����������� � ������ ����
function r1m1_ShowNarratorText()
	AddCinematicMessage( 77771, 0.1)
end

-- r1m1, ��������� ������� �����
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