groups = {}

groups.masterGroup = 'manager'

groups.list = {
    ['manager'] = {
        _config = {
            title = 'Manager',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        "player.wall",
        "manager.permissao",
        "imunidade.permissao",
        "wall.permissao",
        "spawner.permissao",
        "prop.permissao"
    },

    ['administrador'] = {
        _config = {
            title = 'Administrador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        "player.wall",
        'administrador.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['off-administrador'] = {
        _config = {
            title = 'Administrador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        "player.wall",
        'off-administrador.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"

    },

    ['desenvolvedor'] = {
        _config = {
            title = 'Desenvolvedor(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        "player.wall",
        'desenvolvedor.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['off-desenvolvedor'] = {
        _config = {
            title = 'Desenvolvedor(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        "player.wall",
        'off-desenvolvedor.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['moderador'] = {
        _config = {
            title = 'Moderador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        'moderador.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },
    ['off-moderador'] = {
        _config = {
            title = 'Moderador(a)',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        'off-moderador.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['suporte'] = {
        _config = {
            title = 'Suporte',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        'suporte.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },
    ['off-suporte'] = {
        _config = {
            title = 'Suporte',
            gtype = 'staff'
        },
        "player.blips",
        "player.spec",
        "player.noclip",
        "player.secret",
        'off-suporte.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['aprovador-al'] = {
        _config = {
            title = 'Aprovador AL',
            gtype = 'staff'
        },
        'aprovador-al.permissao',
        "imunidade.permissao",
        "wall.permissao",
        "prop.permissao"
    },

    ['aurora'] = {
        _config = {
            title = 'Funcionário de Aurora',
            gtype = 'staff'
        },
        "aurora.permissao",
    },
    ['off-aurora'] = {
        _config = {
            title = 'Funcionário de Aurora',
            gtype = 'staff'
        },
        "off-aurora.permissao",
    }
}
