
function MegaMonarchStartup(deck)
  deck.Init                 = MegaMonarchInit
  deck.Card                 = MegaMonarchCard
  deck.Chain                = MegaMonarchChain
  deck.EffectYesNo          = MegaMonarchEffectYesNo
  deck.Position             = MegaMonarchPosition
  deck.YesNo                = MegaMonarchYesNo
  deck.BattleCommand        = MegaMonarchBattleCommand
  deck.AttackTarget         = MegaMonarchAttackTarget
  deck.AttackBoost          = MegaMonarchAttackBoost
  deck.Tribute				      = MegaMonarchTribute
  --[[
  deck.Option 
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = MegaMonarchActivateBlacklist
  deck.SummonBlacklist      = MegaMonarchSummonBlacklist
  deck.RepositionBlacklist  = MegaMonarchRepoBlacklist
  deck.SetBlacklist		      = MegaMonarchSetBlacklist
  deck.Unchainable          = MegaMonarchUnchainable
  --[[
  
  ]]
  deck.PriorityList         = MegaMonarchPriorityList
  
end

MegaMonarchIdentifier = 84171830 -- Dominion

DECK_MegaMonarch = NewDeck("Vassal/Mega Monarchs",MegaMonarchIdentifier,MegaMonarchStartup) 

MegaMonarchActivateBlacklist={
00006700, -- Aither
00006701, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius

95993388, -- Landrobe
22382087, -- Garum
00006702, -- Eidos
00006703, -- Idea

00006723, -- Pandeity
02295440, -- One for one
32807846, -- RotA
33609262, -- Tenacity
81439173, -- Foolish
--05318639, -- MST
79844764, -- Stormforth
19870120, -- March
61466310, -- Return
84171830, -- Dominion

00006734, -- Original
}
MegaMonarchSummonBlacklist={
00006700, -- Aither
00006701, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius

95993388, -- Landrobe
22382087, -- Garum
00006702, -- Eidos
00006703, -- Idea
}
MegaMonarchSetBlacklist={
}
MegaMonarchRepoBlacklist={
}
MegaMonarchUnchainable={
00006700, -- Aither
}

function VassalFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and FilterAttack(c,800)
  and FilterDefense(c,1000)
  and (exclude == nil or c.id~=exclude)
end


function AitherCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
  end
  return true
end
function ErebusCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
  end
  if loc == PRIO_TOGRAVE then
    return not HasAccess(c.id)
  end
  return true
end
function MegaThestalosCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and #OppHand()>0
  end
  return true
end
function MegaCaiusCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and CardsMatchingFilter(OppField(),MegaCaiusFilter)>1
  end
  return true
end
function IdeaCond(loc,c)
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id) and DualityCheck()
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
    and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
  end
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIBanish(),MonarchFilter)>0
    and OPTCheck(00006703)
  end
  return true
end
function EidosCond(loc,c)
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_DECK) 
    and NormalSummonCheck()
  end
  return true
end
function LandrobeCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_ONFIELD)
    and CardsMatchingFilter(AIGrave(),FilterID,00006703)>0
  end
  return true
end
function GarumCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_ONFIELD)
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
  end
  return true
end
function PandeityCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIHand(),MonarchFilter)>0 then
      if not CanTributeSummon() then
        return 8
      else
        return true
      end
    end
  end
  return true
end
function TenacityFilter(c)
  return FilterAttack(c,2400) or FilterAttack(c,2800)
end
function TenacityCond(loc,c)
  if loc == PRIO_TOHAND then  
    return CardsMatchingFilter(AIHand(),TenacityFilter)>0
    and OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function StormforthCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (HasID(AIHand(),00006700,true)
    or CardsMatchingFilter(OppMon(),StormforthFilter)>0)
    and TributeSummonsM(0,1)>0
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function MarchCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (TributeSummonsM(0,1)>0
    or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function ReturnCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and TributeSummonsM(0,1)>0
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function DominionCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (TributeSummonsM(2,1)>0 and TributesAvailable()==1
    or CanTributeSummon()
    or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function OriginalCond(loc,c)
  local cards
  if loc == PRIO_TOHAND then
    if HasIDNotNegated(AIHand(),00006723,true)
    and not HasAccess(c.id) 
    then
      return 8.5
    end
    return not HasID(AIHand(),c.id,true) 
    or FilterLocation(c,LOCATION_REMOVED)
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_MZONE) then
      return 5
    end
    cards = UseLists(AIGrave(),AIMon())
    return not HasID(cards,c.id,true)
  end
  if loc == PRIO_TODECK then
    cards = UseLists(AIGrave(),AIMon())
    return CardsMatchingFilter(cards,FilterID,c.id)-GetMultiple(c.id)>1
  end
  if loc == PRIO_BANISH then
    cards = UseLists(AIGrave(),AIMon())
    return FilterLocation(c,LOCATION_GRAVE)
    and CardsMatchingFilter(cards,FilterID,c.id)>1
    and not HasID(AIBanish(),c.id,true) 
  end
  return true
end
    
MegaMonarchPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- MegaMonarch


[00006700] = {7,4,1,1,1,1,1,1,1,1,AitherCond},          -- Aither
[00006701] = {8,2,1,1,8,5,1,1,1,1,ErebusCond},          -- Erebus
[69230391] = {5,2,1,1,1,1,1,1,1,1,MegaThestalosCond},   -- Mega Thestalos
[87288189] = {6,3,1,1,1,1,1,1,1,1,MegaCaiusCond},       -- Mega Caius
[09748752] = {1,1,1,1,1,1,1,1,1,1,CaiusCond},           -- Caius

[95993388] = {6,1,5,1,7,4,1,1,1,1,LandrobeCond},        -- Landrobe
[22382087] = {5,1,6,1,8,3,1,1,1,1,GarumCond},           -- Garum
[00006702] = {3,1,7,1,5,1,1,1,1,1,EidosCond},           -- Eidos
[00006703] = {7,1,8,1,6,2,1,1,1,1,IdeaCond},            -- Idea

[00006723] = {4,1,1,1,8,1,3,1,1,1,PandeityCond},        -- Pandeity
[02295440] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- One for one
[32807846] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- RotA
[33609262] = {10,2,1,1,6,1,8,1,8,2,TenacityCond},        -- Tenacity
[81439173] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- Foolish
[05318639] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- MST
[79844764] = {5,2,1,1,5,1,5,1,6,2,StormforthCond},      -- Stormforth
[19870120] = {7,1,1,1,1,1,6,1,6,2,MarchCond},           -- March
[61466310] = {3,1,1,1,3,1,6,1,6,2,ReturnCond},          -- Return
[84171830] = {9,1,1,1,2,1,7,1,7,2,DominionCond},        -- Dominion

[00006734] = {6,1,1,1,9,1,4,1,9,1,OriginalCond},        -- Original
[48716527] = {3,1,1,1,4,1,6,1,6,2,nil},                 -- Erupt
} 

function TributeCountM(mega)
  local result = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) then
      if mega and FilterSummon(c,SUMMON_TYPE_ADVANCE) then
        result=result+2
      else
        result=result+1
      end
    end
  end
  if GlobalStormforth == Duel.GetTurnCount() 
  and CardsMatchingFilter(OppMon(),StormforthFilter)
  then
    result=result+1
  end
  return result
end
function TributeFodder()
  local result = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) 
    and not FilterSummon(c,SUMMON_TYPE_ADVANCE) 
    then
      result=result+1
    end
  end
  return result
end
function TributesAvailable(oppturn)
  local result = TributeFodder()
  local stormforthcheck = false
  if HasIDNotNegated(AIHand(),00006703,true)
  and HasIDNotNegated(AIDeck(),00006702,true)
  and not NormalSummonCheck()
  and DualityCheck()
  and not oppturn
  then
    result = result + 2
  elseif HasIDNotNegated(AIHand(),00006702,true)
  and not NormalSummonCheck()
  and not oppturn
  then
    result = result + 1
  end
  if HasID(AIGrave(),00006702,true) 
  and CardsMatchingFilter(AIGrave(),VassalFilter)>0
  and DualityCheck()
  and not oppturn
  then
    if HasIDNotNegated(AIGrave(),00006703,true)
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
    then
      result = result + 2
    else
      result = result + 1
    end
  end
  if CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and GlobalStormforth==Duel.GetTurnCount()
  then
    result = result + 1
  end
  if HasIDNotNegated(AICards(),79844764,true)
  and OPTCheck(79844764)
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  if HasIDNotNegated(AIST(),79844764,true)
  and OPTCheck(79844764)
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    stormforthcheck = true
    result = result + 1
  end
  if HasID(AIGrave(),00006734,true)
  and OPTCheck(00006734)
  and DualityCheck()
  and (CardsMatchingFilter(AIGrave(),MonarchFilter)>1 and not oppturn
  or CardsMatchingFilter(AIGrave(),MonarchFilter)>2
  or stormforthcheck)
  then
    result = result + 1
  end
  if HasID(AIHand(),95993388,true)
  and OPTCheck(95993388)
  and DualityCheck()
  and CardsMatchingFilter(OppMon(),LandrobeFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  if HasID(AIHand(),22382087,true)
  and OPTCheck(22382087)
  and DualityCheck()
  and CardsMatchingFilter(AIMon(),GarumFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  return result
end
function TributeSummonsM(tributes,mode)
  local result = 0
  if not tributes then tributes = 0 end
  if not mode then mode = 1 end
  for i=1,#AIHand() do
    local c = AIHand()[i]
    if (tributes == 2 or tributes == 0)
    and (c.id==00006701 and SummonErebus(c,mode,true)
    or c.id==00006700 and SummonAither(c,mode,true)
    or c.id==69230391 and SummonMegaThestalos(c,mode,true)
    or c.id==87288189 and SummonMegaCaius(c,mode,true))
    then
      result=result+1
    end
    if (tributes == 1 or tributes == 0)
    and (c.id==09748752 and SummonCaius(c,mode)
    or (c.level==6 or HasIDNotNegated(AICards(),84171830,true,OPTCheck))
    and (c.id==00006701 and SummonErebus(c,mode,true)
    or c.id==00006700 and SummonAither(c,mode,true)
    or c.id==69230391 and SummonMegaThestalos(c,mode,true)
    or c.id==87288189 and SummonMegaCaius(c,mode,true)))
    then
      result=result+1
    end
  end
  return result
end
function CanTributeSummon()
  return TributeSummonsM(1,1)>0
  and TributesAvailable()>0
  or TributeSummonsM(2,1)>0
  and TributesAvailable()>1
end
--[[
00006700 -- Aither
00006701 -- Erebus
69230391 -- Mega Thestalos
87288189 -- Mega Caius
09748752 -- Caius

95993388 -- Landrobe
22382087 -- Garum
00006702 -- Eidos
00006703 -- Idea

00006723 -- Pandeity
02295440 -- One for one
32807846 -- RotA
33609262 -- Tenacity
81439173 -- Foolish
05318639 -- MST
79844764 -- Stormforth
19870120 -- March
61466310 -- Return
84171830 -- Dominion

00006734 -- Original
]]
function GarumFilter(c)
  return FilterSummon(c,SUMMON_TYPE_ADVANCE)
end
function LandrobeFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,3)
  and not FilterType(c,TYPE_TOKEN)
end
function SummonIdea(c,mode)
  if mode == 1 then
    return TributeSummonsM(0,1)>0 
    and HasIDNotNegated(AIDeck(),00006702,true)
    and TributeFodder()<2
    and DualityCheck()
  end
  if mode == 2 then
    return #AIMon()==0
    and CardsMatchingFilter(AIDeck(),VassalFilter,c.id)>0
    and DualityCheck()
  end
end
function SummonEidos(c,mode)
  if mode == 1 then
    return TributeSummonsM(2,1)>0
    and TributeFodder()==1
    or TributeSummonsM(1,1)>0
    and TributeFodder()==0
  end
end
function UseEidos(c,mode)
  if mode == 1 then
    return (TributeSummonsM(1,1)>0
    and TributeFodder()==0
    or TributeSummonsM(2,1)>0
    and HasIDNotNegated(AIGrave(),00006703,true)
    and CardsMatchingFilter(AIDeck(),VassalFilter,00006703)>0
    and OPTCheck(00006703)
    and TributeFodder()<2)
    and not NormalSummonCheck()
  end
end
function PlayDominion(c)
  return FilterLocation(c,LOCATION_HAND) 
  and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
end
function UseDominion(c)
  if FilterLocation(c,LOCATION_SZONE) then
    OPTSet(c)
    return true
  end
  return false
end
function UsePandeityGrave(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  return false
end
function UsePandeity(c,mode)
  if FilterLocation(c,LOCATION_HAND) then
    if mode == 1 then
      return not CanTributeSummon()
      and not NormalSummonCheck()
      or HasID(AIHand(),00006734,true)
      and not HasID(UseLists(AIMon(),AIGrave()),00006734,true)
    end
    if mode == 2 then
      return true
    end
  end
  return false
end
function UseOriginalGrave(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    if mode == 1 
    and not NormalSummonCheck() 
    and (TributeSummonsM(1,1)>0
    and TributeFodder()==0
    or TributeSummonsM(2,1)>0
    and TributeFodder()<2)
    then
      OPTSet(00006734)
      return true
    end
    if mode == 2 
    and TurnEndCheck()
    and CardsMatchingFilter(AIGrave(),MonarchFilter)>4
    then
      OPTSet(00006734)
      return true
    end
  end
  return false
end
function UseOriginal(c)
  if FilterLocation(c,LOCATION_SZONE) then
    return CardsMatchingFilter(AIGrave(),MonarchFilter)>3 
    and #AIHand()<6
  end
  return false
end
function SetVassal(c)
  return TurnEndCheck()
  and #AIMon()==0
end
function SummonErebus(c,mode,check)
  if mode == 1 then
    return (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    or OppHasStrongestMonster()
  end
  return false
end
function SummonAither(c,mode,check)
  if mode == 1 then
    return (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    or OppHasStrongestMonster()
  end
  return false
end
function SummonMegaThestalos(c,mode,check)
  if mode == 1 then
    return (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    and #OppHand()>0
  end
  return false
end
function UseTenacityM(c)
  OPTSet(33609262)
  return true
end

function MegaMonarchInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,32807846) then -- RotA
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,81439173) then -- Foolish
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,33609262,UseTenacityM) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,00006723,UsePandeityGrave) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,00006734,UseOriginal) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,00006734,UseOriginalGrave,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,00006723,UsePandeity,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,00006702,UseEidos,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006703,SummonIdea,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006702,SummonEidos,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Act,84171830,PlayDominion) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,84171830,UseDominion) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,19870120,UseMarch) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,61466310,UseReturn) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006701,SummonErebus,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006700,SummonAither,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,87288189,SummonMegaCaius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,09748752,SummonCaius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,69230391,SummonMegaThestalos,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Act,00006723,UsePandeity,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,00006703,SummonIdea,2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(SetMon,22382087,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,95993388,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,00006702,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,00006703,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasIDNotNegated(Act,00006734,UseOriginalGrave,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  return nil
end
--[[
00006700 -- Aither
00006701 -- Erebus
69230391 -- Mega Thestalos
87288189 -- Mega Caius
09748752 -- Caius

95993388 -- Landrobe
22382087 -- Garum
00006702 -- Eidos
00006703 -- Idea

00006723 -- Pandeity
02295440 -- One for one
32807846 -- RotA
33609262 -- Tenacity
81439173 -- Foolish
05318639 -- MST
79844764 -- Stormforth
19870120 -- March
61466310 -- Return
84171830 -- Dominion

00006734 -- Original
]]
function ErebusTarget(cards,c)
  if FilterLocation(c,LOCATION_GRAVE) then
    if LocCheck(cards,LOCATION_HAND) then
      return Add(cards,PRIO_TOGRAVE)
    end
    if LocCheck(cards,LOCATION_GRAVE) then
      return Add(cards,PRIO_TOHAND)
    end
  end
  if LocCheck(cards,LOCATION_DECK) 
  or LocCheck(cards,LOCATION_HAND)
  and cards[1].owner==1
  then
    return Add(cards,PRIO_TOGRAVE)
  end
  if not OppHasStrongestMonster() 
  and not HasPriorityTarget(OppField(),false)
  and #OppHand()>0
  then
    return RandomTargets(cards,1,FilterLocation,LOCATION_HAND)
  end
  return BestTargets(cards,1,TARGET_TODECK,FilterLocation,LOCATION_ONFIELD)
end
function AitherTarget(cards,c)
  if FilterLocation(c,LOCATION_HAND) then
    if LocCheck(cards,LOCATION_GRAVE) then
      return Add(cards,PRIO_BANISH)
    end
    if LocCheck(cards,LOCATION_DECK) then
      return Add(cards,PRIO_TOHAND)
    end
  end
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards)
end
function IdeaTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function EidosTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function ReturnTarget(cards)
  return Add(cards)
end
function PandeityTarget(cards,min)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return Add(cards,PRIO_TOHAND,min)
end
function LandrobeTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards)
  end
  return BestTargets(cards,1,TARGET_FACEDOWN)
end
function GarumTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  return Add(cards)
end
function TenacityTarget(cards)
  return Add(cards)
end
function DominionTarget(cards)
  return Add(cards,PRIO_TOFIELD) -- WIP
end
function OriginalTarget(cards,c,min)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return Add(cards,PRIO_TODECK,FilterID,c.id)
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH,min)
  end
  return Add(cards,PRIO_TODECK,min)
end
function MegaMonarchCard(cards,min,max,id,c)
  if not c and GlobalStormforth==Duel.GetTurnCount()
  and min==1 and max==1 and Duel.GetTurnPlayer()==player_ai
  and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  then
    return StormforthTarget(cards)
  end
  if id == 00006700 then
    return AitherTarget(cards,c)
  end
  if id == 00006701 then
    return ErebusTarget(cards,c)
  end
  if id == 69230391 then -- Mega Thestalos
    return BestTargets(cards,1,PRIO_TOGRAVE)
  end
  if id == 95993388 then
    return LandrobeTarget(cards)
  end
  if id == 22382087 then
    return GarumTarget(cards)
  end
  if id == 00006702 then
    return EidosTarget(cards)
  end
  if id == 00006703 then
    return IdeaTarget(cards)
  end
  if id == 00006723 then
    return PandeityTarget(cards,min)
  end
  if id == 33609262 then
    return TenacityTarget(cards)
  end
  if id == 19870120 then
    return MarchTarget(cards)
  end
  if id == 61466310 then
    return ReturnTarget(cards)
  end
  if id == 84171830 then
    return DominionTarget(cards)
  end
  return nil
end
function ChainAither(c)
  if FilterLocation(c,LOCATION_MZONE) and NotNegated(c) then
    return true
  end
  if FilterLocation(c,LOCATION_HAND) then
    if ((Duel.CheckTiming(TIMING_MAIN_END)
    and Duel.GetCurrentPhase(PHASE_MAIN1)
    and HasIDNotNegated(AIST(),79844764,true,OPTCheck)
    or GlobalStormforth==Duel.GetTurnCount())
    and CardsMatchingFilter(OppMon(),StormforthFilter)>0
    and TributesAvailable(true)>1)
    or TributeFodder()>1
    then
      return UnchainableCheck(00006703)
    end
  end
  return false
end
function ChainErebus(c)
  if FilterLocation(c,LOCATION_GRAVE) and RemovalCheckCard(c) then
    return true
  end
  if FilterLocation(c,LOCATION_MZONE) and NotNegated(c) then
    return true
  end
  return false
end
function ChainOriginal(c)
  if FilterLocation(c,LOCATION_SZONE) then
    if RemovalCheckCard(c) then
      if (RemovalCheckCard(c,CATEGORY_TOGRAVE)
      or RemovalCheckCard(c,CATEGORY_DESTROY))
      and CardsMatchingFilter(AIGrave(),FilterID,c.id)>0
      then
        GlobalCardMode = 1
      end
      return true
    end
    if Duel.CheckTiming(TIMING_END_PHASE) 
    and Duel.GetTurnPlayer() == 1-player_ai
    and CardsMatchingFilter(AIGrave(),MonarchFilter)>2
    and #AIHand()<7
    then
      return true
    end
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    if RemovalCheckCard(c) then
      OPTSet(00006734)
      return true
    end
    if Duel.GetCurrentPhase()==PHASE_BATTLE then
      local aimon,oppmon = GetBattlingMons()
      if #AIMon()==0 and oppmon 
      and (oppmon:GetAttack()<=c.defense
      or oppmon:GetAttack()>=0.7*AI.GetPlayerLP(1))
      then
        OPTSet(00006734)
        return true
      end
    end
    if Duel.GetTurnPlayer()==1-player_ai
    and Duel.CheckTiming(TIMING_MAIN_END)
    and Duel.GetCurrentPhase(PHASE_MAIN1)
    and HasIDNotNegated(AIHand(),00006700,true)
    then
      if TributesAvailable(true)==2
      and TributeFodder()<2
      and TributeCountM(true)<2
      and (Duel.GetCurrentChain()==0
      or ChainCheck(79844764,player_ai))
      then
        OPTSet(00006734)
        return true
      end
      if ChainCheck(00006700,player_ai)
      and TributesAvailable(true)>1
      then
        OPTSet(00006734)
        return true
      end
    end
  end
  return false
end
function ChainStormforth(c)
  if RemovalCheckCard(c) then
    GlobalStormforth=Duel.GetTurnCount()
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and (Duel.CheckTiming(TIMING_MAIN_END)
  and Duel.GetCurrentPhase(PHASE_MAIN1)
  or ChainCheck(00006734,player_ai,nil,FilterLocation,LOCATION_GRAVE))
  and HasIDNotNegated(AIHand(),00006700,true)
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    if TributesAvailable(true)==2
    and TributeFodder()<2
    and TributeCountM(true)<2
    and Duel.GetCurrentChain()==0
    or ChainCheck(00006734,player_ai,nil,FilterLocation,LOCATION_GRAVE)
    then
      GlobalStormforth=Duel.GetTurnCount()
      return true
    end
    if ChainCheck(00006700,player_ai)
    and TributesAvailable(true)>1
    then
      GlobalStormforth=Duel.GetTurnCount()
      return true
    end
  end
  return false
end
function ChainGarum(c)
  if CardsMatchingFilter(AIDeck(),VassalFilter,00006702)>0 then
    OPTSet(22382087)
    return true
  end
end
function ChainLandrobe(c)
  if true then
    OPTSet(95993388)
    return true
  end
end
function ChainIdea(c)
  if FilterLocation(c,LOCATION_MZONE) then
    OPTSet(00006703)
    return true
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    OPTSet(000067031)
    return true
  end
  return false
end
function ChainEidos(c)
  if true then
    OPTSet(00006702)
    return true
  end
end
function MegaMonarchChain(cards)
  if HasID(cards,00006700,ChainAither) then
    return 1,CurrentIndex
  end
  if HasID(cards,00006701,ChainErebus) then
    return 1,CurrentIndex
  end
  if HasID(cards,95993388,ChainLandrobe) then
    return 1,CurrentIndex
  end
  if HasID(cards,22382087,ChainGarum) then
    return 1,CurrentIndex
  end
  if HasID(cards,00006702,ChainEidos) then
    return 1,CurrentIndex
  end
  if HasID(cards,00006703,ChainIdea) then
    return 1,CurrentIndex
  end
  if HasID(cards,00006734,ChainOriginal) then
    return 1,CurrentIndex
  end
  if HasID(cards,79844764,ChainStormforth) then
    return 1,CurrentIndex
  end
  return nil
end
function MegaMonarchEffectYesNo(id,card)
  if id == 00006700 and ChainAither(card) then
    return 1
  end
  if id == 00006701 and ChainErebus(card) then
    return 1
  end
  if id == 95993388 and ChainLandrobe(card) then
    return 1
  end
  if id == 22382087 and ChainGarum(card) then
    return 1
  end
  if id == 00006702 and ChainEidos(card) then
    return 1
  end
  if id == 00006703 and ChainIdea(card) then
    return 1
  end
  if id == 00006734 and ChainOriginal(card) then
    return 1
  end
  return nil
end

function MegaMonarchYesNo(desc)
  if desc == 92 then -- Stormforth tribute enemy
    return 1
  end
  return nil
end

function MegaMonarchTribute(cards,min, max)
end
function MegaMonarchBattleCommand(cards,targets,act)
end
function MegaMonarchAttackTarget(cards,attacker)
end
function MegaMonarchAttackBoost(cards)
  if HasIDNotNegated(AIST(),84171830,true) 
  and Duel.GetTurnPlayer()==player_ai 
  then  
    for i=1,#cards do
      local c=cards[i]
      if FilterSummon(c,SUMMON_TYPE_ADVANCE) then
        c.attack=c.attack+800
      end
    end
  end
end

MegaMonarchAtt={
00006700, -- Aither
00006701, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius
}
MegaMonarchDef={
95993388, -- Landrobe
22382087, -- Garum
00006702, -- Eidos
00006703, -- Idea
00006734, -- Original
}
function MegaMonarchPosition(id,available)
  result = nil
  for i=1,#MegaMonarchAtt do
    if MegaMonarchAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#MegaMonarchDef do
    if MegaMonarchDef[i]==id 
    then 
      result=POS_FACEUP_DEFENCE 
    end
  end
  if id==09126351 and TurnEndCheck() then
    result=POS_FACEUP_DEFENCE 
  end
  if id==53334641 and TurnEndCheck() then
    result=POS_FACEUP_DEFENCE 
  end
  return result
end

