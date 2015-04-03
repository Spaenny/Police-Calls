-- Make this addon multilingual
PPC.defaultLanguage = "english"

PPC.lang = {}

function PPC:GetLanguage()
	return self.Language or self.defaultLanguage
end

function PPC:LoadLanguage(name)
	local temp = {}
	temp.t = {}
	
	local func = CompileFile("PoliceCall/lang/" .. name .. ".lua")

	if isfunction(func) then
		if SERVER then
			AddCSLuaFile("PoliceCall/lang/" .. name .. ".lua")
		end

		setfenv(func, temp)
		local succ, err = pcall(func)

		if succ then
			self.lang[name] = temp.t
			return true
		else
			MsgC(Color(255, 50, 50), "Loading " .. name .. " translation failed\nError: " .. err .. "\n")
			return false
		end
	else
		MsgC(Color(255, 50, 50), "Failed to compile language file 'PoliceCall/lang/" .. name .. ".lua'\n")
		return false
	end
end

function PPC:Translate(key, ...)
	local args = {...} or ""
	if self.lang[self:GetLanguage()][key] then
		return string.format(self.lang[self:GetLanguage()][key], unpack(args)) or "PPC.lang." .. self:GetLanguage() .. "." .. key
	elseif self.lang[self.defaultLanguage][key] then
		return string.format(self.lang[self.defaultLanguage][key], unpack(args)) or "PPC.lang." .. self.defaultLanguage .. "." .. key
	else
		MsgC(Color(255, 50, 50), "'" .. key .. "' is missing in default language table!'\n")
		return "PPC.lang." .. self.defaultLanguage .. "." .. key
	end
end

local loaded = PPC:LoadLanguage(PPC:GetLanguage())

if not loaded or ( loaded and PPC:GetLanguage() ~= PPC.defaultLanguage ) then
	PPC:LoadLanguage(PPC.defaultLanguage)
end