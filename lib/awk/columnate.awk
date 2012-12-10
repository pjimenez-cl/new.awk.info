{   line[NR] = $0    # saves the line
    for (f=1; f<=NF; f++) {
        len = length($f)
        if (len>max[f])
            max[f] = len }  # an array of maximum field widths
}
END {
    for(nr=1; nr<=NR; nr++) {
        nf = split(line[nr], fields)
        for (f=1; f<nf; f++)
            printf "%-*s", max[f]+2, fields[f]
        print fields[f] }     # the last field need not be padded
}


## awk.info:
## AWK Example: columnate.awk
##
## This AWK example was downloaded from the 'http://awk.info' website.
##
## Author:
##  h-67-101-152-180.nycmny83.dynamic.covad.net
##
