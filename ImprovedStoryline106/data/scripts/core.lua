------------------------------------------------------------------------------
--
-- Workfile: core.lua
-- Created by: Plus
-- Copyright (C) 2000-2003 Targem Ltd. All rights reserved.
--
-- This is a core script file. It is launched on engine start.
--
------------------------------------------------------------------------------
-- $Id: core.lua,v 1.2 2004/09/20 09:21:00 plus Exp $
------------------------------------------------------------------------------

LOG("IMPROVED STORYLINE V1.0.6 BUILD 220515")

ISL_VERSION = "106-220515"

EXECUTE_SCRIPT "data\\scripts\\compat.lua"

EXECUTE_SCRIPT "data\\scripts\\globalObjects.lua"
EXECUTE_SCRIPT "data\\scripts\\globalFunctions.lua"
EXECUTE_SCRIPT "data\\scripts\\renderHelpers.lua"

-- autoexec
EXECUTE_SCRIPT "data\\scripts\\autoexec.lua"