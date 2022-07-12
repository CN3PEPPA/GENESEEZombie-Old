vRP.prepare('vRP/create_vrp_logs', [[
    CREATE TABLE IF NOT EXISTS `logs` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `user_id` int(11) NOT NULL,
        `message` varchar(255) NOT NULL,
        `x` float(24) NOT NULL DEFAULT 0,
        `y` float(24) NOT NULL DEFAULT 0,
        `z` float(24) NOT NULL DEFAULT 0,
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])

vRP.prepare('vRP/create_vrp_animals', [[
    CREATE TABLE IF NOT EXISTS `vrp_animals` (
            `user_id` int(11) NOT NULL,
            `model_hash` varchar(255) NOT NULL,
            `x` float(50) DEFAULT 0,
            `y` float(50) DEFAULT 0,
            `z` float(50) DEFAULT 0,
            `health` int(11) DEFAULT 100,
            `hungry` int(11) DEFAULT 100,
            `thirst` int(11) DEFAULT 100
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_buildings', [[
    CREATE TABLE IF NOT EXISTS `vrp_buildings` (
            `model_hash` int(11) DEFAULT 0,
            `x` float(50) DEFAULT 0,
            `y` float(50) DEFAULT 0,
            `z` float(50) DEFAULT 0,
            `heading` float(50) DEFAULT 0
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_chest_backup', [[
    CREATE TABLE IF NOT EXISTS `chest_backup` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `user_id` int(11) NOT NULL,
            `value` text NOT NULL,
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_users', [[
        CREATE TABLE IF NOT EXISTS `vrp_users` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `level` int(50) NOT NULL DEFAULT '1',
            `experience` int(50) NOT NULL DEFAULT '0',
            `whitelisted` tinyint(1) DEFAULT NULL,
            `banned` tinyint(1) DEFAULT NULL,
            `ip` varchar(255) NOT NULL DEFAULT '0.0.0',
            `last_login` varchar(255) NOT NULL DEFAULT '0.0.0',
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_user_buildings', [[
    CREATE TABLE IF NOT EXISTS `vrp_user_buildings` (
            `id` int(11) NOT NULL AUTO_INCREMENT,        
            `user_id` int(11) NOT NULL,
            `pass` varchar(50) DEFAULT NULL,
            `type` varchar(255) NOT NULL,
            `model_hash` int(11) DEFAULT 0,
            `value` text NOT NULL,
            `x` float(50) DEFAULT 0,
            `y` float(50) DEFAULT 0,
            `z` float(50) DEFAULT 0,
            `heading` float(50) DEFAULT 0,
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_user_data', [[
        CREATE TABLE IF NOT EXISTS `vrp_user_data` (
            `user_id` int(11) NOT NULL,
            `dkey` varchar(100) NOT NULL,
            `dvalue` text DEFAULT NULL,
            PRIMARY KEY (`user_id`,`dkey`),
            CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_user_identities', [[
        CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
            `user_id` int(11) NOT NULL,
            `registration` varchar(20) DEFAULT NULL,
            `firstname` varchar(50) DEFAULT NULL,
            `name` varchar(50) DEFAULT NULL,
            `age` int(11) DEFAULT NULL,
            PRIMARY KEY (`user_id`),
            KEY `registration` (`registration`),
            CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_user_ids', [[
        CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
            `identifier` varchar(100) NOT NULL,
            `user_id` int(11) DEFAULT NULL,
            PRIMARY KEY (`identifier`),
            KEY `fk_user_ids_users` (`user_id`),
            CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_user_vehicles_parts', [[
        CREATE TABLE IF NOT EXISTS `vrp_user_vehicles_parts` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `vehicle` varchar(100) NOT NULL,
                `plate` varchar(100) NOT NULL,
                `parts` longtext NOT NULL,
                `mileage` float NOT NULL DEFAULT 0,
                PRIMARY KEY (`id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
        ]])

vRP.prepare('vRP/create_vrp_user_vehicles_trunk', [[
        CREATE TABLE IF NOT EXISTS `vrp_user_vehicles_trunk` (
            `dkey` varchar(100) NOT NULL,
            `dvalue` text DEFAULT NULL,
            PRIMARY KEY (`dkey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]])

vRP.prepare('vRP/create_vrp_priority', [[
        CREATE TABLE IF NOT EXISTS `vrp_priority` (
            `priority` int(10) DEFAULT NULL,
            `steam` varchar(50) DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

CreateThread(function()
    vRP.execute('vRP/create_vrp_logs')

    vRP.execute('vRP/create_vrp_priority')

    vRP.execute('vRP/create_vrp_animals')
    vRP.execute('vRP/create_vrp_buildings')
    vRP.execute('vRP/create_vrp_users')
    vRP.execute('vRP/create_vrp_user_buildings')
    vRP.execute('vRP/create_chest_backup')
    vRP.execute('vRP/create_vrp_user_data')
    vRP.execute('vRP/create_vrp_user_identities')
    vRP.execute('vRP/create_vrp_user_ids')
    vRP.execute('vRP/create_vrp_user_vehicles_parts')
    vRP.execute('vRP/create_vrp_user_vehicles_trunk')
end)
