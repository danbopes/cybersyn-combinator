local constants = require "scripts.constants"
local recipe = data.raw.recipe[constants.ENTITY_NAME]
local item = data.raw.item[constants.ENTITY_NAME]

-- Detected by prototype rather than mod name so that compatible forks of Project Cybersyn also work.
if not data.raw["virtual-signal"]["cybersyn-request-threshold"] then
  error("\n\n" .. constants.MOD_TITLE .. " requires Project Cybersyn (cybersyn) or a compatible fork such as Project Cybersyn Plus (cybersyn-plus).\n\n")
end

if data.raw.technology["cybersyn-train-network"] then
  table.insert(
    data.raw.technology["cybersyn-train-network"].effects,
    { type = "unlock-recipe", recipe = constants.ENTITY_NAME })
elseif data.raw.technology["circuit-network"] then
  table.insert(data.raw.technology["circuit-network"].effects, { type = "unlock-recipe", recipe = constants.ENTITY_NAME })
end

if settings.startup[constants.SETTINGS.UPGRADEABLE].value == true then
  data.raw["constant-combinator"]["constant-combinator"].next_upgrade = constants.ENTITY_NAME
end

data.raw["constant-combinator"]["constant-combinator"].fast_replaceable_group = "constant-combinator"

if mods["nullius"] then
  recipe.subgroup = data.raw["train-stop"]["train-stop"].subgroup
  item.subgroup = data.raw.item["train-stop"].subgroup
end
