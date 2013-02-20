function scan_options(        k)
{
    for (k = 1; k < ARGC; k++)
    {
        if (ARGV[k] == "-strip")
        {
            ARGV[k] = ""
            Strip = 1
        }
        else if (ARGV[k] == "-verbose")
        {
            ARGV[k] = ""
            Verbose = 1
        }
        else if (ARGV[k] ~ /^=/)        # suffix file
        {
            NSuffixFiles++
            SuffixFiles[substr(ARGV[k], 2)]++
            ARGV[k] = ""
        }
        else if (ARGV[k] ~ /^[+]/)      # private dictionary
        {
            DictionaryFiles[substr(ARGV[k], 2)]++
            ARGV[k] = ""
        }
    }

    # Remove trailing empty arguments (for nawk)
    while ((ARGC > 0) && (ARGV[ARGC-1] == ""))
        ARGC--
}
