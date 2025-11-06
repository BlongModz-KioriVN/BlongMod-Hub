-- ========================================================
-- 🎮 BLong Hub | BLong X ChatGPT (V1.5)
-- 🧠 UI Library: Fluent Plus
-- 🌈 Version: V1.5 | NiF tab created directly, full features
-- ========================================================

-- 🌟 Hiệu ứng chào mừng BLong Mod
do
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BLong_Welcome"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = ScreenGui
    TextLabel.Size = UDim2.new(1,0,1,0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "BLong Mod"
    TextLabel.TextColor3 = Color3.fromRGB(0,255,255)
    TextLabel.TextStrokeTransparency = 0.3
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.FredokaOne

    for i = 0, 1, 0.05 do
        TextLabel.TextTransparency = 1 - i
        task.wait(0.02)
    end
    task.wait(1.1)
    for i = 0, 1, 0.05 do
        TextLabel.TextTransparency = i
        task.wait(0.02)
    end

    ScreenGui:Destroy()
end

------------------------------------------------------
-- 🧩 Load UI Library (FluentPlus) with safety checks
------------------------------------------------------
local successFluent, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()
end)

if not successFluent or not Fluent then
    warn("Failed to load FluentPlus UI library. BLong Hub cannot start.")
    return
end

local successSave, SaveManager = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
end)
local successInterface, InterfaceManager = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
end)

if not successSave then SaveManager = nil end
if not successInterface then InterfaceManager = nil end

------------------------------------------------------
-- 🪄 Create main window
------------------------------------------------------
local Window = Fluent:CreateWindow({
    Title = "BLong Hub",
    SubTitle = "Chờ Update thêm!",
    TabWidth = 140,
    Size = UDim2.new(0,720,0,480),
    Acrylic = true,
    Theme = "Midnight",
    MinimizeKey = Enum.KeyCode.LeftControl
})

------------------------------------------------------
-- 🌈 Tabs (create core tabs)
------------------------------------------------------
local Tabs = {}
Tabs.TSB = Window:AddTab({ Title = "👊The Strongest Battleground👍", Icon = "" })
Tabs.NiF = Window:AddTab({ Title = "🌲99 Đêm Trong Rừng🌿", Icon = "" })
Tabs.RaiseAnimal = Window:AddTab({ Title = "🐾Raise Animal🐳", Icon = "" })
Tabs.Evade = Window:AddTab({ Title = "🏄‍♂️Evade🏃‍♂️", Icon = "" })
Tabs.Player = Window:AddTab({ Title = "🦹‍♂️Player🧛‍♀️", Icon = "" })
Tabs.Settings = Window:AddTab({ Title = "⚙Settings🔧", Icon = "" })
-- NOTE: 99 Night in Forest tab will be created directly later to avoid race issues

-- Build config / interface sections safely
if SaveManager then
    pcall(function()
        SaveManager:SetLibrary(Fluent)
        SaveManager:SetFolder("BLongHubConfigs")
        SaveManager:BuildConfigSection(Tabs.Settings)
    end)
end
if InterfaceManager then
    pcall(function()
        InterfaceManager:SetLibrary(Fluent)
        InterfaceManager:SetFolder("BLongHubConfigs/Interface")
        InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    end)
end

------------------------------------------------------
-- 🥋 TAB: The Strongest Battleground (TSB)
------------------------------------------------------
Tabs.TSB:AddParagraph({
    Title = "🌀 Script Hub - TSB",
    Content = "Chọn script bạn muốn chạy trong The Strongest Battleground."
})

local TSBButtons = {
    {"Minh Nhật Hub","Script TSB của Minh Nhật","https://raw.githubusercontent.com/minhnhatdepzai8-cloud/TONG-HOP-SCRIPT/refs/heads/main/TSB"},
    {"YQuangTG TSB","Script TSB của yquangtg","https://raw.githubusercontent.com/yqantg-pixel/Find/refs/heads/main/Protected_3334988263341522.lua.txt"},
    {"Fake Emote Pro","Script emote ảo cực chất","https://raw.githubusercontent.com/MIYKO0EB/ScriptsIDK/refs/heads/main/EMOTE%20HUB(25-100).txt"},
    {"Auto Farm TSB","Script farm tự động","https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua"},
    {"Fake Emote Mui LMT","Biến hình MUI cực ngầu","https://raw.githubusercontent.com/IdkRandomUsernameok/PublicAssets/refs/heads/main/Releases/MUI.lua"},
    {"Throw The Trash","Script ném rác vui nhộn","https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man"}
}

for _, btn in pairs(TSBButtons) do
    Tabs.TSB:AddButton({
        Title = btn[1],
        Description = btn[2],
        Callback = function()
            local ok, err = pcall(function()
                local src = game:HttpGet(btn[3], true)
                local fn = loadstring(src)
                if fn then fn() end
            end)
            if ok then
                pcall(function() Fluent:Notify({ Title = btn[1], Content = "Script đã chạy.", Duration = 3 }) end)
            else
                pcall(function() Fluent:Notify({ Title = btn[1].." - Lỗi", Content = tostring(err), Duration = 4 }) end)
                warn("TSB load failed:", btn[1], err)
            end
        end
    })
end


-- 🌲 Tạo tab 99 Đêm Trong Rừng

Tabs.NiF:AddParagraph({
    Title = "🌀 Script Hub - 99 Đêm Trong Rừng",
    Content = "Chọn script bạn muốn chạy trong game 99 Đêm Trong Rừng 🌲."
})

-- Ví dụ: Thêm nút script vào tab NiF
local NiFScripts = {
    {"FoxName Hub", "Keyless", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"},
    {"Dupe Candy VIP Pro 💀", "VIP Pro", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/dupecandyidklol.lua"},
    {"Auto Farm Diamond", "Máy mượt mới chịu nỗi", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FNDayFarm.lua"},
    {"Voidware Script", "Keyless", "https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/NightsInTheForest.lua"},
    {"H4x Script", "Có Key", "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader2.lua"}
}

for _, info in pairs(NiFScripts) do
    Tabs.NiF:AddButton({
        Title = info[1],
        Description = info[2],
        Callback = (function(url, name)
            return function()
                local ok, err = pcall(function()
                    local src = game:HttpGet(url, true)
                    local fn = loadstring(src)
                    if fn then fn() end
                end)
                if ok then
                    Fluent:Notify({ Title = name, Content = "Script đã chạy thành công!", Duration = 3 })
                else
                    Fluent:Notify({ Title = name.." - Lỗi", Content = tostring(err), Duration = 4 })
                    warn("NiF script error:", name, err)
                end
            end
        end)(info[3], info[1])
    })
end


Tabs.RaiseAnimal:AddParagraph({
    Title = "🐾 Raise Animal Hub",
    Content = "Chọn script bạn muốn chạy để nuôi và quản lý động vật."
})

-- 1️⃣ Raise Animal 1 (Key: ATGFREE2025)
Tabs.RaiseAnimal:AddButton({
    Title = "Raise Animal 1",
    Description = "Key: ATGFREE2025",
    Callback = function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ATGFAIL/ATGHub/main/Raise-Animals.lua'))()
        end)
        if ok then
            Fluent:Notify({ Title="Raise Animal 1", Content="Script chạy thành công!", Duration=3 })
        else
            Fluent:Notify({ Title="Raise Animal 1 - Lỗi", Content=tostring(err), Duration=4 })
            warn("Raise Animal 1 error:", err)
        end
    end
})

-- 2️⃣ JinkX RSANM
Tabs.RaiseAnimal:AddButton({
    Title = "JinkX RSANM",
    Description = "Script JinkX Raise Animal",
    Callback = function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/stormskmonkey/JinkX/main/Loader.lua"))()
        end)
        if ok then
            Fluent:Notify({ Title="JinkX RSANM", Content="Script chạy thành công!", Duration=3 })
        else
            Fluent:Notify({ Title="JinkX RSANM - Lỗi", Content=tostring(err), Duration=4 })
            warn("JinkX RSANM error:", err)
        end
    end
})

-- 3️⃣ Bonk Hub RSANM 3
Tabs.RaiseAnimal:AddButton({
    Title = "Bonk Hub RSANM 3",
    Description = "Script Bonk Hub Raise Animal",
    Callback = function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://bonkhub.online/loader.lua",true))()
        end)
        if ok then
            Fluent:Notify({ Title="Bonk Hub RSANM 3", Content="Script chạy thành công!", Duration=3 })
        else
            Fluent:Notify({ Title="Bonk Hub RSANM 3 - Lỗi", Content=tostring(err), Duration=4 })
            warn("Bonk Hub RSANM 3 error:", err)
        end
    end
})


Tabs.Evade:AddParagraph({
    Title = "⚡ Evade Hub",
    Content = "Chọn script bạn muốn chạy để né tránh hiệu ứng hoặc farm trong game."
})

local EvadeScripts = {
    {"GPHUC EVD 1", "Keyless", "https://raw.githubusercontent.com/htnghi1953-code/GPhuchub/refs/heads/main/GPhucEvade"},
    {"Tora EVD (Farm Candy)", "Keyless", "https://raw.githubusercontent.com/gumanba/Scripts/main/EvadeEvent"},
    {"Draconic Hub", "Keyless", "https://raw.githubusercontent.com/Nyxarth910/Draconic-Hub-X/refs/heads/main/files/Evade/Overhaul.lua"},
    {"Dragon Hub", "PC only nếu không chạy được Draconic", "https://raw.githubusercontent.com/RequideSync/Dragon/refs/heads/main/file/Evade/Loader.lua"}
}

for _, info in pairs(EvadeScripts) do
    Tabs.Evade:AddButton({
        Title = info[1],
        Description = info[2],
        Callback = (function(url, name)
            return function()
                local ok, err = pcall(function()
                    local src = game:HttpGet(url, true)
                    local fn = loadstring(src)
                    if fn then fn() end
                end)
                if ok then
                    Fluent:Notify({ Title = name, Content = "Script chạy thành công!", Duration = 3 })
                else
                    Fluent:Notify({ Title = name.." - Lỗi", Content = tostring(err), Duration = 4 })
                    warn("Evade script error:", name, err)
                end
            end
        end)(info[3], info[1])
    })
end


------------------------------------------------------
-- 🧍 TAB: Player (clear separation)
------------------------------------------------------
Tabs.Player:AddParagraph({ Title = "🛡️ Protection", Content = "Bật các chế độ bảo vệ." })

-- Anti Void
Tabs.Player:AddButton({
    Title = "Anti Void",
    Description = "Tạo lớp sàn dưới map để tránh rơi.",
    Callback = function()
        local ok, err = pcall(function()
            if workspace:FindFirstChild("BLong_AntiVoid") then workspace.BLong_AntiVoid:Destroy() end
            local p = Instance.new("Part")
            p.Name = "BLong_AntiVoid"
            p.Size = Vector3.new(2000,1,2000)
            p.Position = Vector3.new(0,-10,0)
            p.Anchored = true
            p.CanCollide = true
            p.BrickColor = BrickColor.new("Bright blue")
            p.Parent = workspace
        end)
        if ok then Fluent:Notify({ Title="Anti Void", Content="Đã bật lớp bảo vệ!", Duration=3 }) end
        if not ok then Fluent:Notify({ Title="Anti Void - Lỗi", Content=tostring(err), Duration=4 }) end
    end
})

-- Anti AFK
Tabs.Player:AddButton({
    Title = "Anti AFK",
    Description = "Ngăn bị kick khi AFK.",
    Callback = function()
        local ok, err = pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end)
        if ok then Fluent:Notify({ Title="Anti AFK", Content="Đã kích hoạt!", Duration=3 }) end
        if not ok then Fluent:Notify({ Title="Anti AFK - Lỗi", Content=tostring(err), Duration=4 }) end
    end
})

-- Anti Kick (timed)
Tabs.Player:AddButton({
    Title = "Anti Kick (20 phút)",
    Description = "Bật anti-kick trong 20 phút.",
    Callback = function()
        task.spawn(function()
            for i = 1, 1200 do
                task.wait(1)
            end
            pcall(function() Fluent:Notify({ Title="Anti Kick", Content="Hết thời gian bảo vệ!", Duration=4 }) end)
        end)
        Fluent:Notify({ Title="Anti Kick", Content="Đã bật (20 phút).", Duration=3 })
    end
})

-- Power & Admin
Tabs.Player:AddParagraph({ Title = "❤️ Power & Admin Tools", Content = "Các công cụ quyền lực." })

Tabs.Player:AddButton({
    Title = "Infinite Health",
    Description = "Chạy script HP vô hạn (nếu script hợp lệ).",
    Callback = function()
        local ok, err = pcall(function()
            local src = game:HttpGet("https://raw.githubusercontent.com/ProBaconHub/DATABASE/refs/heads/main/99%20Nights%20in%20the%20Forest/Infinite%20Health.lua", true)
            local fn = loadstring(src)
            if fn then fn() end
        end)
        if ok then Fluent:Notify({ Title="Infinite Health", Content="Đã chạy.", Duration=3 }) end
        if not ok then Fluent:Notify({ Title="Infinite Health - Lỗi", Content=tostring(err), Duration=4 }) end
    end
})

Tabs.Player:AddButton({
    Title = "Infinite Yield",
    Description = "Mở Infinite Yield admin.",
    Callback = function()
        local ok, err = pcall(function()
            local src = game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source', true)
            local fn = loadstring(src)
            if fn then fn() end
        end)
        if ok then Fluent:Notify({ Title="Infinite Yield", Content="Đã chạy.", Duration=3 }) end
        if not ok then Fluent:Notify({ Title="Infinite Yield - Lỗi", Content=tostring(err), Duration=4 }) end
    end
})

-- Movement section
Tabs.Player:AddParagraph({ Title = "⚡ Movement", Content = "WalkSpeed, JumpPower, Fly, Noclip." })

Tabs.Player:AddSlider({
    Title = "WalkSpeed",
    Description = "Tốc độ di chuyển (16 - 300).",
    Default = 16, Min = 16, Max = 300,
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end
})

Tabs.Player:AddSlider({
    Title = "JumpPower",
    Description = "Độ cao nhảy (50 - 500).",
    Default = 50, Min = 50, Max = 500,
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end
})

Tabs.Player:AddButton({
    Title = "Fly",
    Description = "Mở module Fly GUI (nếu link còn hoạt động).",
    Callback = function()
        local ok, err = pcall(function()
            local src = game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt", true)
            local fn = loadstring(src)
            if fn then fn() end
        end)
        if not ok then Fluent:Notify({ Title = "Fly - Lỗi", Content = tostring(err), Duration = 4 }) end
    end
})

local noclipConnection = nil
Tabs.Player:AddToggle({
    Title = "Noclip",
    Description = "Bật/tắt xuyên vật thể (character only).",
    Default = false,
    Callback = function(state)
        local RunService = game:GetService("RunService")
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
})

Tabs.Player:AddParagraph({ Title = "📢 Thông Báo", Content = "⏳ Đang chờ cập nhật thêm chức năng mới. Bản V1.5." })

------------------------------------------------------
-- ⚙️ TAB: Settings
------------------------------------------------------
Tabs.Settings:AddDropdown({
    Title = "Theme",
    Default = "Midnight",
    Options = Fluent.Themes.Names,
    Callback = function(opt) Window:SetTheme(opt) end
})

Tabs.Settings:AddToggle({
    Title = "Acrylic",
    Default = true,
    Callback = function(state) Window:SetAcrylic(state) end
})

Tabs.Settings:AddToggle({
    Title = "Transparency",
    Default = false,
    Callback = function(state) Window:SetTransparency(state) end
})

Tabs.Settings:AddDropdown({
    Title = "Font GUI",
    Default = "FredokaOne",
    Options = {"FredokaOne","Gotham","Arial","SourceSans","Roboto"},
    Callback = function(opt) Window:SetFont(opt) end
})

Tabs.Settings:AddButton({
    Title = "Reset GUI",
    Description = "Nếu GUI lỗi, nhấn để xem hướng dẫn (re-execute script).",
    Callback = function()
        Fluent:Notify({ Title = "Reset GUI", Content = "Script không thể tự reload. Hãy dán lại script để reload.", Duration = 5 })
    end
})

------------------------------------------------------
-- 🔔 Final Notification
------------------------------------------------------
Fluent:Notify({ Title = "BLong Hub", Content = "🎉 Đã load BLong Hub (V1.5) — NiF tab active.", Duration = 4 })

-- EOF - BLong Hub V1.5
