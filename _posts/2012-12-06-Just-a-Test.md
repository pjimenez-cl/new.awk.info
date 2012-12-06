---
layout: default
title: Just a Test
tags: [test, new, demo]
---

First Post!
===========


Some AWK Code:

{% highlight awk %}
BEGIN {
    sum = 0
}
$2 ~ /Foo/ { sum += $3 }
$3 == /Bar/ { sum += $2 }
{% endhighlight %}
