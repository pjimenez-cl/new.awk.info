function order_suffixes(        i, j, key)
{
    # Order suffixes by decreasing length
    NOrderedSuffix = 0
    for (key in Suffixes)
        OrderedSuffix[++NOrderedSuffix] = key
    for (i = 1; i < NOrderedSuffix; i++)
        for (j = i + 1; j <= NOrderedSuffix; j++)
            if (length(OrderedSuffix[i]) < length(OrderedSuffix[j]))
                swap(OrderedSuffix, i, j)
}
