---
layout: default
title: " Very, Very, Very Long Strings in Gawk"
tags: [tip, strings, gawk, external_links]
permalink: /tip/bigstring.html
---

# {{ page.title }}

*In this [discussion from comp.lang.awk][1], Martin Cohen builds a really,
really, really long string in Gawk (300 million characters). He writes....*

I had to extract 25-bit fields from a 90MB binary file, with frames of
10,000 fields indicated by a 33-bit sync value. The words I was interested
in were indicated by being preceded by a special tag word.

My first step was to convert the binary file to hex text using od. I
then wrote some gawk code to read the text file and extract the (32-bit)
words preceded by the tag word. There were 9 million of them.

I concatenated them into a single string of 72 million hex characters
(had to do byte-swapping along the way), and then, one character at a
time, converted that into a string of 0's and 1's 300 million characters
long. I could then easily (using index) search for the sync pattern
(independent of any word boundaries) and find the data I wanted.

The total run time was just under 7 minutes (under Red Hat 5.1).

Some optimizations I had to do:

+ To build up the string of 9 million hex words, I had to group them
  256 words at a time before concatenating them to the big string. When
  I just did one word at a time, I took forever - I had to stop it.
+ Similarly, When converting the hex to binary, I converted groups of
  256 characters at a time before appending them to the big binary string.
+ Thinking about it now, I could probably combine the gathering of the
  hex words with the conversion to binary - my program was a revision
  of one where that combining wasn't done.

Anyway, it's nice that gawk can handle really long strings.

## Author

Martin Cohen

[1]: http://groups.google.com/group/comp.lang.awk/browse_thread/thread/59f623358c6c06ed/4686d1dca6a044df#4686d1dca6a044df
