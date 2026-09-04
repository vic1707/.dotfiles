-- Ctrl + Option + V
-- Types the clipboard slowly into whatever currently has focus.
-- Useful for BMC/iKVM consoles that don't support clipboard paste.
local charDelay = 200000 -- 200 ms between characters
local keyDelay  = 100000 -- hold each generated key for 100 ms

local shifted = {
    ["!"] = "1",
    ["@"] = "2",
    ["#"] = "3",
    ["$"] = "4",
    ["%"] = "5",
    ["^"] = "6",
    ["&"] = "7",
    ["*"] = "8",
    ["("] = "9",
    [")"] = "0",
    ["_"] = "-",
    ["+"] = "=",
    ["{"] = "[",
    ["}"] = "]",
    ["|"] = "\\",
    [":"] = ";",
    ['"'] = "'",
    ["<"] = ",",
    [">"] = ".",
    ["?"] = "/"
}

local function sendChar(c)
    if c == "\n" then
        hs.eventtap.keyStroke({}, "return", keyDelay)

    elseif c:match("%u") then
        hs.eventtap.keyStroke({"shift"}, c:lower(), keyDelay)

    elseif shifted[c] then
        hs.eventtap.keyStroke({"shift"}, shifted[c], keyDelay)

    else
        hs.eventtap.keyStrokes(c)
    end

    hs.timer.usleep(charDelay)
end

local function slowPaste()
    local text = hs.pasteboard.getContents()

    if not text or text == "" then
        hs.alert.show("Clipboard is empty")
        return
    end

    hs.timer.doAfter(0.5, function()
        for i = 1, #text do
            sendChar(text:sub(i, i))
        end
    end)
end

hs.hotkey.bind({"ctrl", "alt"}, "v", slowPaste)
