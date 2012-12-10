---
layout: default
title: "Hiding Email Address"
tags: [ fun, auto_converted, working_example, posix ]
---

## {{ page.title }}


## Synopsis

    awk -f cryptosig.awk tim@menzies.us

## Description

Generates a one-line Awk program that can print your email, from a seemingly jumbled string.
This program can then become your email sig and only the Awk cognoscente can generate a reply.
Example:

    $ awk -f cryptosig.awk tim@menzies.us
    BEGIN{a="7059631863556476595569007169";while(a){printf("%c",46+substr(a,1,2));a=substr(a,3)}}

This can be tested as follows:

    $ echo 'BEGIN{a="7059631863556476595569007169";while(a){printf("%c",46+substr(a,1,2));a=substr(a,3)}}' | awk -f -
or

    $ awk -f crypotsig.awk tim@menzies.us | awk -f -

both of which should print "tim@menzies.us".


## Download

[cryptosig.awk]({{ site.baseurl }}/lib/awk/cryptosig.awk)


## Code

{% highlight awk %}
{% insert_example lib/awk/cryptosig.awk %}
{% endhighlight %}


## Author

    BEGIN{a="535170696159626207061118755158656500536563";
    while(a){
    printf("%c",46+substr(a,1,2));a=substr(a,3)};
    print("")
    }

