---
layout: default
title: "Awk++"
tags: [dsl, gawk, awk++]
permalink: /dsl/awkplusplus.html
---

# {{ page.title }}

## Contents

+ [Synopsis](#01)
+ [Download](#02)
+ [Description](#03)

	+ [OO in AWK++](#03.01)
	+ [Syntax](#03.02)

		+ [Samples](#03.02.01)
		+ [Details](#03.02.02)
		+ [Naming and behavior rules](#03.02.03)
		+ [Syntax notes](#03.02.04)

	+ [Multiple Inheritance](#03.03)

+ [Running awk++](#04)
+ [Bugs](#05)
+ [Copyright](#06)
+ [Author](#07)

## Synopsis ## {#01}

{% highlight sh %}
gawk -f awkpp file-name-of-awk++-program
{% endhighlight %}

This command is platform independent and sends the translated program
to standard output (stdout). See *Running awk++* for variations.

This is an updated revision (\#21), released August 1, 2009. In this
new version:

+ The code no longer needs a shell script or batch file to launch awkpp
+ Multiple inheritance improved
+ Added configuration items at the top of the program

This document may be copied only as part of an awk++ distribution and
in unmodified form.

## Download ## {#02}

Download awkpp21.zip from [LAWKER][1].

## Description ## {#03}

Awk++ is a *preprocessor*, that is it reads in a program written in
the awk++ language and outputs a new program. However, it's different
than *awka*. The output from the awk++ preprocessor is awk code, not C
or an executable program. So, some version of AWK, such as awk or gawk,
has to be used to run the preprocessed program. *awka* can be used, in a
second step, to turn the preprocessed awk++ program into an executable,
if desired.

### OO in AWK++ ### {#03.01}

The awk++ language provides object oriented programming for AWK that
includes:

+ classes
+ class properties (persistent object variables)
+ methods
+ inheritance, including multiple inheritance

Awk++ adds new keywords to standard Awk:

+ class
+ method
+ prop
+ property
+ attr
+ attribute
+ elem
+ element
+ var
+ variable

### Syntax ### {#03.02}

#### Samples #### {#03.02.01}

{% highlight awk %}
 a = class1.new[(optional parameters)] *** similar to Ruby
 b = a.get("aProperty")
 a.delete

 class class1 {
 property aProperty
 method new([optional parameters]) {
 # put initialization stuff here
 }

 method get(propName) {
 if(propName = "aProperty")
 return aProperty ### Note the use of 'return'. It behaves
 ### exactly the same as in an AWK function.
 }
 }
{% endhighlight %}

#### Details #### {#03.02.02}

To define a class (similar to C++ but no public/private):

{% highlight awk %}
class class_name {.....}
{% endhighlight %}

To define a class with inheritance:

{% highlight awk %}
class class_name : inherited_class_name [ : inherited_class_name...] {.....}
{% endhighlight %}

To add local/private variables (persistent variables; syntax is unique
to awk++):

{% highlight awk %}
class class_name {
 attribute|attr|property|prop|element|elem|variable|var variable_name
 ..... }
{% endhighlight %}

To help programmers who are used to other OO languages, "attribute",
"property", "element", and "variable", along with their 4-letter
abbreviations, are interchangeable.

Note: these persistent variables cannot be accessed directly. The
programmer must define method(s) to return them, if their values are to
be made available to code that's outside the class.

To add methods

{% highlight awk %}
class class_name {
 attribute variable_name1

 method method_name(parameters) {
 ...any awk code....
 }
 ..other method definitions...
 }
{% endhighlight %}

To create an object

{% highlight awk %}
 object_variable = class_name.new[(optional parameters)]
{% endhighlight %}

(runs the method named "new", if it exists; returns the object ID)

To call an object method

{% highlight awk %}
object_variable.method_name(parameters)
{% endhighlight %}

The dot isn't used for concatenation in awk/gawk, so it's a natural
choice for the separator between the object and method.

To reclaim the memory used by an object, use the delete method, i.e.:

{% highlight awk %}
object_variable.delete
{% endhighlight %}

but don't define delete() in your classes. awk++ recognizes delete()
as a special method and will take care of deleting the object. Deleting
objects is only necessary, though, if they hold a lot of data. Overhead
for objects themselves is insignificant.

#### Naming and behavior rules: #### {#03.02.03}

+ Class names must obey the same rules as user defined function
  names.
+ Method names must follow the same rules as AWK user defined function
  names.
+ Class "local" variables (properties, attributes, etc.) must follow
  the same naming rules as AWK variables.
+ Objects are number variables, so they must obey number variable
  rules. However, the values in variables holding objects should never
  be changed, as they are simply identifiers. Performing math operations
  on them is meaningless.

#### Syntax notes #### {#03.02.04}

OO syntax goals:

+ easy to parse and match to awk code using an awk program as the "preprocessor"
+ easy to understand
+ easy to remember
+ easy and fast to type
+ distinct from existing AWK syntax

The OO syntax is based partly on C++, partly on Javascript, partly on
Ruby and partly on the book "The Object-Oriented Thought Process". It
isn't lifted in toto from one langauage because other languages provide
features that gawk can't accomplish or have syntax that is hard to parse.

### Multiple Inheritance ### {#03.03}

In awk++, if a method is called that isn't in the object's class and
there are inherited classes (superclasses) specified, the inherited
classes are called in left to right order until one of them returns a
value. That value becomes the result of the method call.  This is the
way awk++ resolves the *diamond* problem. As a programmer, you control
the sequence in which superclasses are called by the left to right order
of the list of inherited classes in the class definition.

There are two important things to note.

1. The search will proceed up through as many ancestors as it takes to
   find a matching method.
2. A "match" is made when a value is returned. If a superclass has a
   matching method that returns nothing, the search will continue. Thus,
   it's possible that more than one method could be executed resulting
   in unintended consequences. Be careful!

Calls to undefined methods do nothing and return nothing, silently.

## Running awk++ ## {#04}

The command to preprocess an awk++ program looks like this:

{% highlight sh %}
gawk -f awkpp file-name-of-awk++-program
{% endhighlight %}

or, if the "she-bang" line (line 1 in awkpp) has the right path to gawk,
and awkpp is executable and in a directory in PATH,

{% highlight sh %}
awkpp file-name-of-awk++-program
{% endhighlight %}

To run the output program immediately,

{% highlight sh %}
gawk -f awkpp -r file-name-of-awk++-program [awk options] data-files-to-be-processed
{% endhighlight %}

or

{% highlight sh %}
awkpp -r file-name-of-awk++-program [awk options] data-files-to-be-processed
{% endhighlight %}

When running an awk++ program immediately, standard input (stdin)
cannot be used for data. One or more data file paths must be listed on
the command line.

## Bugs ## {#05}

There is a bug in the standard AWK distributions that affects the
preprocessor.  Additionally, the preprocessor uses the 3rd array option of
the match() function.  So, it's best to use GAWK to run the preprocessor.

On the other hand, the AWK code created by translating awk++ is intended
to work with all versions of AWK. If you find otherwise, please notify
the developer(s).

## Copyright ## {#06}

Copyright (c) 2008, 2009 Jim Hart, jhart@mail.avcnet.org All rights
reserved. The awk++ code is licensed under the GNU Public license (GPL)
any version. awk++ documentation, including this page, may be copied
only in unmodified form, subject to fair use guidelines.

## Author ## {#07}

Jim Hart, jhart@mail.avcnet.org

[1]: http://lawker.googlecode.com/svn/fridge/lib/bash/awk++/version21/awkpp21.zip
