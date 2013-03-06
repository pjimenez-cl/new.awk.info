---
layout: default
title: "Using Field Names to Reference Columns"
tags: [tip, gawk, csv]
---

# {{ page.title }}

 *In comp.lang.awk, Janis Papanagnou  comments on how Awk can read a CSV
files where the headers are named in line one.*

## Problem

Suppose you have a a csv file with headers for field names. Gawk can
use those headers for field names- which makes the code more intuitive
and easier to work with. Given that awk is expected to work on tabular
data, this seems to be a good alternative to just field numbers.

## Solution

Try this shell script:
{% highlight sh %}
#!/bin/sh
awk -F, -v cols="${1:?}" '
   BEGIN {
     n=split(cols,col)
     for (i=1; i<=n; i++) s[col[i]]=i
   }
   NR==1 {
     for (f=1; f&lt;=NF; f++)
       if ($f in s) c[s[$f]]=f
     next
   }
   { sep=""
     for (f=1; f&lt;=n; f++) {
       printf("%c%s",sep,$c[f])
       sep=FS
     }
     print ""
   }
'
{% endhighlight %}

This script can be  called  with an arbitrary list of column names as
defined in the first line of your data file and separated by the same
field separator as your data.

For example, suppose the above code is in `bycolname.sh` and we have
data that looks like this:

	hello,world,region_name,foo,bar,xyz,dummy
	11111,22222,aspac,77777,8888888,xyz,zzzzz
	21111,22222,ASPAC,77777,8888888,xyz,zzzzz
	31111,22222,ASPAC,77777,8888888,XYZ,zzzzz
	41111,22222,aspac,77777,8888888,XYZ,zzzzz

Now, calling this command... 
{% highlight sh %}
sh bycolname.sh world,hello
{% endhighlight %}

... would produce:

	22222,11111
	22222,21111
	22222,31111
	22222,41111

## Bugs

Non existing column names will expand to `$0` each, which may be
surprising if there's an unnoticed typo in your field list.
