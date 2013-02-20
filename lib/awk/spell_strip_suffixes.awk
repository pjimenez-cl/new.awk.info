function strip_suffixes(word, wordlist,        ending, k, n, regexp)
{
    ## print "DEBUG: strip_suffixes(" word ")"
    split("", wordlist)
    for (k = 1; k <= NOrderedSuffix; k++)
    {
        regexp = OrderedSuffix[k]
        ## print "DEBUG: strip_suffixes(): Checking \"" regexp "\""
        if (match(word, regexp))
        {
            word = substr(word, 1, RSTART - 1)
            if (Replacement[regexp] == "")
                wordlist[word] = 1
            else
            {
                split(Replacement[regexp], ending)
                for (n in ending)
                {
                    if (ending[n] == "\"\"")
                        ending[n] = ""
                    wordlist[word ending[n]] = 1
                }
            }
            break
        }
    }
     ## for (n in wordlist) print "DEBUG: strip_suffixes() -> \"" n "\""
}
