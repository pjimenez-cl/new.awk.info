# Code
BEGIN {
  n = arg("-n",5)
  for (j=0; j<n; j++) push(0,n-j)
  showstacks()
  hanoi(n,0,1,2)
}
function hanoi(n,a,b,c) {
  if (n==1) {
    move(a,b)
  } else {
    hanoi(n-1,a,c,b)
    move(a,b)
    hanoi(n-1,c,b,a)
  }
}
function move(i,j) {
  push(j,pop(i))
  showstacks()
}
function showstacks(  i,j) {
  for (i=0; i<=2; i++) {
    printf "%s ", i
    for (j=0; j<sp[i]; j++) printf "%s", stack[i,j]
    print "" }
  print ""
}
function arg(tag,default) {
  for(i in ARGV) 
	if (ARGV[i] ~ tag) 
		return ARGV[i+1]
  return default
}
function push(i,v) { stack[i,sp[i]++]=v }
function pop(i)    { return stack[i,--sp[i]] }

## awk.info:
## AWK Example: hanoi.awk
##
## This AWK example was downloaded from the 'http://awk.info' website.
##
## Author:
##  Alan Linton, 2001
##
