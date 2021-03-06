---
layout: default
title: "SysAdmins: Awk is Your Friend"
tags: [tip, sysadmin, external_links]
permalink: /tip/sysAdminInAwk.html
---

# {{ page.title }}

*Brian Jones writes at [linux.com][1]:*

The nice thing about humans is that they're at least somewhat
predictable. Given the choice between having data randomly strewn
about, and having it in some predictable pattern, humans will generally
choose predictable patterns (Microsoft filesystem management issues
notwithstanding). These patterns are what make awk, a pattern-matching
programming language, a wonderful tool for systems administrators,
database administrators, and even command-line junkies who use their box
mainly for pleasure. The notion of being able to write a one-line command
to do almost anything draws ever closer with awk in your tool belt.
For most things administrators use awk for, it's an extremely simple
language. As you get into writing more advanced awk scripts, at some
point it becomes a bit cumbersome, and you realize that Perl is also
your friend. But for now, let's focus on how awk can get you the most
bang for your keyboard strokes, shall we?

The first thing you should know is that awk is actually a rather
powerful language. Entire books have been written about its use. If
you're so inclined, you can write extremely complex 1000-line scripts
using awk. However, as a systems administrator (the intended audience for
this article), 99% of your use of awk will consist of relatively short
scripts, and one-off one-liners typed right on the command line. Here's
an example of a common use of awk:

{% highlight sh %}
[jonesy@newhotness jonesy]$ cat access_log | 
     awk '{print $1}' | sort | uniq -c | sort -rn
{% endhighlight %}

The above one-liner uses awk to slim down the amount of data coming
from the web server's access log. The access log is space-delimited,
and I only want to see the first field (hence `print $1`). Once I have
that data, I want to sort it, then I have `uniq -c` provide a count of
each occurrence for each unique value, and then I produce a reverse sort
based on the numeric count provided by `uniq`. The result has the number
of hits in the left column, and the host in the right column, and the
most frequent visitors are at the top of the list. Give it a shot! Even
if you're hosted by an ISP, you should be able to access this log.

Awk is perfect for ripping data into smaller chunks, to make it more
bite-size for other applications or manipulation. To use it on the command
line on files that are not space-delimited, you can use the `-F` flag,
and indicate a delimiter. This is useful for tearing apart `/etc/passwd`
and `/etc/shadow` files. For example:

{% highlight sh %}
[jonesy@tux jonesy]$ cat /etc/passwd | awk -F: '{print $5}' | awk -F, '{print NF}'
{% endhighlight %}

I actually used something kinda similar to that during a NIS to
LDAP migration to see if the gecos field (`$5` in `/etc/passwd`) had
consistent enough data to be useful. One of the tests is to see how
consistent the number of datapoints held in the gecos field is from
record to record. To figure out the number of fields in each record's
gecos field, I tell awk to use `:` as the delimiter, and, based on that,
print the fifth field. I then pipe that to another awk one-liner, which
uses an awk built-in variable, `NF` and a different delimiter (gecos is
generally comma-delimited, if it's even used for useful data).

## Awk in Scripts

When one-liners just aren't enough for you, you can store a whole bunch of
awk one-liners in a file, and call awk with `-f script` to tell it which
file to read its commands from. Additionally, since awk needs to act on
some data, you should also tag on something to take care of feeding awk
the data it so desperately needs. For example, if I have a script called
`getuname`, which looks like this:

{% highlight awk %}
BEGIN { FS=":" }
      {print $1}
{% endhighlight %}

I can now call that script, feeding it anything that I know ahead of time
has the user name as the first field in a given record. So I can say `awk
-f getuname < /etc/passwd`, or `ypcat passwd | awk -f getuname`. There are
two rather important things I did in this script that will save you some
headaches. First, notice the `BEGIN` statement. This statement exists
to give you some space to do some tasks before awk starts reading any
data. In this example, I want awk to know before it processes any data,
that it should use a colon as its field separator. Sure, I could've
called awk differently to get around this, ie `awk -F: -f getuname <
/etc/passwd`, but this way is shorter, and that's the point! It should
also be noted that, if you have the need, you can also have an `END`
section to your script, which will perform any actions, once, after the
last data record has been processed.

On the second line, I've just called a simple awk "action" statement,
just like on the command line, with one important exception: I didn't use
single quotes around it. If I had, the shell would've tried to interpret
this part of the script and choked. I know, because it happened while
I was testing this script. Bad admin!

## Built-in Goodness

Awk has some built-in functions, like most scripting languages, which make
life a bit easier. It also has some built-in variables that awk keeps
track of for you -- and you get their values for free, just for asking,
which is nice. The most useful variable I've had the pleasure to use as
an admin is the `NF` variable, which will tell you, based on the field
separator given (space by default), how many fields are in the current
record. Conversely, the most useful function I've used as an awk scripter
is the `split` function, which can break a single field into another
array of separate fields. First, here's a quick example of `NF` in action:

{% highlight sh %}
cat /etc/passwd | awk -F: '{print NF}'
{% endhighlight %}

This is the lazy man's way to get the users' shells from the `/etc/passwd`
file without having to remember how many fields are in the file. But
wait! This doesn't print the last field in the record! It prints the
number of fields in the record! Simple enough -- add a `$` to the front
of `NF`, and you'll get what you're looking for. Pipe the output to a
couple of `sort` and `uniq` commands like we did earlier with the web log,
and you'll get a snapshot of what the most commonly used shells are.

Now let's have a look at the split function. Let's say you use your
gecos field to store a bunch of datapoints, and the datapoints within
the gecos field are comma-delimited. This is not nearly so contrived as
it might sound -- this happens in more than two environments I've done
work in. Here's what it might look like:

	jonesy:x:12000:13:Brian K. Jones,LUSER,101B,NONE:/home/jonesy:/bin/bash

Now let's say your PHB comes along and says he's tired of referring to
me as `jonesy` and wants to know my real name. You can use awk's `split`
function to help you here, and the code for doing so is fairly short:

{% highlight awk %}
BEGIN { FS=":" }
      {
        gfields = split ( $5, gecos, ",")
        chunkname = split ( gecos[1], fullname, " " )
        print fullname[chunkname], fullname[1]
      }
{% endhighlight %}

Let's translate that into English, shall we? Of course, you now know what
the `BEGIN` statement does here -- nothing new. We'll start by looking at
the `gfields` line, where I use `split` to break up the 5th field of the
record, (the gecos field), using the comma as a delimiter, and storing
all of the resulting fields in an array called `gecos`. This can be
counterintuitive, as you may be tempted to think that the resulting array
is called `gfields`. However, the `gfields` variable actually represents
the last field in the record. You get a look at how this works in the
following two lines. `chunkname` represents the number of fields in the
`fullname` array. The `fullname` array is created by splitting the first
field of the `gecos` array (in this case, the field holding my full
name), using a space as the delimiter. On the next line, I reference
`fullname[chunkname]`, which will print the last name of the person,
even if (as in my case) they have a middle name or initial. Then I print
the very first field in the fullname array, so the output generated by
this script acting on my `passwd` record would be `Jones Brian`.

## In conclusion

Whew! That was a mouthful. Awk has so many cool little hacks and built-in
features that there has been more than one book published just on
Awk. Undoubtedly, I'll utilize some of these features in future articles
that involve putting together syadmin solutions using various scripts
as duct tape.

[1]: http://www.linux.com/archive/articles/113730
