BEGIN   {
         recurse1 = "gawk -f quicksort2.awk #" rand()
         recurse2 = "gawk -f quicksort2.awk #" rand()
        }
NR == 1 { pivot=$0; next }
NR > 1  { if($0 < pivot) print | recurse1
          if($0 > pivot) print | recurse2
        }
END     { close(recurse1)
          if(NR > 0) print pivot
	      close(recurse2)
        }

# Copyright (c) 2009 by David Long.
#
# TODO: Add copyright notice from main page?
#
#Original version: David Long, 2004. Tim Menzies added some modifications in 2009
#to call recursive Gawk pipes on both sides of the pivot.

