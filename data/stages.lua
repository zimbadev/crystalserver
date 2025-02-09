-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 8,
		multiplier = 1000,
	},
	{
		minlevel = 9,
		maxlevel = 20,
		multiplier = 600,
	},
	{
		minlevel = 21,
		maxlevel = 50,
		multiplier = 500,
	},
	{
		minlevel = 51,
		maxlevel = 100,
		multiplier = 400,
	},
	{
		minlevel = 101,
		multiplier = 800,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 150,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 100,
	},
	{
		minlevel = 81,
		maxlevel = 110,
		multiplier = 60,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 40,
	},
	{
		minlevel = 126,
		multiplier = 30,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 100,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 70,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 50,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 40,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 30,
	},
	{
		minlevel = 126,
		multiplier = 20,
	},
}
