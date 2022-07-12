vRP.prepare("vRP/get_priority", "SELECT * FROM vrp_priority")

vRP.prepare("vRP/create_user",
    "INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")

vRP.prepare("vRP/add_identifier", "INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")

vRP.prepare("vRP/userid_byidentifier", "SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")

vRP.prepare("vRP/set_userdata", "REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")

vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")

vRP.prepare("vRP/set_srvdata", "REPLACE INTO vrp_user_vehicles_trunk(dkey,dvalue) VALUES(@key,@value)")

vRP.prepare("vRP/get_srvdata", "SELECT dvalue FROM vrp_user_vehicles_trunk WHERE dkey = @key")

vRP.prepare("vRP/set_srvdatachest", "UPDATE vrp_user_buildings SET value = @value WHERE user_id = @user_id")

vRP.prepare("vRP/get_srvdatachest", "SELECT value FROM vrp_user_buildings WHERE user_id = @user_id")

vRP.prepare("vRP/get_banned", "SELECT banned FROM vrp_users WHERE id = @user_id")

vRP.prepare("vRP/set_banned", "UPDATE vrp_users SET banned = @banned WHERE id = @user_id")

vRP.prepare("vRP/get_whitelisted", "SELECT whitelisted FROM vrp_users WHERE id = @user_id")

vRP.prepare("vRP/set_whitelisted", "UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")

vRP.prepare("vRP/update_ip", "UPDATE vrp_users SET ip = @ip WHERE id = @uid")

vRP.prepare("vRP/update_login", "UPDATE vrp_users SET last_login = @ll WHERE id = @uid")

vRP.prepare("vRP/get_user_identity", "SELECT * FROM vrp_user_identities WHERE user_id = @user_id")

vRP.prepare("vRP/get_user_discord", "SELECT discord FROM vrp_users WHERE id = @user_id")

vRP.prepare("vRP/init_user_identity",
    "INSERT IGNORE INTO vrp_user_identities(user_id,registration,firstname,name,age) VALUES(@user_id,@registration,@firstname,@name,@age)")

vRP.prepare("vRP/update_user_identity",
    "UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age, registration = @registration WHERE user_id = @user_id")

vRP.prepare("vRP/get_userbyreg", "SELECT user_id FROM vrp_user_identities WHERE registration = @registration")

vRP.prepare("vRP/update_user_first_spawn",
    "UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

vRP.prepare("vRP/get_level", "SELECT level FROM vrp_users WHERE id = @user_id")

vRP.prepare("vRP/get_experience", "SELECT experience FROM vrp_users WHERE id = @user_id")

vRP.prepare("vRP/set_experience", "UPDATE vrp_users SET experience = @experience WHERE id = @user_id")

vRP.prepare("vRP/convert_experience", "UPDATE vrp_users SET level = @level WHERE id = @id")

vRP.prepare("vRP/get_weight", "SELECT type FROM vrp_user_buildings WHERE user_id = @user_id")
