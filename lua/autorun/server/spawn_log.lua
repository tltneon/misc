
local tag = "spawn_log"

local c, w, g = Color(0, 255, 255), Color(255, 255, 255), Color(192, 192, 192)

local function Log(event, ply, ...)
	MsgC(c, "[", event, "] ")
	Msg(ply, " ")
	MsgC(...)
	Msg("\n")
end

local prev
local function NoVectorDecimals(vec)
	vec.x = math.Round(vec.x)
	vec.x = math.Round(vec.y)
	vec.z = math.Round(vec.z)
	return vec
end
local function LogProp(ply, model, ent)
	if prev == "duplicator" then return end
	local pos = NoVectorDecimals(ent:GetPos())
	Log("SPAWN prop", ply, w, ent:GetModel(), g, " (" .. tostring(ent) .. " @ " .. tostring(pos) .. ")")
end
local function LogEffect(ply, model, ent)
	local pos = NoVectorDecimals(ent:GetPos())
	Log("SPAWN effect", ply, w, ent:GetModel(), g, " (" .. tostring(ent) .. " @ " .. tostring(pos) .. ")")
end
local function LogSENT(ply, ent)
	local pos = NoVectorDecimals(ent:GetPos())
	Log("SPAWN sent", ply, w, ent.PrintName or ent:GetClass(), g, " (" .. tostring(ent) .. " @ " .. tostring(pos) .. ")")
end
local function LogVehicle(ply, ent)
	Log("SPAWN vehicle", ply, w, ent.VehicleTable.Name, g, " (" .. tostring(ent) .. ")")
end

local ignoreTools = {
	paint = true,
	inflator = true,
}
local function LogTool(ply, trace, tool)
	if ignoreTools[tool] then return end
	Log("TOOL", ply, w, tool, g, " " .. tostring(trace.Entity) .. " @ " .. tostring(trace.HitPos))
	prev = tool
	timer.Simple(0, function() prev = nil end)
end

hook.Add("PlayerSpawnedProp", tag, LogProp)
hook.Add("PlayerSpawnedEffect", tag, LogEffect)
hook.Add("PlayerSpawnedSENT", tag, LogSENT)
hook.Add("PlayerSpawnedVehicle", tag, LogVehicle)
hook.Add("CanTool", tag, LogTool)

