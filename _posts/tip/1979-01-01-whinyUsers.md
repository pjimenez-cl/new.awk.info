---
layout: default
title: "The Secret WHINY_USERS Flag"
tags: [tip, WHINY_USERS]
permalink: /tip/whinyUsers.html
---

# {{ page.title }}

*(Editor's note: On Nov 30'09, Hermann Peifer found and fixed bug in an
older version of the test code at the end of this file.)*

Writing in comp.lang.awk, Ed Morton reveals the secret WHINY_USERS flag.

"Nag" asked:
>Hi,
>
>
>I am creating a file like...

{% highlight awk %}
awk '{
 ....
 ...
 ..
 printf"%4s %4s\n",$1,$2 > "file1"

}' input
{% endhighlight %}

> How can I sort file1 within awk code?

Ed Morton writes: 

> There's also the undocumented WHINY_USERS flag for GNU awk  that allows
> for sorted processing of arrays:

{% highlight sh %}
$ cat file
2
1
4
3
$ gawk '{a[$0]}END{for (i in a) print i}' file
4
1
2
3
$ WHINY_USERS=1 gawk '{a[$0]}END{for (i in a) print i}' file
1
2
3
4
{% endhighlight %}

## Execution Cost

Your editor coded up the following test for the runtime costs of
*WHINY_USERS*. The following code is called twice (once with,
and once without setting *WHINY_USERS*):

{% highlight awk %}
runWhin() {
WHINY_USERS=1 gawk -v M=1000000 --source '
	BEGIN { 
		M = M ? M : 50
		N = M
		print N
		while(N-- > 0) {
			key = rand()" "rand()" "rand()" "rand()" "rand() 
			A[key] = M - N
		}
		for(i in A)
			N++
	}' 
}
runNoWhin() {
gawk -v M=1000000 --source '
	BEGIN { 
		M = M ? M : 50
		N = M
		print N
		while(N-- > 0) {
			key = rand()" "rand()" "rand()" "rand()" "rand() 
			A[key] = M - N
		}
		for(i in A)
			N++
	}' 
}
time runWhin
time runNoWhin
{% endhighlight %}

And the results? Sorted added 15% to runtimes:

{% highlight sh %}
% bash whiny.sh
1000000

real    0m18.897s
user    0m15.826s
sys     0m2.445s
1000000

real    0m16.345s
user    0m13.469s
sys     0m2.435s
{% endhighlight %}

