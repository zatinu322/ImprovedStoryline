-- Cheat codes
-- $Id: cheats.lua,v 1.15 2005/07/06 12:55:55 anton Exp $


--------------------------------------------------
-- cheat codes for buka testers
--------------------------------------------------

function gimmegimmegimme()
		if testcheat()~=1 then return end
		GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveMoney(money)
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveAll()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveVehicle(num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function ShowMap()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

--Для Бунакова :)

function god (md)
	if testcheat()~=1 then return end
	local mode=1
	if md then mode=md end
	GetPlayerVehicle():AddModifier( "hp", "= 0" )  
end

function truck (number)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function car (number)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function skin (num)
    GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function giveall ()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function teleport ()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function cab (num)
	if testcheat()~=1 then return end
   GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function cargo (num)
	if testcheat()~=1 then return end
   GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function giveguns ()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function map ()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function givemoney(money)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function suicide()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end


function OpenEncyclopaedia()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function testcheat()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end


