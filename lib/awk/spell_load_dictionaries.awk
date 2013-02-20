function load_dictionaries(        file, word)
{
    for (file in DictionaryFiles)
    {
        ## print "DEBUG: Loading dictionary " file > "/dev/stderr"
        while ((getline word < file) > 0)
            Dictionary[tolower(word)]++
        close(file)
    }
}
