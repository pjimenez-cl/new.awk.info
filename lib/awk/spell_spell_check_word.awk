function spell_check_word(word,        key, lc_word, location, w, wordlist)
{
    lc_word = tolower(word)
    ## print "DEBUG: spell_check_word(" word ") -> tolower -> " lc_word
    if (lc_word in Dictionary)          # acceptable spelling
        return
    else                                # possible exception
    {
        if (Strip)
        {
            strip_suffixes(lc_word, wordlist)
            ## for (w in wordlist) print "DEBUG: wordlist[" w "]"
            for (w in wordlist)
                if (w in Dictionary)
                    break
            if (w in Dictionary)
                return
        }
        ## print "DEBUG: spell_check():", word
        location = Verbose ? (FILENAME ":" FNR ":") : ""
        if (lc_word in Exception)
            Exception[lc_word] = Exception[lc_word] "\n" location word
        else
            Exception[lc_word] = location word
    }
}
