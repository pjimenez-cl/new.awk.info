---
layout: default
title: "Mawk: faster than C, C++, Java, Perl, Ruby,..."
tags: [mawk, benchmark, big_data, news]
permalink: /news/mawkIsFast.html
---

Mawk: faster than C, C++, Java, Perl, Ruby,...
==============================================

Brendan O'Conner writes in [his blog][1]:

> When one of these new fangled 'Big Data' sets comes your way, the
> very first thing you have to do is data munging: shuffling around file
> formats, renaming fields and the like. Once you're dealing with hundreds
> of megabytes of data, even simple operations can take plenty of time.
>
> For one recent ad-hoc task I had -  reformatting 1GB of textual feature
> data into a form Matlab and R can read - I tried writing implementations
> in several languages, with help from my classmate Elijah.
>
> To be clear,  the problem is to take several files of (item name,
> feature name, value) triples, like:

	000794107-10-K-19960401 limited 1
	000794107-10-K-19960401 colleges 1
	000794107-10-K-19960401 code 2
	...
	004334108-10-K-19961230 recognition 1
	004334108-10-K-19961230 gross 8
	...

> And then rename items and features into sequential numbers as a sparse
> matrix: (i, j, value) triples. Items should count up from inside each
> file; but features should be shared across files, so they need a shared
> counter. Finally, we need to write a mapping of feature IDs back to
> their names for later inspection; this can just be a list.
>
> Since it's a standardized language, many implementations exist. One of
> them, MAWK, is incredibly efficient. It outperforms all other languages,
> including statically typed compiled ones like Java and C++! It wins on
> both LOC and performance criteria- a rare feat indeed, transcending
> the usual competition of slow-but-easy scripting languages versus
> fast-but-hard compiled languages.
>
> All the code, results, and data can be obtained at
> [github.com/brendano/awkspeed][2]. I'd love to see results for more
> languages.

Editor's note: one reply to this blog entry, by Eric Young, optimized
Brendan's Ruby solution  and re-ran all the tests. Eric reported the
following runtimes.  Note that they confirm Brendan's results: mawk runs
faster than everything else.

	 33.8s     mawk
	 36.3s     gcc c
	 51.0s     java
	 67.0s     perl Fletch.pl
	 71.7s     python
	 87.8s     perl
	 95.8s     nawk
	101.4s     gawk
	114.0s     gcc
	133.0s     ruby1.9 eay.rb
	136.8s     ruby1.8 eay.rb
	327.6s     ruby1.8
	372.9s     ruby1.9

[1]: http://anyall.org/blog/2009/09/dont-mawk-awk-the-fastest-and-most-elegant-big-data-munging-language/
[2]: http://github.com/brendano/awkspeed
