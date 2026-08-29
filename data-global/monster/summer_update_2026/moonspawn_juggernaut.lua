local mType = Game.createMonsterType("Moonspawn Juggernaut")
local monster = {}

monster.description = "a moonspawn juggernaut"
monster.experience = 10000
monster.outfit = {
	lookType = 1972,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2829
-- TODO(bestiary): a wiki nao publica classe, dificuldade nem ocorrencia desta criatura. O
-- raceId 2829 vem do staticdata (e raceId ja registra na bestiary, ver addBestiaryList), entao
-- ela esta na bestiary; os numeros abaixo seguem os irmaos Blightspitter/Oozecrown e nao sao
-- oficiais. Occurrence 2 (raro) porque so aparece na raid de 30 em 30 minutos.
monster.Bestiary = {
	class = "Slime",
	race = BESTY_RACE_SLIME,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 2,
	Locations = "Thalassara Surroundings",
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "venom"
-- TODO(items): a wiki marca "Loot: Nenhum" e nao existe "dead moonspawn juggernaut" no
-- items.xml (a leva de corpses do commit ca43ed0d nao cobriu esta criatura, que ainda nao
-- tinha arquivo). Fica 0 - sem corpo - ate o id do cliente ser levantado.
monster.corpse = 0
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	-- a wiki marca 'nao e possivel bloquear o respawn desta criatura'
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyable = true,
	isPreyExclusive = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "<Druuuhhh>", yell = false },
	{ text = "<Gloooosh>", yell = false },
	{ text = "<Krrrshhhh>", yell = false },
}

-- A wiki marca "Loot: Nenhum".
monster.loot = {}

-- TODO(balance): a wiki lista apenas as habilidades (fisico e earth) sem os valores de dano,
-- que aparecem como "()". Os numeros abaixo sao escalados pelo tier da criatura e nao sao
-- oficiais.
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -520 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -330, maxDamage = -580, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false },
	{ name = "combat", interval = 2500, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -550, range = 7, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_CARNIPHILA, target = true },
}

monster.defenses = {
	defense = 80,
	armor = 80,
	mitigation = 3.55,
}

-- A wiki marca 100% em todos os elementos: sem resistencia nem fraqueza.
monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "invisible", condition = true },
}

mType:register(monster)
