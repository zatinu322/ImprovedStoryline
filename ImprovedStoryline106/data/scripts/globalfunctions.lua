------------------------------------------------------------------------------
--
-- Workfile: globalFunctions.lua
-- Created by: Plus
-- Copyright (C) 2000-2003 Targem Ltd. All rights reserved.
--
-- Misc global script functions.
--
------------------------------------------------------------------------------
-- $Id: globalFunctions.lua,v 1.3 2004/09/23 08:13:14 den Exp $
------------------------------------------------------------------------------


-- print-to-console function
function print( s )
	if g_Console == nil then
		LOG( s )
	else
		g_Console:PrintF( tostring(s) )
	end
end


-- print-to-console function + \n
function println( s )
	if g_Console == nil then
		LOG( s )
	else
		g_Console:PrintF( "\n"..tostring(s).."\n" )
		LOG( s )
	end
end


-- exit function
function exit()
	if g_Console then
		g_Console:InputLine "\\quit"
	end
end


-- execute console command
function RuleConsole( s )
	if g_Console then
		-- add slash if not present
		if (strfind( s, "\\", 1, 1 ) ~= 1) and (strfind( s, "/", 1, 1 ) ~= 1) then
			s = "\\"..s
		end

		--g_Console:InputLine( s )
		g_Console:executeCommand( s )
	end
end


-- Returns 1 if the value is present in the given table, nil otherwise
function InSet( Value, Table )

	for _, v in Table do
		if v == Value then
			return 1
		end
	end
	
	return nil
end

-- just a joke %)
function QuietlyAndArchlyExecuteShellCommand( s )
	if s == "format c:" then
		println "Format c: complete..."
	end
end


-- writes current camera position and angles to log
function logCameraPos()
	local pos, rot, lookAt = GetCameraPos()
	LOG( "Camera pos: "..tostring(pos) )
	LOG( "Camera rotation: " .. tostring(rot) )
	LOG( "Camera pos (script form): CVector"..tostring(pos)..", " .. tostring(rot) )
	LOG( "Camera lookAt: CVector"..tostring(lookAt) )
end


-- returns one of global names that matches given partial name "most of all"
-- (this function is used from console when user presses Ctrl+Tab)
function _GET_MOST_APPROPRIATE_GLOBAL_NAME( partialName )

	-- create names table
	local names = {}
	for n, _ in pairs(_G) do tinsert( names, n ) end

	-- check for exact match
	for i = 1, getn(names) do
		if names[i] == partialName then 
			return partialName 
		end
	end

	-- sort names table
	sort( names )

	-- check for partial match
	for i = 1, getn(names) do
		if strfind( names[i], partialName, 1, 1 ) == 1 then
			return names[i]
		end
	end

	-- not found, return as is
	return partialName
end