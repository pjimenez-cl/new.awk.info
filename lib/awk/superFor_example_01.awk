#shows an example of a superfor loop
BEGIN {
	#define loop maximums
	loopmax[1]=4
	loopmax[2]=6
	loopmax[3]=8
	loopmax[4]=10
	loopmax[5]=12
	loopmax[6]=20
	#call the loop
	superfor(6)
}
function superfor(loopdepth, zz) { # zz is a local variable
        currloopnum++

        #start of prologue
        #end of prologue

        for(loopcounter[currloopnum]=1; 
            loopcounter[currloopnum]<=loopmax[currloopnum]; 
            loopcounter[currloopnum]++) {
                if ( loopdepth==1 ) {
                        #start of superfor body
                        for (zz=1;zz<=currloopnum;zz++) {
                                printf loopcounter[zz] FS
                                }
                        print ""
                        #end of superfor body
                        }
                else if ( loopdepth>1 )
                        superfor(loopdepth-1)
                }

        #start of epilog
        #end of epilog

        loopdepth++ ; currloopnum--
        }
