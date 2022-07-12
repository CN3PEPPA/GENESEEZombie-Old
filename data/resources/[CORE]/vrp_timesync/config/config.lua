config = {}

config.standardWeather = 'EXTRASUNNY' -- [ Clima padrão do servidor ]--
config.startHour = 6 -- [ Hora inicial do servidor ]--
config.startMinutes = 20 -- [ Minuto inicial do servidor. ]--

config.climate = { -- [ Climas disponíveis para troca automatica ]--
    'EXTRASUNNY',
    'CLEAR',
    'CLOUDS',
    'CLEARING'
}

config.climateCommand = 'clima' -- [ Exemplo: /clima EXTRASUNNY | Comando para mudar o clima do servidor. ]--
config.timePermission = 'manager.permissao' -- [ Permissão para mudar as horas e o clima. ]--
config.changeHour = 'hora'
config.freeze = 'freezehora'
config.freezeWeather = 'freezeclima'

-- AvailableWeatherTypes: EXTRASUNNY, CLEAR, NEUTRAL, SMOG, FOGGY, OVERCAST, CLOUDS, CLEARING, RAIN, THUNDER, SNOW, BLIZZARD, SNOWLIGHT, XMAS, HALLOWEEN.
