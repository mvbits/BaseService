--========================================================= 
-- 加载常用模块
--=========================================================

local BasePath = Utility.GetBasePath() .. "/script/";
package.path = BasePath .. "_PLS/?.lua;" .. BasePath .. "SharedLib/?.lua;";


require("InitSharedLib")
require("PlayerLogicService")
require("Player/PlayerMgr")
require("DB/DBMgr")
require("Room/RoomMgr")

PlayerDataHelper    = require("Player/PlayerDataHelper");
PlayerHelper        = require("Player/PlayerHelper");
MsgLogin            = require("Msg/MsgLogin")
MsgRoom             = require("Msg/MsgRoom")

PLSConfig           = require("_PLSConfig")

RoomBase            = require("Room/RoomBase")
RoomDdz             = require("Games/PokerDdz/RoomDdz")



-- 主入口函数。从这里开始lua逻辑
function ServiceInit()

    print("Lua PLSConfig:");
    PrintTable(PLSConfig)
    
    MsgLogin:Init();
    MsgRoom:Init();
    
    RoomMgr:Init();
    DBMgr:Init();
    PlayerMgr:Init();
    PlayerLogicService:Init();
    
    RoomMgr:CreateRoom("RM_DDZ");

end

-- 游戏循环
function ServiceUpdate()
    TimerMgr:Update(math.floor(os.clock() * 1000));
end

function ServiceRelease()
    MsgLogin:Release();
    MsgRoom:Release();
    
    RoomMgr:Release();
    DBMgr:Release();
    PlayerLogicService:Release();

    print("Lua Release.");
end


--[[




--bash_path = "E:\\BaseService\\code\\EVA\\server\\script\\";
--package.path = bash_path .. "Framework\\?.lua;" .. bash_path .. "Framework\\Net\\?.lua;";

print(package.path);

local protobuf = require "protobuf"

addr = io.open( bash_path.."DataTable\\proto_msg.pb", "rb")
buffer = addr:read "*a"  
addr:close()  
  
protobuf.register(buffer)  

t = protobuf.decode("google.protobuf.FileDescriptorSet", buffer) 

player_info = {  
    name = "Alice",  
    pid = 12345,  
    view_player_list = {  
        { pid = 17712345678, head_portrait = 1 },  
        { pid = 17712345679, head_portrait = 2 },  
    },  
    level = 2
}


code = protobuf.encode("MsgPlayerInfo", player_info)
decode = protobuf.decode("MsgPlayerInfo" , code)

print(decode.name)
print(decode.pid)

for _,v in ipairs(decode.view_player_list) do
	print("\t"..v.pid, v.head_portrait)
end

]]