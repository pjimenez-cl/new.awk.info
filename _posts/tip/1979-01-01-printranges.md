---
layout: default
title: "Print Ranges"
tags: [tip, ranges]
---

# {{ page.title }}

*In comp.lang.awk, Ed Morton offers advise on how to print ranges of
Awk records.*

## Problem

Suppose you are  looking to extract a section of code from a text file
based on two regular expressions.

Say the file looks like this:

	newspaper
	magazing

	hiking
	hiking trails in the city
	muir hike
	black mountain hike
	summer meados hike
	end hiking

	phone
	cell
	skype

and you want to extract

	hiking trails in the city
	muir hike
	black mountain hike
	summer meados hike

The following regular expression won't work right:
{% highlight sh %}
awk '/hiking/,/end hiking/{print}' myfile
{% endhighlight %}

since that returns some spurious information.

What do do?

## Solution

Personally, I rarely if ever use

	/start/,/end/

as I'm never immediately sure what it'd output for input such as:

	start
	a
	start
	b
	end
	c
	end

and whenever you want to do something just slightly different with the
selection you need to change the script a lot.

Not being sure of the semantics is probably a catch 22 since I rarely
use it but the benefit of using that syntax vs spelling it out:

	/start/{f=1} f; /end/{f=0}

just doesn't really seem worthwhile, and then if you want to do something
extra like test for some other condition over the block this:

	/start/{f=1} f&&cond; /end/{f=0}

is about as brief as:

	/start/,/end/{if (cond) print}

and if you want to exclude the start (or end) of the block you're printing
then you just move the "f" test to the obvious place and you don't need
to duplicate the condition:

	f; /start/{f=1} /end/{f=0}

vs

	/start/,/end/{if (!/start/) print}

and note the different semantics now. This:

	f; /start/{f=1} /end/{f=0}

will exclude the line at the start of the block you're printing,
whereas this:

	/start/,/end/{if (!/start/) print}

will exclude that line plus every other occurrence of "start" within the
block which is probably not what you'd want. To simply exclude only the
first line of the block but stay with the /start/,/end/ approach you'd
need to do something like:

	/start/,/end/{if (!nr++) print; if (/end/) nr=0}

(which is getting fairly obscure.)
