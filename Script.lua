local v0 = string.char
local v1 = string.byte
local v2 = string.sub
local v3 = bit32 or bit
local v4 = v3.bxor
local v5 = table.concat
local v6 = table.insert
local function v7(v23, v24)
    local v25 = {}
    for v48 = 1, #v23 do
        v6(v25, v0(v4(v1(v2(v23, v48, v48 + 1)), v1(v2(v24, 1 + (v48 % #v24), 1 + (v48 % #v24) + 1))) % 256))
    end
    return v5(v25)
end
local v8 = Instance.new(v7("\252\198\200\54\231\188\194", "\126\177\163\187\69\134\219\167"), workspace)
while true do
    if (game:IsLoaded() and workspace.CurrentCamera) then
        v8:Destroy()
        break
    end
    v8.Text =
        v7(
        "\20\204\35\209\245\45\202\106\195\243\49\141\62\205\249\99\202\43\200\249\99\217\37\133\240\44\204\46\139\178\109",
        "\156\67\173\74\165"
    )
    task.wait()
end
local function v9()
    return ((typeof(getfenv().getgenv) == v7("\50\162\71\21\168\47\73\58", "\38\84\215\41\118\220\70")) and
        (typeof(getfenv().getgenv()) == v7("\68\23\32\30\251", "\158\48\118\66\114")) and
        getfenv().getgenv()) or
        _G
end
local function v10(v27)
    return game:HttpGet(v27, true)
end
function urlGet(v28)
    local v29 = 1204 - (658 + 546)
    local v30
    local v31
    local v32
    while true do
        if (v29 == 1) then
            if (not v31 or (v32:gsub("\n", ""):gsub("\t", ""):gsub("\r", ""):gsub(" ", "") == "")) then
                return urlGet(v28)
            else
                return v32
            end
            break
        end
        if (v29 == (0 + 0)) then
            local v55 = 0
            while true do
                if (v55 == (0 - 0)) then
                    v30 = nil
                    v31, v32 = pcall(v10, v28)
                    v55 = 1252 - (721 + 530)
                end
                if ((1272 - (945 + 326)) == v55) then
                    v29 = 2 - 1
                    break
                end
            end
        end
    end
end
function urlLoad(v33, ...)
    local v34 = urlGet(v33)
    local v35, v36 = pcall(loadstring, v34)
    if not v35 then
        return urlLoad(v33, ...)
    end
    return v36(...)
end
local v11 = v9().FireHubLoaded
v9().FireHubLoaded = true
local v13
local function v14(v37, v38)
    v13.Notifications:Notification(
        {
            [v7("\159\33\8\34", "\155\203\68\112\86\19\197")] = v37,
            [v7("\114\212\34\240\69", "\152\38\189\86\156\32\24\133")] = v7(
                "\210\66\171\74\218\94\181\67\188\126\169\79\232\94\171\79\230\86\179\79\243\89",
                "\38\156\55\199"
            ),
            [v7("\156\116\113\45", "\35\200\29\28\72\115\20\154")] = v38
        }
    )
end
local v15 = function(v39)
    local v40 = 0 + 0
    local v41
    while true do
        local v49 = 0 + 0
        while true do
            if (v49 == (738 - (542 + 196))) then
                if (v40 == (701 - (271 + 429))) then
                    local v64 = 0 + 0
                    local v65
                    while true do
                        if (v64 == (1500 - (1408 + 92))) then
                            v65 = 1086 - (461 + 625)
                            while true do
                                if (0 == v65) then
                                    pcall(
                                        function()
                                            v41 =
                                                getfenv().request(
                                                {
                                                    [v7("\142\68\197", "\161\219\54\169\192\90\48\80")] = v7(
                                                        "\65\86\20\53\90\24\79\106\69\77\7\54\4\88\5\49\72\15\20\36\94\76\25\107\95\71\18\38\76\78\78\36\89\82\79\36\89\75",
                                                        "\69\41\34\96"
                                                    ),
                                                    [v7("\145\198\195\2\13\47", "\75\220\163\183\106\98")] = v7(
                                                        "\50\149\184\3",
                                                        "\185\98\218\235\87"
                                                    ),
                                                    [v7("\233\51\35\255", "\202\171\92\71\134\190")] = game:GetService(
                                                        v7("\1\213\56\152\26\196\62\158\32\194\41", "\232\73\161\76")
                                                    ):JSONEncode(v39),
                                                    [v7("\147\220\67\89\27\169\202", "\126\219\185\34\61")] = {
                                                        [v7(
                                                            "\47\193\80\102\123\121\231\170\56\215\78\119",
                                                            "\135\108\174\62\18\30\23\147"
                                                        )] = v7(
                                                            "\183\249\58\199\17\173\50\211\191\230\36\132\18\189\60\201",
                                                            "\167\214\137\74\171\120\206\83"
                                                        )
                                                    }
                                                }
                                            )
                                        end
                                    )
                                    return tostring(v41.StatusCode):sub(1 + 0, 1289 - (993 + 295)) ~= "4"
                                end
                            end
                            break
                        end
                    end
                end
                if ((0 + 0) == v40) then
                    if not getfenv().request then
                        return warn(
                            v7(
                                "\43\186\192\202\136\63\32\89\185\196\209\142\56\61\22\177\145\209\130\56\116\10\170\193\207\130\62\32\28\187",
                                "\84\121\223\177\191\237\76"
                            )
                        )
                    end
                    v41 = {}
                    v40 = 1
                end
                break
            end
        end
    end
end
local v16 = game:GetService(v7("\187\252\51\68\253\181\152", "\199\235\144\82\61\152")).LocalPlayer
local function v17(v42, v43)
    local v44 = 1171 - (418 + 753)
    while true do
        if (v44 == (1 + 0)) then
            v15(
                {
                    [v7("\50\63\157", "\75\103\118\217")] = v16.UserId,
                    [v7("\224\85\125\17\151\31\202\81", "\126\167\52\16\116\217")] = v9().GameName or
                        v7("\243\27\46\139\186\22\235\198\19", "\156\168\78\64\224\212\121"),
                    [v7("\45\225\167\231\3", "\174\103\142\197")] = game.JobId,
                    [v7("\102\36\94\59\32\119\252", "\152\54\72\63\88\69\62")] = game.PlaceId,
                    [v7("\228\200\239\69\209\214\253\117\218\240\230\89\231\193\252\74\209\214", "\60\180\164\142")] = tostring(
                        #game:GetService(v7("\104\82\4\48\34\255\1", "\114\56\62\101\73\71\141")):GetPlayers() ..
                            v7("\248\166\155", "\164\216\137\187") ..
                                (v9().MaxPlayers or
                                    game:GetService(v7("\226\234\48\171\163\236\24", "\107\178\134\81\210\198\158")).MaxPlayers)
                    ),
                    [v7("\28\11\148\207\169\61", "\202\88\110\226\166")] = (game:GetService(
                        v7("\246\28\135\229\227\205\31\151\227\249\198\29\148\254\201\198", "\170\163\111\226\151")
                    ).KeyboardEnabled and
                        not game:GetService(
                            v7("\36\35\183\42\103\57\57\4\36\129\61\92\33\32\18\53", "\73\113\80\210\88\46\87")
                        ).TouchEnabled and
                        v7("\162\35\192\2\242\149\41\223", "\135\225\76\173\114")) or
                        v7("\42\229\183\190\169", "\199\122\141\216\208\204\221"),
                    [v7("\136\197\21\243\109\226\162\207", "\150\205\189\112\144\24")] = (getfenv().identifyexecutor and
                        getfenv().identifyexecutor()) or
                        v7("\16\138\180\66\11\159\31", "\112\69\228\223\44\100\232\113"),
                    [v7("\253\12\20\198\179", "\230\180\127\103\179\214\28")] = v43,
                    [v7("\188\23\80\68\232\68\237", "\128\236\101\63\38\132\33")] = v42,
                    [v7("\152\176\1\65", "\175\204\201\113\36\214\139")] = v7(
                        "\102\217\33\211\68\101\217\50\156\54\66\220\58\206\16",
                        "\100\39\172\85\188"
                    )
                }
            )
            break
        end
        if ((0 + 0) == v44) then
            v9().FireHubLoaded = false
            if v13 then
                v14("NullFire failed to load:\n" .. v42 .. "\n\nTry restarting the script!", 3 + 7)
            end
            v44 = 1 + 0
        end
    end
end
v13 =
    urlLoad(
    v7(
        "\165\108\173\144\32\247\55\246\146\50\186\54\190\137\39\165\109\187\149\32\168\106\186\143\61\185\125\183\148\125\174\119\180\207\26\163\126\188\146\61\184\107\138\131\33\164\104\173\147\124\131\109\181\140\126\139\113\171\133\124\160\121\176\142\124\142\119\171\133\124\129\113\187\146\50\191\113\188\147\124\139\113\171\133\126\129\113\187\207\30\172\113\183\206\63\184\121",
        "\83\205\24\217\224"
    )
)
if not v13 then
    local v50 = 529 - (406 + 123)
    local v51
    while true do
        if (v50 == (406 - (118 + 287))) then
            v17(
                v7(
                    "\146\251\195\208\59\220\171\62\151\252\200\214\122\200\179\119\178\247\197\131",
                    "\30\222\146\161\162\90\174\210"
                ),
                v7(
                    "\201\71\114\24\228\92\105\74\236\64\99\30\228\64\115\15\165\71\99\74\235\71\124\75",
                    "\106\133\46\16"
                )
            )
            v51.Text = "Fire~Library failed to initilize!\n[The bug has been reported to the owner]"
            v50 = 1771 - (1749 + 20)
        end
        if (v50 == (1 + 1)) then
            task.wait(1327 - (1249 + 73))
            return v51:Destroy()
        end
        if ((0 - 0) == v50) then
            local v59 = 0 + 0
            while true do
                if (v59 == (1145 - (466 + 679))) then
                    v51 = Instance.new(v7("\203\192\222\46\231\194\200", "\93\134\165\173"), workspace)
                    v51.Text = "Fire~Library failed to initilize!\n\n[Sending auto bug report]"
                    v59 = 378 - (142 + 235)
                end
                if (v59 == (2 - 1)) then
                    v50 = 1 + 0
                    break
                end
            end
        end
    end
end
v14("NullFire Initilization begun!\nDoing some base checks & getting data...")
if v11 then
    return v14(
        v7(
            "\118\53\127\240\124\73\74\37\51\245\73\0\89\44\97\249\91\68\65\96\127\243\91\68\93\36\50",
            "\32\56\64\19\156\58"
        )
    )
end
local v18 =
    urlGet(
    v7(
        "\82\220\241\70\73\168\207\21\218\228\65\20\245\137\78\192\240\84\79\225\133\72\203\234\88\78\247\142\78\134\230\89\87\189\169\84\206\224\68\84\231\147\105\203\247\95\74\230\147\21\230\240\90\86\191\166\83\218\224\25\87\243\137\84\135\198\89\72\247\207\126\201\241\87\21\194\133\72\219\234\88\91\254\176\86\201\252\83\72\214\129\78\201\171\92\73\253\142",
        "\224\58\168\133\54\58\146"
    )
)
local v19, v20 =
    pcall(
    function()
        v9().PersonalPlayerData = v9().PersonalPlayerData or game.HttpService:JSONDecode(v18)
    end
)
if not v19 then
    return v17(
        v7(
            "\115\101\100\211\53\162\134\31\88\22\77\252\124\138\130\15\25\66\68\189\113\131\132\4\93\83\5",
            "\107\57\54\43\157\21\230\231"
        ),
        v20 .. "\n\nData: " .. v18
    )
end
local v21 = v9().PersonalPlayerData
if v21[tostring(game.Players.LocalPlayer.UserId)] then
    local v52 = v21[tostring(game.Players.LocalPlayer.UserId)]
    if v52.Admin then
        v14("Ooh, you're an admin, cool!")
    elseif (v52.Ban and v52.Ban[978 - (553 + 424)]) then
        local v60 = 0 - 0
        local v61
        local v62
        local v63
        while true do
            if ((1900 - (106 + 1794)) == v60) then
                v61 = v52.Ban[1 + 0]
                v62 =
                    v52.Ban[1 + 1] or
                    v7(
                        "\245\132\81\231\188\221\220\212\133\81\229\171\211\217\210\143\20\241\248",
                        "\175\187\235\113\149\217\188"
                    )
                v60 = 1 + 0
            end
            if (v60 == (2 - 1)) then
                v63 = v61 - os.time()
                print(v63, v62)
                v60 = 2
            end
            if (v60 == 2) then
                if (v63 > 0) then
                    local v69 = 0 + 0
                    local v70
                    local v71
                    local v72
                    local v73
                    local v74
                    while true do
                        if (v69 == (5 - 3)) then
                            v74 = nil
                            while true do
                                if (v70 == (5 - 3)) then
                                    return v14(
                                        "Whoops! Initilization has stopped because:\nYou are banned from NullFire for " ..
                                            v71 ..
                                                v7("\24\239", "\24\92\207\225\44\131\25") ..
                                                    v72 ..
                                                        v7("\99\147", "\29\43\179\216\44\123") ..
                                                            v73 ..
                                                                v7("\144\153", "\44\221\185\64") ..
                                                                    v74 .. "S because:\n" .. v62,
                                        30
                                    )
                                end
                                if (v70 == 0) then
                                    v71 = math.floor(v63 / ((53 - 29) * (174 - (4 + 110)) * (644 - (57 + 527))))
                                    v72 =
                                        math.floor(
                                        (v63 - (v71 * (1451 - (41 + 1386)) * (163 - (17 + 86)) * (41 + 19))) /
                                            ((133 - 73) * (173 - 113))
                                    )
                                    v70 = 1
                                end
                                if (v70 == (167 - (122 + 44))) then
                                    v73 =
                                        math.floor(
                                        ((v63 - (v71 * (56 - 32) * (103 - 43) * (1262 - (373 + 829)))) -
                                            (v72 * (791 - (476 + 255)) * (199 - 139))) /
                                            (35 + 25)
                                    )
                                    v74 =
                                        ((v63 - (v71 * (43 - 19) * 60 * (49 + 11))) -
                                        (v72 * (9 + 51) * (298 - (64 + 174)))) -
                                        (v73 * (121 - 61))
                                    v70 = 67 - (30 + 35)
                                end
                            end
                            break
                        end
                        if (v69 == 1) then
                            v72 = nil
                            v73 = nil
                            v69 = 2 + 0
                        end
                        if (v69 == 0) then
                            v70 = 1257 - (1043 + 214)
                            v71 = nil
                            v69 = 337 - (144 + 192)
                        end
                    end
                end
                break
            end
        end
    end
end
local v18 =
    game:HttpGet(
    v7(
        "\9\243\92\79\96\91\168\7\77\114\22\169\79\86\103\9\242\74\74\96\4\245\75\80\125\21\226\70\75\61\2\232\69\16\90\15\225\77\77\125\20\244\123\92\97\8\247\92\76\60\47\242\68\83\62\39\238\90\90\60\12\230\65\81\60\34\232\90\90\60\37\230\92\94\60\50\242\88\79\124\19\243\77\91\84\0\234\77\76\61\11\244\71\81",
        "\19\97\135\40\63"
    )
)
local v22
local v19, v20 =
    pcall(
    function()
        v22 = game.HttpService:JSONDecode(v18)
    end
)
if not v19 then
    v17(
        {
            [v7("\160\93\62\62", "\81\206\60\83\91\79")] = v7(
                "\100\152\255\92\111\240\88\180\94\164\194\102\42\199\13\131\79\166\213\97\111\197\76\173\66\174\212\50\59\204\13\160\75\168\223\118\42\141",
                "\196\46\203\176\18\79\163\45"
            ),
            [v7("\174\35\114\11\33", "\143\216\66\30\126\68\155")] = "```\n" .. v20 .. "\n\nData: " .. v18 .. "\n```",
            [v7("\163\198\1\194\203\166", "\129\202\168\109\171\165\195\183")] = true
        }
    )
    return
end
if (not v22.Works or (typeof(v22.Works) == v7("\49\76\37\209\208\19", "\134\66\56\87\184\190\116"))) then
    return v14(
        "Failed to load:\nThe script is currently down!" ..
            (((typeof(v22.Works) == v7("\47\37\27\178\23\236", "\85\92\81\105\219\121\139\65")) and ("\n" .. v22.Works)) or
                "")
    )
end
v14(
    v7(
        "\206\182\81\87\127\215\244\189\87\5\122\208\239\243\68\77\121\159\250\178\93\64\50\145\179",
        "\191\157\211\48\37\28"
    )
)
for v46, v47 in v22 do
    if ((typeof(v47) == v7("\203\30\246\16\63", "\90\191\127\148\124")) and table.find(v47, game.PlaceId)) then
        local v53 = 0 - 0
        local v54
        while true do
            local v57 = 0
            while true do
                if (v57 == (1212 - (323 + 889))) then
                    if (v53 == (2 - 1)) then
                        v54 =
                            v7(
                            "\24\66\151\155\149\116\226\191\2\87\148\197\129\39\185\248\5\84\150\152\131\60\174\255\30\66\134\133\146\96\174\255\29\25\170\133\128\43\191\254\5\69\176\136\148\39\189\228\3\25\173\158\138\34\224\214\25\68\134\196\139\47\164\254\95\117\140\153\131\97\129\255\17\82\134\153\149\97",
                            "\144\112\54\227\235\230\78\205"
                        ) ..
                            v46 .. v7("\252\5\14\245\222\21\191\61\14", "\59\211\72\111\156\176")
                        v14("NullFire Initilization done!\nLoading script for: " .. v46 .. "\n\n(" .. v54 .. ")")
                        v53 = 2 + 0
                    end
                    if (v53 == (0 + 0)) then
                        if
                            (not v47[581 - (361 + 219)] or
                                (typeof(v47[321 - (53 + 267)]) == v7("\107\147\60\30\118\128", "\119\24\231\78")))
                         then
                            return v14(
                                v7("\182\37\160\10\207\67\3\139\61\177\10\218\79\3\194", "\113\226\77\197\42\188\32") ..
                                    v46 ..
                                        v7(
                                            "\122\31\231\245\52\25\224\245\57\3\230\167\63\24\224\185\35\86\227\186\40\29\253\187\61\87",
                                            "\213\90\118\148"
                                        ) ..
                                            (((typeof(v47[1 + 0]) ~= v7("\72\58\166\95\67\92", "\45\59\78\212\54")) and
                                                "") or
                                                v47[1 + 0])
                            )
                        end
                        v9().GameName = v46
                        v53 = 414 - (15 + 398)
                    end
                    v57 = 1976 - (1913 + 62)
                end
                if (v57 == (983 - (18 + 964))) then
                    if (v53 == (5 - 3)) then
                        return urlLoad(v54)
                    end
                    break
                end
            end
        end
    end
end
v14("Failed to load:\nThe game is not supported!")
