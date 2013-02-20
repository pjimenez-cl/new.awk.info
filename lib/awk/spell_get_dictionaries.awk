function get_dictionaries(        files, key)
{
    if ((Dictionaries == "") && ("DICTIONARIES" in ENVIRON))
        Dictionaries = ENVIRON["DICTIONARIES"]
    if (Dictionaries == "")     # Use default dictionary list
    {
        DictionaryFiles["/usr/dict/words"]++
        DictionaryFiles["/usr/local/share/dict/words.knuth"]++
    }
    else                        # Use system dictionaries from command line
    {
        split(Dictionaries, files)
        for (key in files)
            DictionaryFiles[files[key]]++
    }
}
