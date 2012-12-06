        BEGIN{
       split( \
       "no mo"\
       "rexxN"\
       "o mor"\
       "exsxx"\
       "Take "\
      "one dow"\
     "n and pas"\
    "s it around"\
   ", xGo to the "\
  "store and buy s"\
  "ome more, x bot"\
  "tlex of beerx o"\
  "n the wall" , s,\
  "x"); for( i=99 ;\
  i>=0; i--){ s[0]=\
  s[2] = i ; print \
  s[2 + !(i) ] s[8]\
  s[4+ !(i-1)] s[9]\
  s[10]", " s[!(i)]\
  s[8] s[4+ !(i-1)]\
  s[9]".";i?s[0]--:\
  s[0] = 99; print \
  s[6+!i]s[!(s[0])]\
  s[8] s[4 +!(i-2)]\
  s[9]s[10] ".\n";}}
