BEGIN {
  for (i=0; i<=255; i++) {           # build table of char=value pairs
    ord_arr[sprintf("%c",i)] = i     # character = ordinal value
  }
  for (i=1; i<=ARGC-1; i++) {
    str = ""
    for (j=1; j<=length(ARGV[i]); j++) {
      str = sprintf("%s%02d",str,ord_arr[substr(ARGV[i],j,1)]-46)
    }
    printf("BEGIN{a=\"%s\";while(a){printf(\"%%c\",46+substr(a,1,2));a=substr(a,3)}}\n",str)
  }
  exit(0)
}

## awk.info:
## AWK Example: cryptosig.awk
##
## This AWK example was downloaded from the 'http://awk.info' website.
##
## Author:
##      BEGIN{a="535170696159626207061118755158656500536563";    while(a){    printf("%c",46+substr(a,1,2));a=substr(a,3)};    print("")    }
##
