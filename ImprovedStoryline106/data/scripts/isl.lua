-- Special settings for ISL (ComRem version)

if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.1 HD BUILD 230202")

	ISL_VERSION = "110-HD-230202"
end

-- �����������
STR_PUNISH_BANDITS = "�������� ��������"
STR_FIGHT_WITH_CLAW_R1M4 = "����-����"
STR_FIGHT_WITH_CLAW_R2M1 = "����-���������"
STR_BOSS_CHOOSE = "����� ��������"
STR_BOSS_NJERI = "����� � �����"

-- r1m1, ����� ������ ����������� � ������ ����
function r1m1_ShowNarratorText()
	AddCinematicMessage( 77772, 0.1)
end

-- r1m1, ��������� �����
function r1m1_ShowTitlesOnGameStart(title, delay)
	titles = {5990, 5991, 5992, 5993}

	AddCinematicMessage(titles[title], delay)
end

-- r1m1, ��������� ������� �����
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

-- r1m1, ����� �������� ��������
function r1m1_ShowGoodEndingTitles()
	AddCinematicMessage( 5981, 0)
	AddCinematicMessage( 5996, 0.1)
	AddCinematicMessage( 5997, 0.1)
	AddCinematicMessage( 5994, 0.1)
	AddCinematicMessage( 5995, 0.1)
end

-- r1m2, ��������� "�� ��������� ����"
function r1m2_ShowNextDayMessage()
	AddCinematicMessage(88063, 1)
end

-- r1m2, ��������� "������ ���"
function r1m2_ShowNextHourMessage()
	AddCinematicMessage(88064, 1)
end

-- r1m2, ����� ������ ��������
function r1m2_ShowBadEndingTitles()
	AddCinematicMessage( 5968, 0)
	AddCinematicMessage( 5977, 0.1)
	AddCinematicMessage( 5978, 0.1)
	AddCinematicMessage( 5975, 0.1)
	AddCinematicMessage( 5976, 0.1)
end

-- r1m2, ����� ���������� ��������
function r1m2_ShowNormalEndingTitles()
	AddCinematicMessage( 5968, 0)
	AddCinematicMessage( 5981, 0.1)
	AddCinematicMessage( 5982, 0.1)
	AddCinematicMessage( 5979, 0.1)
	AddCinematicMessage( 5980, 0.1)
end

-- r1m4, ����� �������� ��������
function r1m4_ShowTrueEndingTitles()
	AddCinematicMessage( 5971, 0)
	AddCinematicMessage( 5976, 0.1)
	AddCinematicMessage( 5977, 0.1)
	AddCinematicMessage( 5974, 0.1)
	AddCinematicMessage( 5975, 0.1)
end

-- r1m5, ��������� "��������� ����� ������"
function r1m5_ShowFewMomentsLaterMessage()
	AddCinematicMessage( 27, 1 )
end

-- r1m6, ��������� "������ ��������� �����"
function r1m6_ShowFewHoursLaterMessage()
	AddCinematicMessage( 117, 1 )
end

-- r1m8, ����� �������� ��������
function r1m8_ShowBonusEndingTitles()
	local a = "PLACEHOLDER"
end
