local exerciseCharges = 1200
local coin = 1
local rewardStorage = 29998

local reward = TalkAction("!g0i0f0t")

function reward.onSay(player, words, param)
    if player then
        if player:getStorageValue(rewardStorage) >= os.time() then
            player:sendCancelMessage("You already collected your daily reward.")
        else
            player:setStorageValue(rewardStorage, os.time() + 24 * 60 * 60)
            player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
            if player:isSorcerer() then
                player:addItem(28557, exerciseCharges)
                player:addItem(3043, coin)
            elseif player:isDruid() then
                player:addItem(28556, exerciseCharges)
                player:addItem(3043, coin)
            elseif player:isPaladin() then
                player:addItem(28555, exerciseCharges)
                player:addItem(3043, coin)
            elseif player:isKnight() then
                if player:getSkillLevel(SKILL_SWORD) > player:getSkillLevel(SKILL_CLUB) and
                player:getSkillLevel(SKILL_SWORD) > player:getSkillLevel(SKILL_AXE) then
                    player:addItem(28552, exerciseCharges)
                    player:addItem(3043, coin)
                elseif player:getSkillLevel(SKILL_CLUB) > player:getSkillLevel(SKILL_SWORD) and
                    player:getSkillLevel(SKILL_CLUB) > player:getSkillLevel(SKILL_AXE) then
                    player:addItem(28554, exerciseCharges)
                    player:addItem(3043, coin)
                elseif player:getSkillLevel(SKILL_AXE) > player:getSkillLevel(SKILL_SWORD) and
                    player:getSkillLevel(SKILL_AXE) > player:getSkillLevel(SKILL_CLUB) then
                    player:addItem(28553, exerciseCharges)
                    player:addItem(3043, coin)
                end
            end
        end
    end
end

reward:groupType("normal")
reward:register()