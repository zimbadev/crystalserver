-- ============================================================================
-- Echo Warden Portal - onStepIn for item 54133
-- Reads stored echoKind, removes the portal, runs the 3-outcome echo raid.
-- Only players trigger it.
-- ============================================================================

local echoPortal = MoveEvent()

function echoPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature and creature:getPlayer()
	if not player then
		return true
	end

	local kind = item:getCustomAttribute(EchoWarden.PORTAL_ATTR_KIND)
	if type(kind) ~= "string" or kind == "" then
		item:remove()
		return true
	end

	local center = Position(position.x, position.y, position.z)
	item:remove()
	center:sendMagicEffect(CONST_ME_AGONY)

	EchoWarden.runRaid(kind, center)
	return true
end

echoPortal:type("stepin")
echoPortal:id(54133)
echoPortal:register()
