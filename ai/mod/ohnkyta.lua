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
function cardacttarget(tcards,gid,a,b)--ida以idb为对象，gid是全局发动卡id
 if gid == a then 
  for i=1,#tcards do 
   if tcards[i].id==b then 
    AI.Chat(a .. ' selected : ' .. b )
    return {i} 
   end
  end
 end
end
function cardmaterial(cards,gid,a,b,c,m)--ida以idb（优于）idc为素材，gid是全局召唤卡id
local tresult={}
if not m then 
m=2 
end
 if gid == a then 
  for i=1,#cards do 
   if cards[i].id == b then 
    AI.Chat(a..' used '..b..' as material ')
    tresult[#tresult+1]=i 
   end
   if #tresult == m then 
    return tresult
   end
  end
  ---b
  
  for i=1,#cards do 
   if cards[i].id == c then 
    tresult[#tresult+1]=i
   end
   if #tresult == m then 
    return tresult
   end
  end
  ---c
 end
 
 
end
-- Return:
-- command = the command to execute
-- index = index of the card to use
-- 
-- Here are the available commands

-- COMMAND_LET_AI_DECIDE  = -1
-- COMMAND_SUMMON         = 0
-- COMMAND_SPECIAL_SUMMON = 1
-- COMMAND_CHANGE_POS     = 2
-- COMMAND_SET_MONSTER    = 3
-- COMMAND_SET_ST         = 4
-- COMMAND_ACTIVATE       = 5
-- COMMAND_TO_NEXT_PHASE  = 6
-- COMMAND_TO_END_PHASE   = 7

-- GlobalBPAllowed = nil
function act(ActivatableCards,id,seq)--发动id的第seq个效果
 for i=1,#ActivatableCards do 
  if ActivatableCards[i].id == id then 
   if not seq or seq == 0 then 
    GlobalActivatedCardID = ActivatableCards[i].id
    return COMMAND_ACTIVATE,i
   else
	if ( ActivatableCards[i].description == ActivatableCards[i].id*16 + seq ) then 
	 GlobalActivatedCardID = ActivatableCards[i].id
     return COMMAND_ACTIVATE,i
    end
   end
  end
 end

end
function spsm(SpSummonableCards,id)
--AI.Chat('spsming ... ')
 for i=1,#SpSummonableCards do
 AI.Chat('SpSummonableCards[i].id'.. SpSummonableCards[i].id)
  if SpSummonableCards[i].id == id then 
   sming=true
   GlobalSSCardID=SpSummonableCards[i].id
   return COMMAND_SPECIAL_SUMMON,i
  end
 end
end 
function summon(SummonableCards,id)
 for i=1,#SummonableCards do 
  if SummonableCards[i].id == id then 
   GlobalSummonedThisTurn=GlobalSummonedThisTurn+1 
   GlobalSummonedCardID=SummonableCards[i].id
   sming=true
   return COMMAND_SUMMON,i 
  end
 end
end


---
function cpindi(a,b)
 if ob1 and ob2 then
   return ( ob1 == a and ob2 == b )
 end
end

function wrindi(a,b)
 if ( ob1 and ob2 ) then 
   ob1=a
   ob2=b
 end
end
