-- Make this addon multilingual
PPC.defaultLanguage = "english"

PPC.lang = {}
PPC.defl = {}

PPC:LoadLanguage(PPC.language)
PPC:LoadLanguage(PPC.defaultLanguage)

function PPC:GetLanguage()
	return self.Language or self.defaultLanguage
end

function PPC:LoadLanguage(name)
	local temp = {}
	temp.t = {}
	local meta = {}
	meta.__index = _G
	setmetatable(temp, meta)

	local func = CompileFile("PoliceCall/lang/" .. name .. ".lua")

	if isfunction(func) then
		if SERVER then
			AddCSLuaFile("PoliceCall/lang/" .. name .. ".lua")
		end

		setfenv(func, temp)
		local succ, err = pcall(func)

		if succ then
			if name ~= self.defaultLanguage then
				self.lang[name] = temp.t
			else
				self.defl[name] = temp.t
			end
		else
			MsgC(Color(255, 50, 50), "Loading " .. name .. " translation failed\nError: " .. err .. "\n")
		end
	else
		MsgC(Color(255, 50, 50), "Failed to compile language file 'PoliceCall/lang/" .. name .. ".lua'\n")
	end
end

function PPC:Translate(key, ...)
	local args = {...}
	if self.lang[key] then
		return string.format(self.lang[key], unpack(args)) or ""
	elseif self.defl[key]
		return string.format(self.lang[key], unpack(args)) or ""
	else
		MsgC(Color(255, 50, 50), "'" .. key .. "' is missing in default language table!'\n")
	end
end