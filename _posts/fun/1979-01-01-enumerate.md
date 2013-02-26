---
layout: default
title: "Functional Enumeration in Gawk 3.1.7"
tags: [functional, gawk, enumeration]
---

# {{ page.title }}

## Contents

+ [Synopsis](#01)
+ [Description](#02)

	+ [Enumerators](#02.01)

		+ [all(fun,array \[,max\])](#02.01.01)
		+ [collect(fun,array1,array2 \[,max\]](#02.01.02)
		+ [select(fun,array1,array2 \[,max\]](#02.01.03)
		+ [reject(fun,array1,array2 \[,max\]](#02.01.04)
		+ [detect(fun,array \[,max\])](#02.01.05)
		+ [inject(fun,array,carry \[,max\]](#02.01.06)

	+ [Sample Functions](#02.02)
	+ [Using the Functions](#02.03)

+ [Code](#03)

	+ [all](#03.01)
	+ [collect](#03.02)
	+ [select](#03.03)
	+ [reject](#03.04)
	+ [detect](#03.05)
	+ [inject](#03.06)

+ [Bugs](#04)
+ [Author](#05)

## Synopsis ## {#01}

`all( fun, array [,max]`

`collect( fun, array1, array2 [,max])`

`select( fun, array1, array2 [,max])`

`reject( fun, array1, array2 [,max])`

`detect( fun, array [,max])`

`inject( fun, array, carry [,max])`

All these functions return the size of *array* or *array2*

## Description ## {#02}

An interesting new feature in Gawk 3.1.7 is [indirect functions][1].
This allows the function name to be a variable, passed as an argument
to an array, and called using the syntax

	@fun(arg1,arg2,...)    

This enables a new kind of functional programming style in Gawk. For
example, generic enumeration patterns can be coded once, then called
many different ways with different function names passed as arguments.

This document illustrates this style of programming.

### Enumerators ### {#02.01}

For example, here are some standard enumeration functions:

#### all(fun,array \[,max\] #### {#02.01.01}

Applies the function *fun* to all items in the *array*. If called
with the *max* argument, then they are iterated in the order
i=1&nbsp;..&nbsp;*max*, otherwise we use *for(i&nbsp;in&nbsp;a)*.

#### collect(fun,array1,array2 \[,max\]) #### {#02.01.02}

Applies *fun* to each item in *array1* and collects the results in
*array2*.

#### select(fun,array1,array2 \[,max\]) #### {#02.01.03}

Find all the items in *array1* that satisfies *fun* and
add them to *array2*.

#### reject(fun,array1,array2 \[,max\]) #### {#02.01.03}

Find all the items in *array1* that do *not* satisfy *fun* and add them
to *array2*.

#### detect(fun,array \[,max\]) #### {#02.01.04}

Return the first item found in *array* that satisfies *fun*. If no such
item is found, then return the magic global value *Fail*.

#### inject(fun,array,carry \[,max\]) #### {#02.01.05}

(This one is a little tricky.) The result of applying *fun* to each item
in *array* is carried into the processing of the next item. Initially,
the carried value is *carry*. This function returns the final *carry*.

### Sample Functions ### {#02.02}

To illusrate the above, consider the following functions. Each of these
are defined for one array item.

	function odd(x)    { return (x % 2) == 1 }
	function show(x)   { print "[" x "]" }
	function mult(x,y) { return x * y }
	function halve(x)  { return x/2 }

### Using the Functions ### {#02.03}

+ All-ing...

{% highlight awk %}
function do_all(   arr) { 
    split("22 23 24 25 26 27 28",arr)
    all("show",arr)
}
{% endhighlight %}

  When we run this ...

  eg/enum1

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_all() }'

  we see every item in *arr* printed using the above *show* function ...

  eg/enum1.out

	[25]
	[26]
	[27]
	[28]
	[22]
	[23]
	[24]

+ Collect-ing...

{% highlight awk %}
function do_collect(        max,arr1,arr2,i) {
    max=split("22 23 24 25 26 27 28",arr1)
    collect("halve",arr1,arr2,max)
    for(i=1;i&lt;=max;i++) print arr2[i]
}
{% endhighlight %}

  When we run this ...

  eg/enum2

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_collect() }'

  we see every item in *arr* divided in two ...

  eg/enum2.out

	11
	11.5
	12
	12.5
	13
	13.5
	14

+ Select-ing...

{% highlight awk %}
function do_select(        all,less,arr1,arr2,i) {
    all  = split("22 23 24 25 26 27 28",arr1)
    less = select("odd",arr1,arr2,all)
    for(i=1;i&lt;=less;i++) print arr2[i]
}
{% endhighlight %}

  When we run this ...

  eg/enum3

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_select() }'

  we see every item in *arr* that satisfies *odd*....

  eg/enum3.out

	23
	25
	27

+ Reject-ing...

{% highlight awk %}
function do_reject(        all,less,arr1,arr2,i) {
    all  = split("22 23 24 25 26 27 28",arr1)
    less = reject("odd",arr1,arr2,all)
    for(i=1;i&lt;=less;i++) print arr2[i]
}
{% endhighlight %}

  When we run this ...

  eg/enum4

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_reject() }'

  we see every item in *arr* that *do not* satisfies *odd*....

  eg/enum4.out

	22
	24
	26
	28

* Detect-ing

{% highlight awk %}
function do_detect(        all,arr1) {
    all  = split("22 23 24 25 26 27 28",arr1)
    print detect("odd",arr1,all)   
}
{% endhighlight %}

  When we run this ...

  eg/enum5

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_detect() }'

  we see the first item in *arr* that satisfies *odd*....

  eg/enum5.out

	23

+ Inject-ing...

{% highlight awk %}
function do_inject(        all,less,arr1,arr2,i) {
    split("1 2 3 4 5",arr1)
    print inject("mult",arr1,1)
}
{% endhighlight %}

  When we run this ...

  eg/enum6

	gawk317="$HOME/opt/gawk/bin/gawk"
	$gawk317 -f ../enumerate.awk --source 'BEGIN { do_inject() }'

  we see every the result of multiplying every item in *arr* by its
  predecessor.

  eg/enum6.out

	120

## Code ## {#03}

Note one design principle in the following: any newly generated arrays
have indexes *1..max* where *max* is the number of elements in that array.

### all ### {#03.01}

{% highlight awk %}
function all (fun,a,max,   i) {
	if (max) 
		for(i=1;i&lt;=max;i++) @fun(a[i]) 
	else  
		for(i in a) @fun(a[i])
}
{% endhighlight %}

### collect ### {#03.02}

{% highlight awk %}
function collect (fun,a,b,max,   i) {
	if (max)
	    for(i=1;i&lt;=max;i++) {n++; b[i]= @fun(a[i]) }
	else
	    for(i in a) {n++; b[i]= @fun(a[i])}
	return n
}
{% endhighlight %}

### select ### {#03.03}

{% highlight awk %}
function select (fun,a,b,max,   i,n) {
	if (max)
		for(i=1;i&lt;=max;i++) {
		    if (@fun(a[i])) {n++; b[n]= a[i] }}
	else
		for(i in a) {
		    if (@fun(a[i])) {n++; b[n]= a[i] }}
	return n
}
{% endhighlight %}

### reject ### {#03.04}

{% highlight awk %}
function reject (fun,a,b,max,   i,n) {
	if (max)
		for(i=1;i&lt;=max;i++) {
		    if (! @fun(a[i])) {n++; b[n]= a[i] }}
	else
		for(i in a) {
		    if (! @fun(a[i])) {n++; b[n]= a[i] }}
	return n
}
{% endhighlight %}

### reject #### {#03.05}

{% highlight awk %}
BEGIN {Fail="someUnLIKELYSymbol"}
function detect (fun,a,max,   i) {
	if (max)
		for(i=1;i&lt;=max;i++) {
			if (@fun(a[i])) return a[i] }
	else	
		for(i in a) {
			if (@fun(a[i])) return a[i] }
	return Fail
}
{% endhighlight %}

### inject ### {#03.06}

{% highlight awk %}
function inject (fun,a,carry,max,   i) {
	if (max)
		for(i=1;i&lt;=max;i++)
			 carry = @fun(a[i],carry) 
	else
		for(i in a)
			 carry = @fun(a[i],carry) 
	return carry
}
{% endhighlight %}

## Bugs ## {#04}

The above code does not pass around any state information that the *fum*
functions can use. So all their deliberations are either with the current
array values (integers or strings) or with global state. It might be
worthwhile writing new versions of the above with one more argument,
to carry that sate.

## Author ## {#05}

[Tim Menzies](mailto:tim@menzies.us)

[1]: http://groups.google.com/group/comp.lang.awk/browse_thread/thread/7a026a902361cbc5#s
