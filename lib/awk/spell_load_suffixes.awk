function load_suffixes(        file, k, line, n, parts)
{
    if (NSuffixFiles > 0)               # load suffix regexps from files
    {
        for (file in SuffixFiles)
        {
            ## print "DEBUG: Loading suffix file " file > "/dev/stderr"
            while ((getline line < file) > 0)
            {
                sub(" *#.*$", "", line)         # strip comments
                sub("^[ \t]+", "", line)        # strip leading whitespace
                sub("[ \t]+$", "", line)        # strip trailing whitespace
                if (line == "")
                    continue
                n = split(line, parts)
                Suffixes[parts[1]]++
                Replacement[parts[1]] = parts[2]
                for (k = 3; k <= n; k++)
                  Replacement[parts[1]]= Replacement[parts[1]] " " parts[k]
            }
            close(file)
        }
    }
    else              # load default table of English suffix regexps
    {
        split("'$ 's$ ed$ edly$ es$ ing$ ingly$ ly$ s$", parts)
        for (k in parts)
        {
            Suffixes[parts[k]] = 1
            Replacement[parts[k]] = ""
        }
    }
}
