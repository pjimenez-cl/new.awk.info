---
layout: default
title: "Never write for(i=1;i<=n;i++)... again?"
tags: [tip, for, loop, external_links]
permalink: /tip/noforloops.html
---

# {{ page.title }}

by Jim Hart

I've written this kind of thing

{% highlight awk %}
n = split(something,arr,/re/)
for(i=1;i<=n;i++) {
   print arr[i]
}
{% endhighlight %}

so often, it's tedious. I like this better:

{% highlight awk %}
n = split(something,arr,/re/)
while(n--) {
   print arr[i++]
}
{% endhighlight %}

Easier to type. And, in cases where front-to-back or back-to-front
doesn't matter, it's even simpler:

{% highlight awk %}
# copy a number indexed array, assuming n contains the number of
# elements

while(n--) arr2[n] = arr1[n]
{% endhighlight %}

And, yes,

{% highlight awk %}
for(i in arr1) arr2[i] = arr1[i]
{% endhighlight %}

works, too. But, some loops don't involve arrays. :-)

## Want more?

This tip has been [discussed on comp.lang.awk][1].

[1]: http://groups.google.com/group/comp.lang.awk/browse_thread/thread/41ab815df9df07bd#
