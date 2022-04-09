minetest.register_chatcommand(
    "sm",
    {
        params = "<text>",
        description = "Dumps the variable to the user",
        privs = {interact = true},
        func = function(name, param)
            local can_use = minetest.check_player_privs(name, {interact = true})
 
            if param == "" then
                return false, "Need message"
            end
 
            local code = "minetest.chat_send_player('"..name.."',dump("..param.."))"
            minetest.log("action","[sm] ("..name.." used sm) " .. param)
 
            local func, err = loadstring(code)
            if not func then  -- Syntax error
                return false,err
            end
            local ok, err = pcall(func)
            if not ok then  -- Runtime error
                return false,err
            end
            return true
        end
    }
)
