local trapMerchant = MoveEvent()

function trapMerchant.onStepIn(creature, item, position, fromPosition)
	if not creature or not creature:isMonster() then
		return true
	end

	if creature:getName():lower() ~= "travelling merchant" then
		return true
	end

	creature:getPosition():sendMagicEffect(CONST_ME_STONES)
	creature:remove()
	item:transform(12189)

	return true
end

trapMerchant:type("stepin")
trapMerchant:id(12187)
trapMerchant:register()
