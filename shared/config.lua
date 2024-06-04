Config = {
    Framework = 'qb', -- qb | qbx | standalone
    Interiors = { -- All Interiors | Todos os interiores
        {
            location = vec3(0.0,0.0,0.0), -- Inside interior | Dentro do interior
            dimension = 90000, -- Random number to user be set
            rooms = { -- To get this ids use the "interiorid" command | Para pegar esses ids use o comando "interiorid"
                ['1'] = true
            } 
        },
    }
}