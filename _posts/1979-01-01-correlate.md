---
layout: default
title: "Correlate Numbers"
tags: [ auto_converted, working_example, posix ]
---

## {{ page.title }}


## Synopsis

    cat data | awk -f correlate.awk

## Description

This script calculates the correlation between two columns of numbers.
For more Sherwood scripts, see [Some](http://www.cs.ucsb.edu/~sherwood/awk/)

##### Example

    cat <<EOF | awk -f correlate.awk
    1	1.417600305
    2	2.265271781
    3	3.241368347
    4	4.367711955
    5	5.390612315
    6	6.296879718
    7	7.43218197
    8	8.117831008
    9	9.338019481
    10	10.01823657
    EOF

This outputs:

    NR=10
    ssx=82.5
    ssy=79.0584
    ssxy=80.6985
    r=0.999227


## Download

[correlate.awk]({{ site.baseurl }}/lib/awk/correlate.awk)


## Code

{% highlight awk %}
{% insert_example lib/awk/correlate.awk %}
{% endhighlight %}


## Author

Tim Sherwood

