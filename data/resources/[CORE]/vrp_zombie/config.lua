config = {}

-- Configuração da densidade de Zumbis. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.pedDensity = 1.0

-- Configuração da densidade de Veículos. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.vehicleDensity = 0.0

-- Configuração do tempo que os zumbis vão ser alertados após um tiro (em segundos)
config.shotAlertTime = 15

-- Configuração da vida dos zumbis (Vida padrão dos NPC's = 200)
config.zombieHealth = 1000

-- Configuração da distância em que os Zumbis vão ser alertados após um tiro ou buzina. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.shootDistanceAlert = 350.0

-- Configuração da distância em que os Zumbis vão ser alertados após o player passar com um carro. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.vehicleDistanceAlert = 90.0

-- Configuração da distância em que os Zumbis vão ser alertados após o player correr. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.runningDistanceAlert = 40.0

-- Configuração da distância padrão em que os Zumbis vão ser alertados. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.defaultDistanceAlert = 5.0

-- Configuração da velocidade em que os Zumbis vão até o Player. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.defaultDistanceAlert = 2.2

-- Configuração da Distância em que os Zumbis atacam o player. Precisa ser um float, EX: 0.0 / 0.5 / 1.0
config.defaultAttackDistance = 1.3

-- Configuração do Dano que os zumbis causam ao player a cada ataque. Precisa ser um inteiro EX: 2/5/10
config.defaultAttackDamage = math.random(40, 80)

-- Configuração da Velocidade do Zumbi. Precisa ser um inteiro EX: 2/5/10
config.defaultVelocity = 2.5

-- Lista de Sons dos Zumbis
config.zombieSounds = {"zombie_1", "zombie_2", "zombie_3", "zombie_4", "zombie_5", "zombie_6", "zombie_7", "zombie_8", "zombie_9", "zombie_9"}

-- Lista de Sons dos Zumbis                     
config.imunePlayers = {707, 5, 814}
