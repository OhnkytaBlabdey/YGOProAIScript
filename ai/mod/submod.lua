-- COMMAND_LET_AI_DECIDE  = -1
-- COMMAND_SUMMON         = 0
-- COMMAND_SPECIAL_SUMMON = 1
-- COMMAND_CHANGE_POS     = 2
-- COMMAND_SET_MONSTER    = 3
-- COMMAND_SET_ST         = 4
-- COMMAND_ACTIVATE       = 5
-- COMMAND_TO_NEXT_PHASE  = 6
-- COMMAND_TO_END_PHASE   = 7


-- 从combo中读取step存入global
function obob()
 if combo then 
 AI.Chat("combo exists -- objecting ... ")
  print("combo exists -- objecting ... ")
  for k,v in pairs(combo) do 
  
   if v[1] == ob1 and v[2] == ob2 then 
    local proc = combo[k]
	AI.Chat(" step  matched!  ")
    print(" step  matched!  ")
	command=proc[6]
	print("command is ",command)
	ida=proc[7]
	print("ida is ",ida)
	idb=proc[8]
	idc=proc[9]
	ids=proc[10]
	if proc[11] and proc[11] == 0 then 
	else 
		local note=proc[11]
		if note[1]== 1 then --maxim
		maxim=note[2]
		elseif note[1]== 2 then --seq
		seq=note[2] --seq
		elseif note[1]== 3 then --yesno
		yesno=note[2] --yesno
		print("yesno is : ",yesno,'\n' )
		elseif note[1]== 4 then --position
		pos=note[2] --position
		elseif note[1]== 5 then --number
		num=note[2] --number
		end

	end
	return
   end
   
  end
  AI.Chat("step not found")
  print("step not found")
 else
 AI.Chat("error : combo not exist")
  print("error : combo not exist")
 end
end


--从全局中分析，结合具体返值要求，得出返值 
function act(ActivatableCards,id,seq)
--发动id的第seq个效果
 for i=1,#ActivatableCards do 
  if ActivatableCards[i].id == id then 
   if not seq or seq == 0 then 
   AI.Chat("act card : " .. id .. "")
    print("act card : " .. id .. "")
    GlobalActivatedCardID = ActivatableCards[i].id
    return COMMAND_ACTIVATE,i
   else
	if ( ActivatableCards[i].description == ActivatableCards[i].id*16 + seq ) then 
	AI.Chat("act effect : " .. id .. "'s" .. seq .. " th effect.")
	 print("act effect : " .. id .. "'s" .. seq .. " th effect.")
	 GlobalActivatedCardID = ActivatableCards[i].id
     return COMMAND_ACTIVATE,i
    end
   end
  end
 end

end
function spsm(SpSummonableCards,id)
 for i=1,#SpSummonableCards do
 AI.Chat('SpSummonableCards[i].id'.. SpSummonableCards[i].id)
 print('SpSummonableCards[i].id'.. SpSummonableCards[i].id)
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
function comd(l_cmd,l_cards,l_id)
 for i=1,#l_cards do 
  if l_cards[i].id == l_id then 
   return l_cmd,i 
  end
 end
end

--全局操作
--compare global with a certain state num seq 
function cpindi(a,b)
 if ob1 and ob2 then
   return ( ob1 == a and ob2 == b )
 end
end
--refresh global 
function wrindi(a,b)
 if ( ob1 and ob2 ) then 
   ob1=a
   ob2=b
 end
end
--check condition
function concheck()



end 

function reca()
--不返值，只负责更新(重算)全局的指导变量 
if combo then 
AI.Chat("combo exists -- refreshing ...")
 print("combo exists -- refreshing ...")
 for k,v in pairs(combo) do 
  if v[1] == ob1 and v[2] == ob2 then 
   local proc = combo[k]
   if proc[3] and proc[4] then 
    --AI.Chat
    --print(" k is : " .. k )
    wrindi(proc[3],proc[4] )
	return
   end
  end
 end
 AI.Chat("error : no such step !")
 print("error : no such step !")
else
 AI.Chat("error : combo doesn't exist")
 print("error : combo doesn't exist")
end

end

function preindi()
if not combo then return end 
 for k,v in pairs(combo) do 
  if v[3] == ob1 and v[4] == ob2 then 
   local proc = combo[k]
   if proc[1] and proc[2] then 
    wrindi(proc[1],proc[2] )
	-- if false then
	  command=nil
	  gid=nil
	  ida=nil
	  idb=nil
	  idc=nil
	  seq=nil
	  maxim=nil 
	  selct=0 
	  yesno=nil
	  obob()
	  print('\n'.. "pre() HAS BEEN DONE!!!" ..'\n')
	-- end
	return
   end
  end
 end
 AI.Chat("error : no such step !")
 print("error : no such step !")

end 

