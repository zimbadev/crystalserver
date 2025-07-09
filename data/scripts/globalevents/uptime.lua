local uptimeFile = "data/uptime.txt"
-- Save the time when the server (and this script) started
local serverStartTime = os.time()

local saveUptimeEvent = GlobalEvent("SaveUptime")

function saveUptimeEvent.onThink(interval)
    -- Calculate uptime as the number of seconds since server/script start
    local uptime = os.time() - serverStartTime
    -- Try to open (or create) the file and write uptime
    local ok, err = pcall(function()
        local file = io.open(uptimeFile, "w")
        if file then
            file:write(uptime)
            file:close()
        else
            print("[SaveUptime] Cannot create or write to file: " .. uptimeFile)
        end
    end)
    if not ok then
        print("[SaveUptime] Error writing uptime: " .. tostring(err))
    end
    return true
end

-- Run this event every 1 seconds (1000 ms)
saveUptimeEvent:interval(1000)
saveUptimeEvent:register()