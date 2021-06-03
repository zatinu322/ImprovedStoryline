-- Cheat codes
-- $Id: cheats.lua,v 1.15 2005/07/06 12:55:55 anton Exp $


--------------------------------------------------
-- cheat codes for buka testers
--------------------------------------------------

function gimmegimmegimme()
		nishtyaki()
end

function GiveMoney(money)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveAll()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveVehicle(num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

--Для Бунакова :)

function god ()
	bessmertie()
end

function truck (number)
	mashina()
end

function car (number)
	povozka()
end

function skin (num)
    GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function giveall ()
	zhiruem()
end

function teleport ()
	peremeshenie()
end

function yaohuel ()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddItemsToRepository("add_damage_guns_and_grouping_angle_guns", 2)
	GetPlayerVehicle():AddItemsToRepository("firing_rate_guns_and_add_damage_guns", 2)
end

function cab (num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function cargo (num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function giveguns ()

	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function map ()
	ShowMap()
end

function givemoney(money)
	bablo()
end

function suicide()
	AllowSave( true )
end


function OpenEncyclopaedia()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function ShowMap()
	local mapsize = GET_GLOBAL_OBJECT( "CurrentLevel" ):GetLandSize() * 128
	local mapname = GET_GLOBAL_OBJECT( "CurrentLevel" ):GetLevelName()
	ShowRectOnMinimap(mapname, 1, 1, mapsize, mapsize)
end
