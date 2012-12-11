# Doindent
function doindent(){
	tmpindent=indent;
	if(indent<0){
		print "ERROR; indent level == " indent
	}
	while(tmpindent >0){
		printf("    ");
		tmpindent-=1;
	}
}
# Out-denting
$1 == "done" 	{ indent -=1; }
$1 == "fi" 	{ indent -=1; }
$0 ~ /}/	{ if(indent!=0) indent-=1;  }
# Worker
# This is the 'default' action, that actually prints a line out.
# This gets called AS WELL AS any other matching clause, in the
# order they appear in this program.
# An "if" match is run AFTER we run this clause.
# A "done" match is run BEFORE we run this clause.
		{
		  doindent();
		  print $0;
		}
# In-denting
$0 ~ /if.*;[ ]*then/	{ indent+=1; }
$0 ~ /for.*;[ ]*do/	{ indent+=1; }
$0 ~ /while.*;[ ]*do/	{ indent+=1; }

$1 == "then"		{ indent+=1; }
$1 == "do"		{ indent+=1; }
$0 ~ /{$/		{ indent+=1; }

## awk.info:
## AWK Example: indent.awk
##
## This AWK example was downloaded from the 'http://awk.info' website.
##
## Author:
##  Philip Brown  phil@bolthole.com
##
