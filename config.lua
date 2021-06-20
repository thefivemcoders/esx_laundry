Config              = {}
Config.MarkerType   = 22
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor  = {r = 0, g = 255, b = 0}
Config.ShowBlips   = true  

Config.RequiredCopsKoda  = 0

Config.TimeToWash    = 1 * 1000
Config.TimeToIron    = 1 * 1000
Config.TimeToPack    = 1  * 1000

Config.Locale = 'en'

Config.Zones = {
	WashingClothes =		{x = -358.1,	y = -51.7,	z = 54.42,	name = _U('wasing_clothes'),		sprite = 77,	color = 47},
	IroningClothes =	{x = -356.84,	y = -41.68,	z = 54.42,	name = _U('iron_clothes'), sprite = 77,	color = 47},
	PackClothes =		{x = -356.12,	y = -48.64,	z = 54.42,	name = _U('pack_ironed_cloths'), sprite = 77,	color = 47}
}
