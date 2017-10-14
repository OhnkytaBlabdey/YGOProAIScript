--- OnSelectCard ---
--
-- Called when AI has to select a card. Like effect target or attack target
-- Example card(s): Caius the Shadow Monarch, Chaos Sorcerer, Elemental HERO The Shining
-- 
-- Parameters:
-- cards = table of cards to select
-- minTargets = how many you must select min
-- maxTargets = how many you can select max
-- triggeringID = id of the card that is responsible for the card selection
--
-- Return: 
-- result = table containing target indices


function OnSelectCard(cards, minTargets, maxTargets, triggeringID,triggeringCard)
  local result = {}
-------------------------------------------------
-- **********************************************
-- General purpose functions, for selecting 
-- targets when XYZ summoning, attacking etc.
-- **********************************************
-------------------------------------------------

  -- AI attack target selection
  -- redirected to SelectBattleComand.lua
  if IsBattlePhase() 
  and GlobalAIIsAttacking 
  and Duel.GetCurrentChain()==0
  and not triggeringCard
  then 
    local c = FindCard(GlobalCurrentAttacker,Field())
    result = AttackTargetSelection(cards,c)
    GlobalAIIsAttacking = nil
    return result
  end
  
  -- Summoning material selection
  -- redirected to SelectTribute.lua
  if not triggeringCard 
  and GlobalMaterial==true
  and Duel.GetCurrentChain()==0
  then  
    GlobalMaterial = nil
    local id = GlobalSSCardID
    GlobalSSCardID = nil
    return OnSelectMaterial(cards,minTargets,maxTargets,id)
  end

if DeckCheck(DECK_EXODIA) then
  return ExodiaCard(cards,minTargets,maxTargets,triggeringID,triggeringCard)
end
-- other decks 
-- redirect to respective deck files
  local result = nil
  
  local d = DeckCheck()
  if d and d.Card then
    result = d.Card(cards,minTargets,maxTargets,triggeringID,triggeringCard)
  end
  if result ~= nil then
    if type(result) == "table" then
      return result
    else
      print("Warning: returning invalid card selection: "..triggeringID)
    end
  end

  local SelectCardFunctions={
  FireFistCard,HeraldicOnSelectCard,GadgetOnSelectCard,
  BujinOnSelectCard,MermailOnSelectCard,
  SatellarknightOnSelectCard,ChaosDragonOnSelectCard,HATCard,
  QliphortCard,NobleCard,NekrozCard,BACard,DarkWorldCard,
  GenericCard,ConstellarCard,BlackwingCard,HarpieCard,HEROCard,
  }
  for i=1,#SelectCardFunctions do
    local func = SelectCardFunctions[i]
    result = func(cards,minTargets,maxTargets,triggeringID,triggeringCard)
    if result ~= nil then
      if type(result) == "table" then
        return result
      else
        print("Warning: returning invalid card selection: "..triggeringID)
      end
    end
  end
  result = {}

-----
  
  
  
  
  
-----  
  
  
  
  
  
-----
  
  

  --------------------------------------------
  -- Reset these variable if it gets this far.
  --------------------------------------------
  GlobalActivatedCardID = nil
  GlobalCardMode = nil
  GlobalAIIsAttacking = false
  GlobalSSCardID = nil
  GlobalSSCardSetcode = nil
  
  
  if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
    return Add(cards,PRIO_TOGRAVE,minTargets)
  end
  
  
  -- always choose the mimimum amount of targets and select random targets
  local targets = {}
  for i,c in pairs(cards) do
    targets[i]=c
    c.index=i
  end
  for i=1,minTargets do
    local r=math.random(1,#targets)
    local c=targets[r]
    table.remove(targets,r)
    result[i]=c.index
  end

  return result 
end

