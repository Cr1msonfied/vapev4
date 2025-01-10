local collection = game:GetService('CollectionService') :: CollectionService;
local lplr = game.Players.LocalPlayer :: Player;
local tween = game:GetService('TweenService') :: TweenService

--> BedTP <--
local isshield: (Model) -> boolean = function(obj: Model)
    return obj:GetAttribute('BedShieldEndTime') and obj:GetAttribute('BedShieldEndTime') > workspace:GetServerTimeNow() 
end :: boolean
local getbed: () -> Model? = function()
    for i: number, v: Model? in collection:GetTagged('bed') do
        if not isshield(v) and v.Bed.BrickColor ~= lplr.TeamColor then
            return v;
        end;
    end;
end :: Model?;

local bed = getbed() :: Model?;
assert(bed, 'lmao');
pcall(function()
    lplr.Character.Humanoid.Health = 0
end)
local con;
con = lplr.CharacterAdded:Connect(function(v)
    con:Disconnect();
    task.wait(0.2)
    tween:Create(v.PrimaryPart, TweenInfo.new(0.75), {CFrame = bed.Bed.CFrame + Vector3.new(0, 40, 0)}):Play();
end);
