function spell_check_line(        k, word)
{
    ## for (k = 1; k <= NF; k++) print "DEBUG: word[" k "] = \"" $k "\""
    gsub(NonWordChars, " ")             # eliminate nonword chars
    for (k = 1; k <= NF; k++)
    {
        word = $k
        sub("^'+", "", word)            # strip leading apostrophes
        sub("'+$", "", word)            # strip trailing apostrophes
        if (word != "")
            spell_check_word(word)
    }
}
