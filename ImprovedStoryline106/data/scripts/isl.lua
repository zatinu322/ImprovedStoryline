if ISL_VERSION == nil then
	LOG("IMPROVED STORYLINE V1.0.6 BUILD 221014")

	ISL_VERSION = "106-221014"

	-- only for development needs, should not be in release!
	EXECUTE_SCRIPT "data\\scripts\\compatch.lua"
end