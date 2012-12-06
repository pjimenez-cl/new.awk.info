---
layout: default
title: Quicksort
tags: [ productive, tutorial, working_example, posix, sorting ]
---

## Quicksort

#### Synopsis

    awk -f quicksort.awk < INPUT-FILE

#### Description

Some Awk implementations come with built in sort routines (e.g. gawk's
asort and asorti functions). But it can be useful to code these yourself,
especially in you are doing data structure tricks.

[Quicksort](http://en.wikipedia.org/wiki/Quicksort) selects a pivot and
divides the data into values above and below the pivot.
Sorting then recurses on these sub-lists.

#### Example

    # `sort -R` will randomize the numbers, AWK will sort them back.
    $ seq 1 5 | sort -R | awk -f quicksort.awk
    1
    2
    3
    4
    5

#### Download

[quicksort.awk]({{site.baseurl}}/lib/awk/quicksort.awk)

#### Code

{% highlight awk %}
{% insert_example lib/awk/quicksort.awk %}
{% endhighlight %}

#### Authors

Alfred Aho, Peter Weinberger, Brian Kernighan, 1988.
