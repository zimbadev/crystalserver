-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 100,
		multiplier = 30,
	},
	{
		minlevel = 101,
		maxlevel = 250,
		multiplier = 20,
	},
	{
		minlevel = 251,
		maxlevel = 400,
		multiplier = 12,
	},
	{
		minlevel = 401,
		maxlevel = 600,
		multiplier = 6,
	},
	{
    		minlevel = 601,
    		maxlevel = 800,
    		multiplier = 5,
    },
	{
    		minlevel = 801,
    		maxlevel = 999,
    		multiplier = 4,
    },
	{
    		minlevel = 1000,
    		maxlevel = 1999,
    		multiplier = 3,
    },
	{
		minlevel = 2000,
		multiplier = 2,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 15,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 10,
	},
	{
		minlevel = 81,
		maxlevel = 110,
		multiplier = 6,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 4,
	},
	{
		minlevel = 126,
		multiplier = 2,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 10,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 7,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 5,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 4,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 3,
	},
	{
		minlevel = 126,
		multiplier = 2,
	},
}
