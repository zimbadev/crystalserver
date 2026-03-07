local sporeField = MoveEvent()

function sporeField.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local percent = 0.10
    local maxHealth = player:getMaxHealth()
    local damage = math.floor(maxHealth * percent)
    doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_AGONY)

    return true
end

sporeField:id(43294)
sporeField:register()

local funghiField = MoveEvent()

function funghiField.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        if creature:isMonster() and creature:getName():lower() == "ichgahal" then
            creature:addHealth(13500)
            creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        end
        return true
    end

    local percent = 0.15
    local maxHealth = player:getMaxHealth()
    local damage = math.floor(maxHealth * percent)
    doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_AGONY)

    return true
end

funghiField:id(43295)
funghiField:register()

local config = {
    spore = {
        sporeFieldItem = 43294,
        funghiFieldItem = 43295,
        duration = 3000
    }
}

local createSpore = MoveEvent()
function createSpore.onStepOut(creature, position, fromPosition)
    if creature:isMonster() and creature:getName():lower() == "ichgahal" then
        local createdItem = Game.createItem(config.spore.sporeFieldItem, 1, fromPosition)
        if createdItem then
            addEvent(function()
                if createdItem and createdItem:isItem() then
                    createdItem:transform(config.spore.funghiFieldItem)
                    addEvent(function()
                        if createdItem and createdItem:isItem() then
                            createdItem:remove()
                        end
                    end, config.spore.duration)
                end
            end, config.spore.duration)
        end
    end
    return true
end

createSpore:aid(47949)
createSpore:type("stepout")
createSpore:register()
