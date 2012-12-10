---
layout: default
title: "Columnate"
tags: [ auto_converted,working_example ]
---

## {{ page.title }}


## Synopsis

    gawk -F: -f columnate.awk /etc/passwd

## Description

This script columnates the input file, so that columns line up like in the GNU
column(1) command. Its output is like that of column -t. First, awk reads the 
whole file, keeps track of the maximum width of each field, and saves all the
lines/records. At the END, the lines are printed in columnated format.
If your terminal is not too narrow, you'll get a handsome display of the file.

## Example

    $ gawk -F: -f columnate.awk /etc/passwd
    root    x  0  0      root    /root            /bin/bash
    daemon  x  1  1      daemon  /usr/sbin        /bin/sh
    bin     x  2  2      bin     /bin             /bin/sh
    sys     x  3  3      sys     /dev             /bin/sh
    sync    x  4  65534  sync    /bin             /bin/sync
    games   x  5  60     games   /usr/games       /bin/sh
    man     x  6  12     man     /var/cache/man   /bin/sh
    lp      x  7  7      lp      /var/spool/lpd   /bin/sh
    mail    x  8  8      mail    /var/mail        /bin/sh
    news    x  9  9      news    /var/spool/news  /bin/sh

## Download

[columnate.awk]({{ site.baseurl }}/lib/awk/columnate.awk)


## Code

{% highlight awk %}
{% insert_example lib/awk/columnate.awk %}
{% endhighlight %}


## Author

h-67-101-152-180.nycmny83.dynamic.covad.net

