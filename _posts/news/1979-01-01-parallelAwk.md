---
layout: default
title: Parallel Awk
tags: [mpi, external_links, dead_links, TODO]
---

Parallel Awk
============

_From John David Duncan's [parallel-awk.org][link01] site._

Parallel Awk is an effort to link Awk with MPI, enabling the everyday
analysis of large plain-text files to be parallelized, allowing rapid
prototyping of parallel applications, preserving the syntax and style
of Awk, and hiding the details of MPI.

Awk and MPI
-----------

The Awk programming language, first developed at Bell Labs in 1977, is a
standard part of Unix operating system distributions.  It is a compact
language, commonly used in systems administration and in commercial
(as opposed to scientific) computing. The half dozen books about awk
include the original slim and very readable Awk book by Aho, Kernighan,
and Weinberger. Awk is standardized in POSIX, and the most actively
maintained current implementation is GNU awk. While awk, like sed,
is perhaps most often used for "one-liners," its regular expression
handling and rich C-like syntax make it well-suited for many small
applications and domain-specific languages.

MPI is a standard Message Passing Interface for parallel computing created
by the MPI Forum, implemented in two widely-used free distributions
(LAM/MPI and MPICH) and in optimized versions provided by many hardware
vendors. MPI libraries are often linked with Fortran or C code in
scientific computing tasks, such as matrix calculations, and run on
supercomputers or Beowulf clusters.  For some of these applications,
runtime is actually greater than development time; nonetheless, a language
for rapid prototyping is a handy tool to have around.

Example: Calculating Pi
-----------------------

{% highlight awk %}
{% insert_example lib/awk/parallelAwk_pi.awk %}
{% endhighlight %}

pi.awk requires about 20% as many lines of code as its equivalents in
C or Fortran.  The output is printed by the process with RANK = 0 and
looks like this:

	sh% mpiexec -n 4 mpawk -v n=100000 -f pi.awk
	n=100000, pi is 3.14159265359811668006

Status
------

The latest beta release of Parallel Awk is version 0.8. In this release,
any Awk expression (including numbers, strings, and arrays) can be sent
from one process to another using the functions send and recv. The
comm_split() function, an interface to MPI_Comm_split, allows the
creation of intra-communicators, while a companion function comm_set()
is used to set the default MPI communicator implicitly used for all other
MPI operations. Supported collective operations include reduce(), which
can be applied to both numeric and string expressions, and barrier(). A
function called assign() is used to divide the lines of input among the
set of processes, as can a hash() function that is applied to array keys
or other strings.

[link01]: http://parallel-awk.org
