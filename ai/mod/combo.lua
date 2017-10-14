--combo.lua
-- COMMAND_LET_AI_DECIDE  = -1
-- COMMAND_SUMMON         = 0
-- COMMAND_SPECIAL_SUMMON = 1
-- COMMAND_CHANGE_POS     = 2
-- COMMAND_SET_MONSTER    = 3
-- COMMAND_SET_ST         = 4
-- COMMAND_ACTIVATE       = 5
-- COMMAND_TO_NEXT_PHASE  = 6
-- COMMAND_TO_END_PHASE   = 7

--{indi1,indi2,toindi1/false,toindi2/false,command,ida,idb,idc,seq/maxi}
-- {2,3,false,false,5,23571046,0,0,0}
-- {1,4,1,5,1,12345678,23571046,0,2}
---ver1


--{indi1,indi2,{{con1,to1,to2},{con2,to1,to2},... },command,ida,idb/0,idc/0,{id1,id2,id3,... },seq/maxi/0 }
--{,,,,,,,}
--涵盖了init与selectcard所需的信息
--对于贪欲之壶也不需单独处理
---ver2

--{indi1,indi2,toindi1/false,toindi2/false,{{con1,to1,to2},{con2,to1,to2},... }(步骤),command,ida,idb/0,idc/0,{id1,id2,id3,... }(对象/素材),seq/maxi/0 }
---ver3



combo={
 {,,,,,,,,,}
 {,,,,,,,,,}
}


