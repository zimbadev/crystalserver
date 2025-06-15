-- Tabela konfiguracyjna dla pozycji ścian i ID przedmiotów
local config = {
    [1006] = {
        wallPositions = {
            {3146, 4245, 5}, {3147, 4245, 5}, {3148, 4245, 5}, {3149, 4245, 5},
            {3150, 4245, 5}, {3151, 4245, 5}, {3152, 4245, 5}, {3153, 4245, 5},
            {3154, 4245, 5}, {3155, 4245, 5}, {3156, 4245, 5}, {3157, 4245, 5},
            {3158, 4245, 5}
        },
        wallDown = 2162,
        wallUp = 1295,
    },
    [1007] = {
        wallPositions = {
            {3143, 4248, 5}, {3143, 4249, 5}, {3143, 4250, 5}, {3143, 4251, 5},
            {3143, 4252, 5}, {3143, 4253, 5}, {3143, 4254, 5}, {3143, 4255, 5},
            {3143, 4256, 5}
        },
        wallDown = 2164,
        wallUp = 1294,
    },
    [1008] = {
        wallPositions = {
            {3146, 4259, 5}, {3147, 4259, 5}, {3148, 4259, 5}, {3149, 4259, 5},
            {3150, 4259, 5}, {3151, 4259, 5}, {3152, 4259, 5}, {3153, 4259, 5},
            {3154, 4259, 5}, {3155, 4259, 5}, {3156, 4259, 5}, {3157, 4259, 5},
            {3158, 4259, 5}
        },
        wallDown = 2162,
        wallUp = 1295,
    },
    [1009] = {
        wallPositions = {
            {3161, 4248, 5}, {3161, 4249, 5}, {3161, 4250, 5}, {3161, 4251, 5},
            {3161, 4252, 5}, {3161, 4253, 5}, {3161, 4254, 5}, {3161, 4255, 5},
            {3161, 4256, 5}
        },
        wallDown = 2164,
        wallUp = 1294,
    },
}

-- Utworzenie obiektu akcji
local inquisitionBrother = Action()

-- Główna funkcja wywoływana przy użyciu dźwigni
function inquisitionBrother.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Pobranie konfiguracji dla użytej dźwigni (po jej unikalnym ID)
    local targetLever = config[item.uid]
    if not targetLever then
        return true
    end

    -- Ustalenie, w co ma się zamienić ściana w zależności od stanu dźwigni
    local transformTo = (item.itemid == 2772) and targetLever.wallUp or targetLever.wallDown

    -- Pętla przez wszystkie pozycje ścian dla danej dźwigni
    for _, pos in ipairs(targetLever.wallPositions) do
        -- Utworzenie obiektu Position z danych w tabeli
        local tile = Tile(Position(pos[1], pos[2], pos[3]))
        if tile then
            -- Sprawdzenie, jaki przedmiot znajduje się na danej kratce (szukamy przedmiotu w stanie przeciwnym do docelowego)
            local wallItem = tile:getItemById(transformTo == targetLever.wallUp and targetLever.wallDown or targetLever.wallUp)
            if wallItem then
                -- Zamiana ściany na jej drugą formę (np. znikającą na pojawiającą się)
                wallItem:transform(transformTo)
            end
        end
    end

    -- Zamiana samej dźwigni (stan "on" na "off" i odwrotnie)
    item:transform(item.itemid == 2772 and 2773 or 2772)
    return true
end

-- Rejestracja akcji dla każdego unikalnego ID (uid) z tabeli konfiguracyjnej
for uniqueId in pairs(config) do
    inquisitionBrother:uid(uniqueId)
end

inquisitionBrother:register()