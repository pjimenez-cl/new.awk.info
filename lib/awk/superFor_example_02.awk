function superfor(loopdepth, prologue, body, epilogue,     zz)
{
        currloopnum++

        @prologue()

        for(loopcounter[currloopnum]=1; 
            loopcounter[currloopnum]<=loopmax [currloopnum]; 
            loopcounter[currloopnum]++) {
                if ( loopdepth==1 ) {
                        @body()
                }
                else if ( loopdepth>1 )
                        superfor(loopdepth-1, proloogue, 
                                 body, epilogue)
                }

        @epilogue()

        loopdepth++ ; currloopnum--
}
